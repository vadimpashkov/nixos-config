{
  programs.nixvim = {
    plugins.commentary.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>/";
        action = ":Commentary<CR>";
        options = {
          desc = "Закомментировать строку";
        };
      }
      {
        mode = "v";
        key = "<leader>/";
        action = ":Commentary<CR>";
        options = {
          desc = "Закомментировать выделенный код";
        };
      }
    ];
  };
}
