{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # restore host ssh keys
  environment ={
    etc = {
      "ssh/ssh_host_rsa_key".source              = "/nix/persist/etc/ssh/ssh_host_rsa_key";
      "ssh/ssh_host_rsa_key.pub".source          = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      "ssh/ssh_host_rsa_key-cert.pub".source     = "/nix/persist/etc/ssh/ssh_host_rsa_key-cert.pub";
      "ssh/ssh_host_ed25519_key".source          = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source      = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
      "ssh/ssh_host_ed25519_key-cert.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key-cert.pub";
      "ssh/user_ca.pub".text                     = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYc3UbzHDuwd3+8p1jsaIvcD0I61nEEsKDeYCDDm2fh User SSH Certificate Authority for Opik Network'';
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
      HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub
      HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub
      TrustedUserCAKeys /etc/ssh/user_ca.pub
    '';
  };

  # Open port for SSH
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Start ssh-agent
  programs.ssh.startAgent = true;
}
