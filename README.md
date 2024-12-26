# NixOS Config

Этот репозиторий содержит модульную конфигурацию для NixOS, разработанную для поддержки нескольких хостов и пользователей. Каждому хосту можно задать уникальные настройки, а пользователям — индивидуальные часовые пояса и окружение, управляемое с помощью Home-Manager.

---

## Возможности

-   **Поддержка нескольких хостов:** Легко настраивайте разные машины с уникальными параметрами.
-   **Индивидуальные часовые пояса для пользователей:** Задавайте разные часовые пояса для каждого пользователя.
-   **Интеграция с Home-Manager:** Управляйте пользовательскими окружениями через Home-Manager.
-   **Масштабируемость:** Добавление новых хостов и пользователей требует минимальных изменений.
-   **Модульность:** Переиспользуемые модули для общих настроек, таких как драйверы NVIDIA, Wayland и пакеты.

---

## Структура каталога

```plaintext
nixos-config/
├── flake.nix                # Основной файл конфигурации
├── modules/                 # Общие модули для переиспользования
│   ├── global-settings.nix
│   ├── nvidia.nix
│   ├── wayland.nix
│   ├── packages.nix
│   └── users.nix
├── hosts/                   # Хост-специфичные конфигурации
│   ├── desktop/
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
```

---

## Как использовать

### 1. Клонируйте репозиторий

Начните с клонирования репозитория на вашу локальную машину:

```bash
git clone https://github.com/your-username/nixos-config.git
cd nixos-config
```

---

### 2. Включите поддержку Flakes

Убедитесь, что в вашей установке NixOS включена поддержка Flakes. Для этого добавьте следующую строку в файл `/etc/nix/nix.conf`:

```ini
experimental-features = nix-command flakes
```

Перезапустите службу Nix:

```bash
sudo systemctl restart nix-daemon
```

---

### 3. Добавьте новый хост

1. **Создайте директорию для нового хоста:**

    Скопируйте существующую директорию (например, `desktop`) в качестве шаблона:

    ```bash
    cp -r hosts/desktop hosts/new-host
    ```

2. **Скопируйте `hardware-configuration.nix`:**

    Файл `hardware-configuration.nix` описывает уникальные аппаратные настройки вашей машины. Чтобы его создать:

    - Загрузитесь в систему NixOS, для которой создаётся конфигурация.
    - Выполните следующую команду:

        ```bash
        nixos-generate-config --dir ./hosts/new-host
        ```

    Эта команда создаст или обновит `hardware-configuration.nix` для текущей машины и сохранит его в директорию `hosts/new-host`.

3. **Отредактируйте конфигурацию хоста:**

    Измените файл `configuration.nix` в директории `hosts/new-host`, чтобы настроить уникальные параметры для нового хоста. Например:

    ```nix
    { config, pkgs, hostname, stateVersion, ... }:

    {
      networking.hostName = "new-host"; # Укажите имя хоста
      system.stateVersion = "24.11";    # Версия NixOS

      imports = [
        ../../modules/global-settings.nix
        ../../modules/nvidia.nix
        ../../modules/wayland.nix
        ../../modules/packages.nix
      ];
    }
    ```

4. **Добавьте хост в `flake.nix`:**

    Откройте файл `flake.nix` и добавьте новый хост в список `hosts`:

    ```nix
    { hostname = "new-host"; stateVersion = "24.11"; users = [
      { username = "newuser"; timezone = "Europe/Moscow"; }
    ]; }
    ```

---

### 4. Добавьте нового пользователя

Чтобы добавить нового пользователя на существующий хост:

1. Найдите нужный хост в списке `hosts` внутри `flake.nix`.
2. Добавьте нового пользователя с указанием имени пользователя и часового пояса. Например:

    ```nix
    { hostname = "laptop"; stateVersion = "24.05"; users = [
      { username = "newuser"; timezone = "Europe/Moscow"; }
      { username = "exampleuser"; timezone = "Asia/Yekaterinburg"; }
    ]; }
    ```

3. Создайте файл `home.nix` для нового пользователя:

    ```bash
    cp hosts/desktop/home.nix hosts/desktop/exampleuser-home.nix
    ```

    Отредактируйте файл для настройки окружения пользователя.

---

### 5. Примените конфигурацию

Чтобы пересобрать конфигурацию системы для конкретного хоста, выполните:

```bash
sudo nixos-rebuild switch --flake .#hostname
```

Замените `hostname` на имя вашего хоста (например, `desktop`).

Чтобы применить конфигурацию Home-Manager для конкретного пользователя, выполните:

```bash
home-manager switch --flake .#username
```

Замените `username` на имя пользователя (например, `exampleuser`).

---

## Примеры

### Пример: Добавление хоста `laptop`

1. Добавьте хост в `flake.nix`:

    ```nix
    { hostname = "laptop"; stateVersion = "24.05"; users = [
      { username = "yuyti"; timezone = "Asia/Tokyo"; }
    ]; }
    ```

2. Создайте конфигурационные файлы для хоста:

    ```bash
    cp -r hosts/laptop hosts/laptop
    ```

3. Скопируйте файл `hardware-configuration.nix`:

    ```bash
    nixos-generate-config --dir ./hosts/laptop
    ```

4. Отредактируйте `hosts/laptop/configuration.nix` для настройки хоста.

5. Примените конфигурацию:

    ```bash
    sudo nixos-rebuild switch --flake .#laptop
    ```

6. Примените конфигурацию Home-Manager для пользователя `yuyti`:

    ```bash
    home-manager switch --flake .#yuyti
    ```

---

### Пример: Добавление пользователя `vader` на хост `laptop`

1. Добавьте пользователя в `flake.nix`:

    ```nix
    { hostname = "laptop"; stateVersion = "24.05"; users = [
      { username = "yuyti"; timezone = "Asia/Tokyo"; }
      { username = "vader"; timezone = "America/New_York"; }
    ]; }
    ```

2. Создайте файл `home.nix` для пользователя:

    ```bash
    cp hosts/laptop/home.nix hosts/laptop/vader-home.nix
    ```

3. Настройте окружение пользователя в файле `vader-home.nix`.

4. Примените конфигурацию Home-Manager для `vader`:

    ```bash
    home-manager switch --flake .#vader
    ```

---

## Примечания

-   **Файл `hardware-configuration.nix`:** Убедитесь, что этот файл индивидуален для каждой машины. Вы можете сгенерировать его с помощью:

    ```bash
    nixos-generate-config --dir ./hosts/hostname
    ```

-   **Часовые пояса пользователей:** Убедитесь, что переменная `TZ` установлена корректно через файл `home.nix`.

-   Для устранения проблем проверьте логи:

    ```bash
    /var/log/nixos-rebuild.log
    ```

---

## Решение проблем

### Распространенные ошибки

1. **Flakes не включены:**
   Убедитесь, что `experimental-features = nix-command flakes` добавлено в `/etc/nix/nix.conf`.

2. **Неправильное имя хоста или пользователя:**
   Проверьте, что `hostname` и `username` совпадают с именами, указанными в `flake.nix`.

3. **Аппаратные проблемы:**
   Пересоздайте `hardware-configuration.nix`, если аппаратное обеспечение изменилось.

---

## Лицензия

Этот проект является open-source и доступен под лицензией MIT.
