{
  programs.nixvim = {
    plugins = {
      twilight.enable = true;
      zen-mode = {
        enable = true;
        settings = {
          window = {
            backdrop = 1;
            width = 1;
          };
          plugins = {
            twilight.enabled = true;
            gitsigns.enabled = true;
            tmux.enabled = true;
            kitty = {
              enabled = true;
              font = "+4";
            };
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>zt";
        action = ":Twilight<CR>";
        options = {
          desc = "Включить/выключить Twilight";
        };
      }
      {
        mode = "n";
        key = "<leader>zz";
        action = ":ZenMode<CR>";
        options = {
          desc = "Включить/выключить Zen Mode";
        };
      }

    ];
  };
}
