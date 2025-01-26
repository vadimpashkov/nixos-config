{pkgs, ...}: let
  gitSyncObsidian = pkgs.writeScriptBin "git-sync-obsidian" ''
    #!/bin/sh

    VAULT_DIR="$HOME/knowledgebase"
    cd $VAULT_DIR || exit 1
    git add .
    git commit -m "Sync $(date '+%d-$m-%Y %H:%M')" || exit 0
  '';
in {
  home.packages = [pkgs.obsidian gitSyncObsidian];

  systemd.user.services.git-sync-obsidian = {
    Unit = {
      Description = "Sync Obsidian Vault with GitHub";
      Wants = "git-sync-obsidian.timer";
    };
    Service = {
      ExecStart = "${gitSyncObsidian}/bin/git-sync-obsidian";
      Type = "simple";
    };
  };

  systemd.user.timers.git-sync-obsidian = {
    Unit.Description = "Run Git Sync for Obsidian Vault";
    Timer.OnCalendar = "*:0/15"; # Раз в сколько минут запускать скрипт
    Install.WantedBy = ["timers.target"];
  };
}
