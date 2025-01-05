{ pkgs, lib, ... }:

{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      event = "BufWritePre";
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
      formatters_by_ft = {
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        lua = [ "stylua" ];
        nix = [
          [
            "alejandra"
            "nixfmt-rfc-style"
          ]
        ];
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        yaml = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        json = [ "jq" ];
        "_" = [ "trim_whitespace" ];
      };
      formatters = {
        nixfmt-rfc-style = {
          command = "${lib.getExe pkgs.nixfmt-rfc-style}";
        };
        alejandra = {
          command = "${lib.getExe pkgs.alejandra}";
        };
        jq = {
          command = "${lib.getExe pkgs.jq}";
        };
        prettierd = {
          command = "${lib.getExe pkgs.prettierd}";
        };
        stylua = {
          command = "${lib.getExe pkgs.stylua}";
        };
        shellcheck = {
          command = "${lib.getExe pkgs.shellcheck}";
        };
        shfmt = {
          command = "${lib.getExe pkgs.shfmt}";
        };
        shellharden = {
          command = "${lib.getExe pkgs.shellharden}";
        };
      };
    };
  };

}
