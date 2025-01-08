{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings = {
        mapping = [
          {
            mode = "n";
            key = "o";
            action = "actions.select_default";
          }
        ];
      };
    };
    keymaps = [
      {
        key = "<leader>sf";
        action = ":Telescope find_files<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Найти файл";
        };
      }
      {
        key = "<leader>sg";
        action = ":Telescope live_grep<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Поиск grep";
        };
      }
      {
        key = "<leader>sb";
        action = ":Telescope buffers<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Найти вкладку (buffers)";
        };
      }
      {
        key = "<leader>sc";
        action = ":Telescope commands<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Найти комманду";
        };
      }
      {
        key = "<leader>oc";
        action = ":Telescope command_history<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Открыть список комманд";
        };
      }
      {
        key = "<leader>d";
        action = ":Telescope diagnostics<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Открыть диагностику";
        };
      }
      {
        key = "<leader>ql";
        action = ":Telescope quickfix<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Открыть quickfix лист";
        };
      }
      {
        key = "<leader><leader>";
        action = ":Telescope oldfiles<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Открыть список ранее открытых файлов";
        };
      }
    ];
  };
}
