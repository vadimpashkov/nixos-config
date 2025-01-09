rec {
  username = "anisutsuri";
  hostname = "root";
  profile = "desktop";

  dir = {
    home = "home/${username}";
    config = "${dir.home}/nixos-config";
    shScripts = ./non-nix/sh;
    user = ./users/${username};
    dotfiles = "${dir.user}/dotfiles";
  };
}
