# enable epson L3110 scanner attached to USB, and shared it over network
{ user, ... }:

{
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  hardware.sane = {
    enable = true;
    disabledDefaultBackends = [
      "abaton"
      "agfafocus"
      "apple"
      "artec"
      "artec_eplus48u"
      "as6e"
      "avision"
      "bh"
      "canon"
      "canon630u"
      "canon_dr"
      "canon_lide70"
      "cardscan"
      "coolscan"
      "coolscan3"
      "dell1600n_net"
      "dmc"
      "epjitsu"
      "epsonds"
      "escl"
      "fujitsu"
      "genesys"
      "gt68xx"
      "hp"
      "hp3500"
      "hp3900"
      "hp4200"
      "hp5400"
      "hp5590"
      "hpljm1005"
      "hpsj5s"
      "hs2p"
      "ibm"
      "kodak"
      "kodakaio"
      "kvs1025"
      "kvs20xx"
      "kvs40xx"
      "leo"
      "lexmark"
      "ma1509"
      "magicolor"
      "matsushita"
      "microtek"
      "microtek2"
      "mustek"
      "mustek_usb"
      "mustek_usb2"
      "nec"
      "niash"
      "pie"
      "pieusb"
      "pint"
      "pixma"
      "plustek"
      "qcam"
      "ricoh"
      "ricoh2"
      "rts8891"
      "s9036"
      "sceptre"
      "sharp"
      "sm3600"
      "sm3840"
      "snapscan"
      "sp15c"
      "tamarack"
      "teco1"
      "teco2"
      "teco3"
      "u12"
      "umax"
      "umax1220u"
      "v4l"
      "xerox_mfp"
    ];
  };

  users.users.${user}.extraGroups = [
    "scanner"
    "lp"
  ];

  services.ipp-usb.enable = true;

  services.saned = {
    enable = true;
    extraConfig = ''
      192.168.240.0/24
      data_portrange = 10000 - 10100
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [ 6566 ];
    allowedTCPPortRanges = [
      { from = 10000; to = 10100; }
    ];
  };
}
