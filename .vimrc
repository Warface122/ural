set mouse=a            " Включение поддержки мыши
set backspace=indent,eol,start
set completeopt=menu,menuone,noselect   "ctrl+n auto-helper
set isfname+=@
set wrapscan
set hlsearch
set incsearch
set guioptions-=m   	 "Turn off Menu    	
set guioptions-=T   	 "Turn off Panel settings
set guioptions-=l	     "Turn off left slider	
set guioptions-=r    	 "Turn off right slider
set timeout timeoutlen=10
set clipboard=unnamedplus    " Включение системного буфера обмена
set termguicolors
set number                   " Включение номеров строк
"set lines=50
"set columns=150


" Настройка выхода из всех режимов при нажатии Esc
inoremap <Esc> <Esc>         " Выход из режима вставки
vnoremap <Esc> <Esc>         " Выход из визуального режима
cnoremap <Esc> <C-c>         " Выход из командной строки


" Горячие клавиши для вкладок
nnoremap <C-q> :tabp<CR>  " Переключение на предыдущую вкладку
nnoremap <C-e> :tabn<CR>      " Переключение на следующую вкладку
nnoremap <C-l> :execute 'tabnew' fnameescape(expand('<cfile>')) <CR>
autocmd TabEnter * silent! lcd %:p:h

nnoremap <C-x> :b#<CR>
nnoremap <C-S-k> :e <cfile><CR>

" Включение подсветки синтаксиса
syntax enable

" Горячие клавиши для окон
nnoremap <C-w> <C-w>w           " Переключение между окнами

" Автооткрытие NERDTree при запуске, если открыта папка
"autocmd VimEnter * NERDTree
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

" Инициализация менеджера плагинов Vim-Plug
call plug#begin('~/.vim/plugged')

" Установка плагинов
Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'
Plug 'gkeep/iceberg-dark'
Plug 'cocopon/iceberg.vim'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdtree'
"Plug 'itchyny/lightline.vim'

call plug#end()

" Установка цветовой схемы
colorscheme gruvbox
set background=dark

" Включение vim-airline и использование цветовой схемы 
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Горячая клавиша для замены текста во всем файле (Ctrl+Shift+R)
nnoremap <C-S-r> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Горячие клавиши для копирования в системный буфер
nnoremap <C-C> "+y                " Копирование в системный буфер
vnoremap <C-C> "+y                " Копирование выделенного текста в системный буфер
imap <C-V> <C-R>+                 " Past text from clipboard    

" Горячие клавиши для NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>    " Открыть/закрыть NERDTree
