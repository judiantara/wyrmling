{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # restore host ssh keys
  environment ={
    etc = {
      "ssh/ssh_host_rsa_key".source         = "/nix/persist/etc/ssh/ssh_host_rsa_key";
      "ssh/ssh_host_rsa_key.pub".source     = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      "ssh/ssh_host_ed25519_key".source     = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable    = true;
    allowSFTP = lib.mkForce false;
    settings  = {
      PasswordAuthentication          = false;
      UsePAM                          = false;
      KbdInteractiveAuthentication    = false;
      challengeResponseAuthentication = false;
      X11Forwarding                   = false;
      PermitRootLogin                 = "no";
    };
    extraConfig = ''
      AllowTcpForwarding yes
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  # Open port for SSH
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Start ssh-agent
  programs.ssh.startAgent = true;
}
