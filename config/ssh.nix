{ lib, user, ... }:

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
    enable    = lib.mkForce true;
    allowSFTP = lib.mkForce false;
    settings  = {
      PasswordAuthentication          = lib.mkForce false;
      UsePAM                          = lib.mkForce false;
      KbdInteractiveAuthentication    = lib.mkForce false;
      challengeResponseAuthentication = lib.mkForce false;
      X11Forwarding                   = lib.mkForce false;
      PermitRootLogin                 = lib.mkForce "no";
    };
    extraConfig = ''
      AllowTcpForwarding yes
      AllowAgentForwarding no
      StreamLocalBindUnlink yes
      AllowStreamLocalForwarding yes
      AuthenticationMethods publickey
      HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub
      HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub
      TrustedUserCAKeys /etc/ssh/user_ca.pub

      Match User ${user}
        AcceptEnv *
    '';
  };

  # Open port for SSH
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Start ssh-agent
#   programs.ssh.startAgent = lib.mkForce false;
  programs.ssh.startAgent = true;
}
