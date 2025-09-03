{ pkgs, lib, hostname, ... }:

{
  users.users.cups.extraGroups = [ "ssl" ];

  services.printing = {
    enable = lib.mkForce true;
    listenAddresses = [ "0.0.0.0:631" ];
    openFirewall = true;
    stateless = true;
    extraFilesConf = ''
      CreateSelfSignedCerts no
    '';
  };

  environment.etc."printserver/cupsd.conf" = {
    text = ''
      Listen /run/cups/cups.sock
      DefaultShared Yes
      Browsing No
      WebInterface Yes
      LogLevel info
      ServerName ${hostname}
      ServerAlias ${hostname}.opik ${hostname}.local ${hostname} localhost
      ServerTokens None
      IdleExitTimeout 60
      DefaultAuthType Basic
      DefaultEncryption Required
      DefaultPaperSize A4
      KeepAlive Yes
      AutoPurgeJobs Yes
      PreserveJobHistory No
      PreserveJobFiles No

      <Location />
        Order allow,deny
        Allow localhost
        Allow 192.168.240./24
      </Location>

      <Location /admin>
        Order allow,deny
        Allow localhost
      </Location>

      <Location /admin/conf>
        AuthType Basic
        Require user @SYSTEM
        Order allow,deny
        Allow localhost
      </Location>

      <Policy default>
        JobPrivateAccess default
        JobPrivateValues none
        SubscriptionPrivateAccess default
        SubscriptionPrivateValues none

        <Limit Send-Document Send-URI Hold-Job Release-Job Restart-Job Purge-Jobs Set-Job-Attributes Create-Job-Subscription Renew-Subscription Cancel-Subscription Get-Notifications Reprocess-Job Cancel-Current-Job Suspend-Current-Job Resume-Job Cancel-Job Cancel-Jobs Cancel-My-Jobs Validate-Job Close-Job CUPS-Get-Document CUPS-Authenticate-Job CUPS-Move-Job>
          Require user @OWNER @SYSTEM
          Order deny,allow
        </Limit>

        <Limit Pause-Printer Resume-Printer Set-Printer-Attributes Enable-Printer Disable-Printer Pause-Printer-After-Current-Job Hold-New-Jobs Release-Held-New-Jobs Deactivate-Printer Activate-Printer Restart-Printer Shutdown-Printer Startup-Printer Promote-Job Schedule-Job-After CUPS-Add-Printer CUPS-Delete-Printer CUPS-Add-Class CUPS-Delete-Class CUPS-Accept-Jobs CUPS-Reject-Jobs CUPS-Set-Default>
          AuthType Basic
          Require user @SYSTEM
          Order deny,allow
        </Limit>

        <Limit Cancel-Job CUPS-Authenticate-Job>
          Require user @OWNER @SYSTEM
          Order deny,allow
        </Limit>

        <Limit All>
          Order deny,allow
        </Limit>
      </Policy>
    '';
  };

  systemd.services.cups.serviceConfig = let
    myPreStartScript = pkgs.writeShellApplication {
      name = "cups-pre-start";
      text = ''
        set -euo pipefail

        mkdir -p /etc/cups/ssl

        ${pkgs.coreutils-full}/bin/ln -sf /etc/ssl/certs/host-cert.pem /etc/cups/ssl/${hostname}.crt
        ${pkgs.coreutils-full}/bin/ln -sf /etc/ssl/certs/host-key.pem /etc/cups/ssl/${hostname}.key
        ${pkgs.coreutils-full}/bin/ln -sf /etc/printserver/cupsd.conf /etc/cups/cupsd.conf
      '';
    };
  in {
    ExecStartPre = "+${myPreStartScript}/bin/cups-pre-start";
#     ExecStart    = lib.mkForce [ "" "${pkgs.cups}/sbin/cupsd -l -c /etc/cups/printserver.conf" ];
  };
}

