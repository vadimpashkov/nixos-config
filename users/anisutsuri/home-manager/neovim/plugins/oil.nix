{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        float = {
          max_width = 50;
        };
        view_options = {
          show_hidden = true;
        };
        keymaps = {
          "<Esc>" = "actions.close";
          "l" = "actions.select";
          "h" = "actions.parent";
          "." = "actions.toggle_hidden";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Oil --float<CR>";
        options = {
          desc = "Открыть панель навигации";
        };
      }
    ];
  };
}
