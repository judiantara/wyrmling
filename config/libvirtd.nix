{ user, ... }:

{
  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  users.groups.libvirtd.members = [
    "${user}"
  ];

  programs.virt-manager.enable = true;
}
