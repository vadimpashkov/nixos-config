{
  imports = [
    ./better-escape.nix
    ./witch-key.nix
    ./lsp.nix
    ./completions.nix
    ./conform.nix
    ./oil.nix
    ./notify.nix
    ./telescope.nix
    ./markdown-preview.nix
    ./todo-comments.nix
    ./commentary.nix
    ./codesnap.nix
    ./diffview.nix
    ./gitsigns.nix
    ./tmux-navigator.nix
    ./zen-mode.nix
  ];

  programs.nixvim.plugins = {
    nix.enable = true;
    web-devicons.enable = true; # Зависимость для многих плагинов
    lualine.enable = true;
    noice.enable = true;
    leap.enable = true;
    codeium-vim.enable = true;
  };
}
