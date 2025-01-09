{
  imports = [
    ./globals.nix
    ./options.nix
    ./keymaps.nix
    ./plugins
    ./actions
  ];

  programs.nixvim = {
    enable = true;
    # colorschemes.catppuccin.enable = true;
  };
}
