#!/usr/bin/env sh

# Конфигурационный файл Swappy
SWAPPY_CONFIG_PATH="${SWAPPY_CONFIG_PATH:-$HOME/.config/swappy/config}"

# Проверка существования файла конфигурации Swappy
if [ ! -f "$SWAPPY_CONFIG_PATH" ]; then
    echo "Error: Swappy configuration file not found at $SWAPPY_CONFIG_PATH"
    exit 1
fi

# Чтение параметров из конфигурации Swappy
SAVE_DIR=$(grep "^save_dir=" "$SWAPPY_CONFIG_PATH" | cut -d '=' -f 2)
SAVE_FILENAME_FORMAT=$(grep "^save_filename_format=" "$SWAPPY_CONFIG_PATH" | cut -d '=' -f 2)

if [ -z "$SAVE_DIR" ] || [ -z "$SAVE_FILENAME_FORMAT" ]; then
    echo "Error: Swappy configuration must include 'save_dir' and 'save_filename_format'"
    exit 1
fi

# Используем save_dir из конфигурации или значение по умолчанию
SCREENSHOT_FOLDER="${SAVE_DIR:-$HOME/Pictures/Screenshots/$(date +%d-%m-%Y)}"
SCREENSHOT_NAME="${2:-$(date +%H-%M-%S).png}"
OUTPUT_FOLDER="${SCREENSHOT_FOLDER}/"
OUTPUT="${OUTPUT_FOLDER}${SCREENSHOT_NAME}"

# Создаем папку для скриншота
mkdir -p "$OUTPUT_FOLDER"

# Функция для отображения справки
print_error() {
    cat <<"EOF"
Usage: screenshot <action> [output_name]
Actions:
  screen - Take a screenshot of the entire screen
  area   - Take a screenshot of a selected area
EOF
}

# Основная логика
case $1 in
  screen)
    grimblast --freeze copysave screen "$OUTPUT" && swappy -f "$OUTPUT" ;;
  area)
    grimblast --freeze copysave area "$OUTPUT" && swappy -f "$OUTPUT" ;;
  *)
    print_error ;;
esac

# Уведомление о сохранении скриншота
if [ -f "$OUTPUT" ]; then
    notify-send -i "$OUTPUT" "Saved screenshot in $OUTPUT"
fi

