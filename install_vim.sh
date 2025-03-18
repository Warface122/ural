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
export PATH=$HOME/vim-install/bin:$PATH

echo "Установка завершена!"
