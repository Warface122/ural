#!/bin/bash

# Step 1: Установка vim-plug
echo "Устанавливаю vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Step 2: Открытие Vim с выполнением команды :PlugInstall
echo "Запускаю Vim для установки плагинов..."
vim +PlugInstall +qall

echo "Установка завершена!"
