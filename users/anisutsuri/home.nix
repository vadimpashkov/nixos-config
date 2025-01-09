{
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.default
    ./home-manager/ssh.nix
    ./home-manager/git.nix
    ./home-manager/stylix.nix
    ./home-manager/hyprland.nix
    ./home-manager/hyprlock.nix
    ./home-manager/hypridle.nix
    ./home-manager/kitty.nix
    ./home-manager/rofi.nix
    ./home-manager/neovim
    ./home-manager/zoxide.nix
    ./home-manager/fzf.nix
    ./home-manager/zsh.nix
    ./home-manager/tmux.nix
    ./home-manager/yazi.nix
    ./home-manager/obsidian.nix
    ./home-manager/swappy.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.11";

    username = username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # GUI
      wayland
      xwayland
      hyprland
      wl-clipboard
      inputs.swww.packages.${pkgs.system}.swww

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
      discord
      keepassxc

      # VPN
      wireguard-tools
      openvpn

      # Other
      pavucontrol
      helvum
    ];
  };
}
