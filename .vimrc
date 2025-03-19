" Настройка плагинов через vim-plug
call plug#begin('~/.vim/plugged')

" Ваши плагины
Plug 'mg979/vim-visual-multi'
Plug 'preservim/nerdtree'
Plug 'cocopon/iceberg.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Цветовая схема Iceberg
colorscheme iceberg

" Конфликтные клавиши отключаются, чтобы избежать проблем
nnoremap <C-l> <Nop>
nnoremap <C-c> <Nop>
nnoremap <C-w> <Nop>
nnoremap <C-.> <Nop>
nnoremap <C-,> <Nop>

" Настраиваем свои привязки
" 1. Ctrl+L для открытия пути в новом табе
nnoremap <C-l> :execute 'tabedit ' . expand('<cfile>')<CR>
xnoremap <C-l> :execute 'tabedit ' . expand('<cfile>')<CR>
autocmd BufEnter * if !filereadable(expand('%')) | echo "No such directory" | endif

" 2. Ctrl+W для переключения между NERDTree и рабочим пространством
nnoremap <C-w> :NERDTreeToggle<CR>

" 3. Ctrl+C для копирования в буфер обмена
vnoremap <C-c> "+y
nnoremap <C-c> "+yy

" 4. Ctrl+N для замены выделенных слов
vnoremap <C-n> :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>

" 5. Ctrl+. и Ctrl+, для переключения между вкладками
nnoremap <C-.> :tabnext<CR>
nnoremap <C-,> :tabprevious<CR>

" 6. NERDTree оптимизация
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowHidden = 1

" 7. Подсветка слов "error/ERROR/Error" красным цветом
syntax match ErrorMsg /\<\([eE][rR][rR][oO][rR]\)\>/
highlight ErrorMsg ctermfg=red guifg=red

" 8. Оптимизация производительности
set lazyredraw
set noswapfile
set nocompatible
set encoding=utf-8
set number
set relativenumber

" 9. vim-visual-multi (мультикурсор)
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-n>' " Использование Ctrl+N для выделения
let g:VM_maps['Find Subword Under'] = '<C-s>'
