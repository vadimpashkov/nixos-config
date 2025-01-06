{
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    # inputs.ags.homeManagerModules.default
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/neovim
    ../../modules/home-manager/zoxide.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/yazi.nix
    # ../../modules/home-manager/ags/default.nix
  ];

  home.stateVersion = "24.11";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home.packages = with pkgs; [
    # GUI
    wayland
    xwayland
    hyprland
    wl-clipboard

    # Fonts
    jetbrains-mono
    nerdfonts

    # Dev
    kitty
    figma-linux
    patchelf # Для упаковки бинарных файлов

    # Terminal Utils
    killall
    ripgrep
    lazygit
    eza
    bat
    fd
    thefuck
    tlrc

    # Main
    google-chrome
    telegram-desktop
    obsidian
    discord
    keepassxc

    # VPN
    wireguard-tools
    openvpn

    # Other
    pavucontrol
    helvum
  ];
}
