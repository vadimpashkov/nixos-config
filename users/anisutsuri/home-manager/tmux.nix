{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";

    keyMode = "vi";
    newSession = true;
    baseIndex = 1;
    aggressiveResize = true;
    secureSocket = true;
    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      vim-tmux-navigator
      sessionist
      continuum
      resurrect
    ];

    extraConfig = ''
      set -g mouse on

      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Установим отображение панели сверху
      set-option -g status-position top

      # Нужно для xkbswitch.nvim
      set -g focus-events on

      # Сортировка сессий по имени
      bind s choose-tree -sZ -O name

      # Не выходить из tmux при закрытии сеанса
      set -g detach-on-destroy off

      # Нужно для Zen-Mode
      set-option -g allow-passthrough on

      # Создать вертикальную панель в каталое текущей сессии
      unbind %
      bind '\' split-window -h -c "#{pane_current_path}"

      # Создать горизонтальную панель в каталоге текущей сессии
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      # Для перемещения влево по окнам с Ctrl-[
      bind -n C-[ previous-window

      # Для перемещения вправо по окнам с Ctrl-]
      bind -n C-] next-window

      # Переключение по панелям (Ctrl + клавиши Vim)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Изменить размер панели
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      # Растянуть панель не весь экран
      bind -r m resize-pane -Z

      # Vim мод для клавиш
      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # Отвяжем Escape с "previous window", иначе нереально пользоваться nvim в tmux
      unbind-key -T root Escape
    '';
  };
}
