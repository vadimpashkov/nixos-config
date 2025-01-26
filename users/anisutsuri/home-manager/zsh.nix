{
  pkgs,
  outputs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh/history";
    };

    shellAliases = {
      "c" = "clear";
      "e" = "exit";
      "code" = "nvim";
      "ls" = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      "lg" = "lazygit";
      "help" = "tldr";
      "usys" = "updater ${outputs.globalConfig.dir.config} system ${outputs.globalConfig.profile}";
      "uhm" = "updater ${outputs.globalConfig.dir.config} hm ${outputs.globalConfig.username}";
      "vpn" = "vpn-manager";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "robbyrussell";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = outputs.globalConfig.dir.dotfiles;
        file = "p10k.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    initExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        dbus-run-session Hyprland
      fi
      bindkey -v
      bindkey ^R history-search-backward
      bindkey ^S history-search-forward

      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false

      # set descriptions format to enable group support
      # NOTE: don't use escape sequences here, fzf-tab will ignore them
      zstyle ':completion:*:descriptions' format '[%d]'

      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no

      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'

      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'

      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups

      # --- fzf (нечеткий поиск) ---

      eval $(fzf --zsh)

      # ---- Использование fd в fzf ----

      export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      # ---- Настройка bat и eza в fzf ----

      export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export|unset) fzf --preview "eval 'echo {}'"         "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }

      # ---- Настройка tmux для fzf ----
      export FZF_TMUX_OPTS=" -p90%,70% "

      # --- thefuck (подсказка, если ошибся при вводе комманды в консоль) ---

      eval $(thefuck --alias fk)
    '';
  };
}
