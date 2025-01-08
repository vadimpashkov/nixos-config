{
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            desc = "Neovim";
            block = true;
            for = "unix";
          }
        ];
      };
    };
  };
}
