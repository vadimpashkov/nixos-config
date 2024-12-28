# NixOS Config

Этот репозиторий содержит модульную конфигурацию для NixOS, разработанную с использованием flakes. Он поддерживает несколько хостов и пользователей, включая интеграцию с Home-Manager для настройки пользовательских окружений.

---

## Возможности

-   **Поддержка нескольких хостов:** Легко настраивайте разные машины с уникальными параметрами.
-   **Индивидуальные пользовательские настройки:** Каждый пользователь может иметь собственные параметры, такие как часовой пояс и окружение Home-Manager.
-   **Модульность:** Конфигурация разбита на переиспользуемые модули для упрощения поддержки.
-   **Wayland и Hyprland:** Полная поддержка Wayland и оконного менеджера Hyprland.
-   **Интеграция Home-Manager:** Легкая настройка окружения пользователя.

---

## Структура каталога

```plaintext
nixos-config/
├── flake.nix                # Основной файл flakes-конфигурации
├── modules/                 # Общие модули для системы
│   ├── boot.nix             # Настройки загрузки
│   ├── global-settings.nix  # Общие параметры (например, системные переменные)
│   ├── hyprland.nix         # Настройки для Hyprland
│   ├── nvidia.nix           # Драйверы NVIDIA
│   └── packages.nix         # Установленные пакеты
├── hosts/                   # Хост-специфичные конфигурации
│   ├── desktop/             # Конфигурация для хоста desktop
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
├── users/                   # Настройки пользователей
│   ├── anisutsuri/          # Конфигурация пользователя anisutsuri
│   │   ├── settings.nix     # Системные параметры пользователя
│   │   ├── home.nix         # Настройки Home-Manager пользователя
└── LICENSE                  # Лицензия
```

---

## Как использовать

### 1. Клонируйте репозиторий

Начните с клонирования репозитория на вашу локальную машину:

```bash
git clone https://github.com/vadimpashkov/nixos-config.git
cd nixos-config
```

---

### 2. Настройте хост

1. Создайте конфигурацию для нового хоста:

    Скопируйте существующую директорию хоста в папке `hosts/` и измените её имя:

    ```bash
    cp -r hosts/desktop hosts/new-host
    ```

2. Сгенерируйте файл `hardware-configuration.nix` для нового хоста:

    ```bash
    nixos-generate-config --dir ./hosts/new-host
    ```

    **Примечание:** Если файл `configuration.nix` уже существует, команда `nixos-generate-config` не перезапишет его. Вы увидите предупреждение: `warning: not overwriting existing configuration.nix`. Это поведение нормально и не требует действий, если ваша текущая конфигурация уже настроена. Если вы хотите обновить конфигурацию, удалите или переместите существующий файл перед выполнением команды.

3. Добавьте сгенерированные файлы в Git:

    ```bash
    git add .
    ```

    **Важно:** Flakes требуют, чтобы все файлы, упомянутые в конфигурации, были добавлены в Git. Если этого не сделать, при сборке конфигурации может возникнуть ошибка.

4. Измените файл `configuration.nix` для настройки параметров нового хоста. Пример:

    ```nix
    { config, pkgs, hostname, stateVersion, ... }:

    {
      imports = [
        ../../modules/global-settings.nix
        ../../modules/packages.nix
        ../../modules/boot.nix
        ../../modules/nvidia.nix
        ../../modules/hyprland.nix
      ];

      networking.hostName = hostname;
      system.stateVersion = stateVersion;

      networking.networkmanager.enable = true;
    }
    ```

5. Добавьте хост в файл `flake.nix`:

    ```nix
    { hostname = "new-host"; stateVersion = "24.11"; users = [ "newuser" ]; }
    ```

---

### 3. Настройте пользователя

1. Создайте директорию для нового пользователя в папке `users/`:

    ```bash
    mkdir -p users/newuser
    ```

2. Создайте файлы `settings.nix` и `home.nix` для пользователя. Пример:

    **settings.nix**:

    ```nix
    { username, ... }:

    {
      users.users.${username} = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = [ "networkmanager" "wheel" ];
      };

      time.timeZone = "Europe/Moscow";
    }
    ```

    **home.nix**:

    ```nix
    { pkgs, username, ... }:

    {
      home.stateVersion = "24.11";

      home.username = username;
      home.homeDirectory = "/home/${username}";

      home.packages = with pkgs; [
        kitty
        wayland
        xwayland
        hyprland
        wl-clipboard
        waybar
      ];
    }
    ```

3. Добавьте пользователя в соответствующий хост в `flake.nix`:

    ```nix
    { hostname = "new-host"; stateVersion = "24.11"; users = [ "newuser" ]; }
    ```

---

### 4. Примените конфигурацию

#### Для системы

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

#### Для пользователя (Home-Manager)

```bash
home-manager switch --flake .#<username>
```

---

## Решение проблем

### Распространённые ошибки

1. **Неправильное имя хоста или пользователя:**
   Проверьте, что `hostname` и `username` совпадают с именами, указанными в `flake.nix`.

2. **Аппаратные проблемы:**
   Пересоздайте `hardware-configuration.nix`, если аппаратное обеспечение изменилось:

    ```bash
    nixos-generate-config --dir ./hosts/<hostname>
    ```

3. **Ошибка отсутствующего файла:** Если появляется ошибка вида `error: path '<path>' does not exist`, убедитесь, что все файлы, упомянутые в конфигурации, добавлены в Git:

    ```bash
    git add .
    ```

---

## Лицензия

Этот проект является open-source и доступен под лицензией MIT.
