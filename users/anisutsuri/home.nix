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
    ./home-manager/tmux
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
      inputs.updater.packages.${pkgs.system}.default
      inputs.screenshot.packages.${pkgs.system}.default
      inputs.vpn-manager.packages.${pkgs.system}.default

      # Main
      google-chrome
      telegram-desktop
      discord
      keepassxc

      # Other
      pavucontrol
      helvum
    ];
  };
}
