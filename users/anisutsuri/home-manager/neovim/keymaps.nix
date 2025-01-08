{
  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "jj";
      action = "<Esc>";
    }
    {
      mode = "i";
      key = "оо";
      action = "<Esc>";
    }
    {
      mode = "n";
      key = "<leader>w";
      action = ":w<CR>";
      options = {
        desc = "Сохранить файл";
      };
    }
    {
      mode = "n";
      key = "<leader>q";
      action = ":bd<CR>";
      options = {
        desc = "Закрыть файл";
      };
    }
    {
      action = ":lua vim.lsp.buf.definition()<CR>";
      key = "<leader>gd";
      options = {
        silent = true;
        noremap = true;
        desc = "Go to definition";
      };
    }
    {
      action = ":lua vim.lsp.buf.references()<CR>";
      key = "<leader>gr";
      options = {
        silent = true;
        noremap = true;
        desc = "Go to references";
      };
    }
  ];
}
