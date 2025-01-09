{
  pkgs,
  outputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "—delete-older-than 30d";
    };
  };
  networking.hostName = outputs.globalConfig.hostname;

  environment = {
    systemPackages = [
      pkgs.home-manager
    ];

    sessionVariables = {
      TERMINAL = outputs.userConfig.terminal.name;
      VISUAL = outputs.userConfig.editor.name;
      EDITOR = outputs.userConfig.editor.name;
    };
  };

  services.getty.autologinUser = outputs.globalConfig.username;
}
