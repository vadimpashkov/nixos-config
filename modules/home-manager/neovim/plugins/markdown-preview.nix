{
  programs.nixvim = {
    plugins.markdown-preview.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>md";
        action = ":MarkdownPreviewToggle<CR>";
        options = {
          desc = "Открыть/закрыть просмотрщик .md файлов";
        };
      }
    ];
  };
}
