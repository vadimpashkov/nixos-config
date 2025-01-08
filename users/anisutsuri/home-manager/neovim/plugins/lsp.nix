{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
      nil_ls.enable = true;
      ts_ls.enable = true;
      html.enable = true;
    };
  };
}
