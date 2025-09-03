{ config, lib, pkgs, ... }:

{
  networking.networkmanager.dispatcherScripts = lib.mkIf (config.users.judiantara.home-manager.enable) [
    {
      source = pkgs.writeText "syncthing-wired-control" ''
        #!/bin/sh
        INTERFACE=$1
        ACTION=$2

        TARGET_USER="judiantara"
        USER_UID=1000

        # Restrict strictly to wired LAN interfaces (en*, eth*)
        if echo "$INTERFACE" | grep -qE "^(en|eth)"; then
            if [ "$ACTION" = "up" ]; then
                # Run the check in a background subshell so it doesn't block
                # NetworkManager's startup sequence, waiting for KDE to initialize.
                (
                    counter=0
                    # Wait up to 30 seconds for the user's runtime and graphical session to settle
                    while [ $counter -lt 30 ]; do
                        if [ -d "/run/user/$USER_UID" ] && /run/wrappers/bin/su - "$TARGET_USER" -c "XDG_RUNTIME_DIR=/run/user/$USER_UID ${pkgs.systemd}/bin/systemctl --user is-system-running --quiet" 2>/dev/null; then
                            break
                        fi
                        sleep 1
                        counter=$((counter + 1))
                    done

                    # Once KDE user session is active, start Syncthing
                    if [ -d "/run/user/$USER_UID" ]; then
                        echo "Starting syncthing service"
                        /run/wrappers/bin/su - "$TARGET_USER" -c "XDG_RUNTIME_DIR=/run/user/$USER_UID ${pkgs.systemd}/bin/systemctl --user start syncthing.service"
                        sleep 5
                        /run/wrappers/bin/su - "$TARGET_USER" -c "XDG_RUNTIME_DIR=/run/user/$USER_UID ${pkgs.systemd}/bin/systemctl --user start syncthing-init.service"
                    fi
                ) &

            elif [ "$ACTION" = "down" ]; then
                # Immediate stop when the cable is unplugged later
                if [ -d "/run/user/$USER_UID" ]; then
                    echo "Stopping synchthing service"
                    /run/wrappers/bin/su - "$TARGET_USER" -c "XDG_RUNTIME_DIR=/run/user/$USER_UID ${pkgs.systemd}/bin/systemctl --user stop syncthing-init.service syncthing.service"
                fi
            fi
        fi
      '';
    }
  ];
}
