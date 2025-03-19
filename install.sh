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
COMMAND='export PATH=$HOME/vim-install/bin:$PATH'

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

# Step 1: Установка vim-plug
echo "Устанавливаю vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Step 2: Открытие Vim с выполнением команды :PlugInstall
echo "Запускаю Vim для установки плагинов..."
vim +PlugInstall +qall


# Step 1: Create font directory and download JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip

# Step 2: Refresh font cache for xterm terminal
fc-cache -fv

# Step 3: Check if ~/.Xresources exists, create if not, and preserve other settings
if [ ! -f ~/.Xresources ]; then
    echo "File ~/.Xresources not found. Creating it..."
    touch ~/.Xresources
fi

# Add settings if they are not already present
if ! grep -q "XTerm*faceName: JetBrainsMono Nerd Font" ~/.Xresources; then
    echo -e "\nXTerm*faceName: JetBrainsMono Nerd Font" >> ~/.Xresources
    echo "Added font face name to ~/.Xresources."
fi

if ! grep -q "XTerm*faceSize: 12" ~/.Xresources; then
    echo "XTerm*faceSize: 12" >> ~/.Xresources
    echo "Added font face size to ~/.Xresources."
fi

# Step 4: Apply the new configuration
xrdb ~/.Xresources

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

echo "Установка завершена!"
echo "Please close and reopen your terminal to apply the changes."
