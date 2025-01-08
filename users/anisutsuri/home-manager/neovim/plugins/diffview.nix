{
  programs.nixvim = {
    plugins.diffview.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>gdc";
        action = ":DiffviewClose<CR>";
        options = {
          desc = "Закрыть разницу Git";
        };
      }
      {
        mode = "n";
        key = "<leader>gdo";
        action = ":DiffviewOpen<CR>";
        options = {
          desc = "Открыть разницу Git";
        };
      }
    ];
  };
}
