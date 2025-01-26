rec {
  username = "anisutsuri";
  hostname = "root";
  profile = "desktop";

  dir = {
    home = "/home/${username}"; # TODO: Нужно этот путь получать из config.home.homeDirectory
    config = "${dir.home}/nixos-config";
    userAbsolute = "${dir.config}/users/${username}"; # TODO: Понять бы как путь, что ниже сделать абсолютным и чтобы его использовать можно было
    user = ./users/${username};
    dotfiles = "${dir.user}/dotfiles";
  };
}
