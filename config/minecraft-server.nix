{ inputs, lib, pkgs, ... }:
let
  # Pin JRE versions used by instances
#   jre8  = pkgs.temurin-bin-8;
#   jre17 = pkgs.temurin-bin-17;
  jre21 = pkgs.temurin-bin-21;

  jvmOpts = lib.concatStringsSep " " [
    "-Djava.awt.headless=true"
    "-XX:+UseG1GC"
    "-XX:+ParallelRefProcEnabled"
    "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions"
    "-XX:+DisableExplicitGC"
    "-XX:+AlwaysPreTouch"
    "-XX:G1NewSizePercent=40"
    "-XX:G1MaxNewSizePercent=50"
    "-XX:G1HeapRegionSize=16M"
    "-XX:G1ReservePercent=15"
    "-XX:G1HeapWastePercent=5"
    "-XX:G1MixedGCCountTarget=4"
    "-XX:InitiatingHeapOccupancyPercent=20"
    "-XX:G1MixedGCLiveThresholdPercent=90"
    "-XX:G1RSetUpdatingPauseTimePercent=5"
    "-XX:SurvivorRatio=32"
    "-XX:+PerfDisableSharedMem"
    "-XX:MaxTenuringThreshold=1"
  ];

  defaults = {
    # Only people in the Cool Club (tm)
    white-list = false;

    # So I don't have to make everyone op
    spawn-protection = 0;

    # 5 minutes tick timeout, for heavy packs
    max-tick-time = 5 * 60 * 1000;

    # It just ain't modded minecraft without flying around
    allow-flight = true;
  };
in {
  imports = [ inputs.mms.module ];

  services.modded-minecraft-servers = {
    eula = true;
    instances = {
      skyfactory = {
        enable = true;
        inherit jvmOpts;
        jvmMaxAllocation = "8G";
        jvmInitialAllocation = "2G";
        jvmPackage = jre21;
        serverConfig = defaults // {
          server-port = 25565;
          rcon-port = 25566;
          motd = "Opik SkyFactory";
          extra-options.level-type = "voidworld";
        };
        rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6G07AT9uNhUY7adp58KvhKfWajWOJNLIArqOfzlxG5"
        ];
      };
    };
  };
}
