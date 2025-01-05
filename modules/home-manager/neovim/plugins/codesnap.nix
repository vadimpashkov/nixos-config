{
  programs.nixvim = {
    plugins.codesnap = {
      enable = true;
      settings = {
        save_path = "~/Pictures/CodeSnap";
        has_breadcrumbs = false;
        has_workspace = false;
        has_line_number = true;
        mac_window_bar = false;
        code_font_family = "JetBrainsMono Nerd Font";
        bg_theme = "dusk";
        watermark = "";
      };
    };
    keymaps = [
      {
        mode = "x";
        key = "<leader>cc";
        action = ":CodeSnap<CR>";
        options = {
          desc = "Сохранить выделенный код в буфер";
        };
      }
      {
        mode = "x";
        key = "<leader>cs";
        action = ":CodeSnapSave<CR>";
        options = {
          desc = "Сохранить выделенный код в папку";
        };
      }
    ];
  };
}
