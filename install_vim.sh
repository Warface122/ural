#!/bin/bash

echo "Клонируем Vim из репозитория..."
git clone https://github.com/vim/vim.git ~/vim-sources

echo "Переходим в папку с исходниками..."
cd ~/vim-sources

echo "Конфигурируем с необходимыми параметрами..."
./configure --prefix=$HOME/vim-install --enable-gui=auto --with-features=huge --enable-multibyte --enable-clipboard --enable-python3interp

echo "Компилируем и устанавливаем..."
make
make install

echo "Обновляем PATH..."
# Файл, в который нужно добавить команду
TARGET_FILE="$HOME/.bashrc.user"

# Команда, которую нужно добавить
export PATH=$HOME/vim-install/bin:$PATH

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


echo "Установка завершена!"
