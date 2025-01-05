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
    ../../modules/home-manager/waybar/default.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/neovim/default.nix
    # ../../modules/home-manager/ags/default.nix
  ];

  home.stateVersion = "24.11";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.packages = with pkgs; [
    # GUI
    wayland
    xwayland
    hyprland
    wl-clipboard
    waybar

    # Fonts
    jetbrains-mono
    nerdfonts

    # Dev
    kitty
    figma-linux

    # Terminal Utils
    killall
    ripgrep
    lazygit

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
