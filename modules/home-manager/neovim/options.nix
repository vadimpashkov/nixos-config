{
  programs.nixvim.opts = {

    number = true;
    relativenumber = true;

    signcolumn = "yes";

    mouse = "a";
    mousefocus = true;

    clipboard = "unnamedplus";
    undofile = true;

    ignorecase = true;
    smartcase = true;

    # Перенос строк
    wrap = false;

    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 0;
    expandtab = true;
    smarttab = true;

    list = true;
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

    timeoutlen = 200;

    cursorline = true;

    ruler = true;

    gdefault = true;

    scrolloff = 5;
  };
}
