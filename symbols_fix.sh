#!/bin/bash

# Файл, в который нужно добавить команду
TARGET_FILE="$HOME/.bashrc.user"

# Команда, которую нужно добавить
COMMAND='export TERM=screen-256color'

# Проверка, существует ли файл
if [ ! -f "$TARGET_FILE" ]; then
    # Если файл не существует, создаем его
    touch "$TARGET_FILE"
fi

# Проверка, есть ли команда уже в файле
if ! grep -Fxq "$COMMAND" "$TARGET_FILE"; then
    # Если команды нет, добавляем её
    echo "$COMMAND" >> "$TARGET_FILE"
    echo "Команда добавлена в $TARGET_FILE"
else
    echo "Команда уже существует в $TARGET_FILE"
fi
