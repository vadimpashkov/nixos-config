{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      icons = {
        breadcrumb = "»";
        group = "+";
        separator = ""; # ➜
      };
      spec = [
        {
          __unkeyed-1 = "<leader>f";
          mode = "n";
          group = "+найти";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>o";
          mode = "n";
          group = "+открыть";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>g";
          mode = "n";
          group = "+git";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>c";
          mode = "n";
          group = "+работа с кодом";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>fs";
          mode = "n";
          group = "+символ";
          icon = "󱔁";
        }
        {
          __unkeyed-1 = "<leader>m";
          mode = "n";
          group = "+markdown";
          icon = "";
        }

      ];
    };

  };
}
