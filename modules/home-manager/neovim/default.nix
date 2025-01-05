{
  imports = [
    ./globals.nix
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
  };
}
