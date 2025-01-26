{
  pkgs,
  outputs,
  ...
}: {
  programs.tmux = {
    enable = true;

    shell = "${pkgs.zsh}/bin/zsh";

    # terminal = "screen-256color";

    # keyMode = "vi";
    # newSession = true;
    # baseIndex = 1;
    # aggressiveResize = true;
    # shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      # catppuccin
      vim-tmux-navigator # Чтобы в nvim и tmux можно было на Ctrl+h/j/k/l переключаться между панелями
      # sessionist # Добавляет команды и горячие клавиши для более удобной работы с сессиями
      resurrect # Сохраняет и восстанавливает сессии вместе с их состоянием (окна, панели, команды) - делает это только "по запросу" пользователя (через команды)
      continuum # Автоматически восстанавливает и сохраняет сессии (использует функционал плагина resurrect)
      # fingers # Быстрое копирование без входа в режим копирования (<prefix>f и далее подсвечивает что скопировать)
    ];

    extraConfig = ''
      unbind -a # Отвязать ВСЕ клавиши

      set -g default-terminal 'screen-256color' # Поддержка цветов (самим tmux)
      set -g terminal-overrides '*:Tc' # Поддержка цветов (TrueColor)
      set -g mouse on # Включить мышь
      set -g prefix C-Space # Новое сочетание клавиш для <Prefix>
      set -g base-index 1 # Чтобы индексация окон начиналась с 1, а не с 0
      set -g escape-time 0 # Убрать задержку после нажатия на Escape
      set -g history-limit 100000 # Увеличение истории с 2000 до 100000
      set -g renumber-windows on # Подгонять номера окон, когда одно из окон будет закрыта
      set -g detach-on-destroy off # Не выходить из tmux при выключении сеанса
      set -g allow-passthrough on # Нужен для Zen-Mode в nvim
      set -g set-clipboard on # Использовать системный буфер
      set -g display-time 4000 # Сообщения tmux отображаются не 750, а 4000 мс.
      set -g status-interval 5 # Обновляем строку состояние не каждые 15 секунд, а каждые 5 секунд
      set -g focus-events on # Включаем поддержку событий фокуса (чтобы тот же nvim мог реагировать на смену окон в tmux)
      set -g aggressive-resize on # Заставляет окна сразу адаптироваться к изменению размера терминала (иначе если перекидывать консоль с одного монитора на другой - будет баг)
      set -g status-position top # Переместить панель наверх
      set -g status-right ""

      setw -g mode-keys vi # Установить управление как в Vim для всех окон

      set -g @continuum-boot 'on' # Запуск tmux при входе в систему
      set -g @continuum-save-interval '5'  # Сохранение сессий каждые 5 минут

      set -g @fingers-key 'f' # Запуск копирование по шаблонам (регуляркам)

      bind : command-prompt # Открыть командную строку
      bind '\' split-window -h -c "#{pane_current_path}" # Создать вертикальную панель в каталое текущей сессии
      bind - split-window -v -c "#{pane_current_path}" # Создать горизонтальную панель в каталоге текущей сессии
      bind [ previous-window # Для перемещения влево по окнам
      bind ] next-window # Для перемещения вправо по окнам
      bind a last-window # Переключиться на последнее активное окно
      bind r command-prompt "renamew %%"
      bind C-w new-window -c "${outputs.globalConfig.dir.userAbsolute}/" # Создать новое окно
      bind -r j resize-pane -D 5 # Изменить размер панели вниз на 5
      bind -r k resize-pane -U 5 # Изменить размер панели вверх на 5
      bind -r l resize-pane -R 5 # Изменить размер панели вправо на 5
      bind -r h resize-pane -L 5 # Изменить размер панели влево на 5
      bind z resize-pane -Z # Растянуть панель не весь экран
      bind x swap-pane -D # Обмен с панелью ниже по индексу
      bind X swap-pane -U # Обмен с панелью выше по индексу
      bind N break-pane # Переместить текущую панель в новое окно
      bind c kill-pane # Закрыть панель
      bind ? display-popup -E "less -R ${outputs.globalConfig.dir.userAbsolute}/home-manager/tmux/cheat-sheet.txt" # Показать собственную справку по сочетанию клавиш
      bind * setw synchronize-panes # Включает или выключает режим синхронизации панелей (когда режим синхронизации включён, команды, вводимые в одной панели, отправляются во все панели в текущем окне)

      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5
      bind 6 select-window -t 6
      bind 7 select-window -t 7
      bind 8 select-window -t 8
      bind 9 select-window -t 9
      bind 0 select-window -t 0

      bind s choose-tree -sZ -O name # Показать дерево сессий отсортерованных по наименованию
      bind w choose-window -sZ # Показать дерево окон текущей сессии
      bind f command-prompt "find-window '%%'" # Найти окно/панель
      bind F command-prompt "switch-client -t %%" # Найти сессию

      bind C-s new-session # Создать новую сессию
      bind C kill-session # Закрыть сессию
      bind A switch-client -l # Переключиться на предыдущую сессию

      bind y copy-mode # Активировать мод копирования

      bind -T copy-mode-vi v send -X begin-selection # Начать выделение текста (как v в nvim)
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle # Начать выделение текста (как V в vim)
      bind -T copy-mode-vi y send -X copy-selection # Скопировать выделенный текст в буффер обмена
      bind -T copy-mode-vi q send -X cancel # Выход из режима копирования
      bind -T copy-mode / send -X search-forward # Поиск по регулярному выражению вниз
      bind -T copy-mode ? send -X search-backward # Поиск по регулярному выражению вверх

      # --- ↓ Настройка vim-tmux-navigator ↓ ---

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

      bind -n C-h if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind -n C-j if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind -n C-k if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind -n C-l if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
      bind -n 'C-\' if-shell "$is_vim" 'send-keys C-\\' 'select-pane -l'

      bind -T copy-mode-vi 'C-h' select-pane -L
      bind -T copy-mode-vi 'C-j' select-pane -D
      bind -T copy-mode-vi 'C-k' select-pane -U
      bind -T copy-mode-vi 'C-l' select-pane -R
      bind -T copy-mode-vi 'C-\' select-pane -l

      # --- ↑ Настройка vim-tmux-navigator ↑ ---
    '';
  };
}
