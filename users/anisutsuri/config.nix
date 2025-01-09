{pkgs, ...}: {
  editor = {
    name = "nvim";
    pkgs = pkgs.nixvim;
  };
  terminal = {
    name = "kitty";
    pkgs = pkgs.kitty;
  };
}
