{
  programs.nixvim = {
    plugins.todo-comments = {
      enable = true;
      settings = {
        keywords = {
          FIX = {
            icon = " ";
            color = "error";
            alt = [
              "FIXME"
              "BUG"
              "FIXIT"
              "ISSUE"
            ];
          };
          TODO = {
            icon = " ";
            color = "info";
          };
          HACK = {
            icon = " ";
            color = "warning";
          };
          WARN = {
            icon = " ";
            color = "warning";
            alt = [
              "WARNING"
              "XXX"
            ];
          };
          NOTE = {
            icon = " ";
            color = "hint";
            alt = [
              "INFO"
              "REMARK"
            ];
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ot";
        action = ":TodoTelescope<CR>";
        options = {
          desc = "Открыть список TODO";
        };
      }
      # TODO Надо дописать action
      {
        mode = "n";
        key = "<leader>]t";
        action = ":<CR>";
        options = {
          desc = "Перейти к следующему TODO комментарию";
        };
      }
      # TODO Надо дописать action
      {
        mode = "n";
        key = "<leader>[t";
        action = ":<CR>";
        options = {
          desc = "Перейти к предыдущему TODO комментарию";
        };
      }
    ];
  };
}
