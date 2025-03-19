" Настройка плагинов через vim-plug
call plug#begin('~/.vim/plugged')

" Ваши плагины
Plug 'mg979/vim-visual-multi' " Мультикурсор
Plug 'preservim/nerdtree' " Файловый менеджер
Plug 'cocopon/iceberg.vim' " Цветовая схема Iceberg
Plug 'ryanoasis/vim-devicons' " Значки файлов
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Подсветка синтаксиса
Plug 'vim-airline/vim-airline' " Статусная строка
Plug 'vim-airline/vim-airline-themes' " Темы для vim-airline

call plug#end()

" Цветовая схема Iceberg с темным режимом
set background=dark
colorscheme iceberg

" Отключение конфликтующих горячих клавиш
nnoremap <C-l> <Nop>
nnoremap <C-c> <Nop>
nnoremap <C-w> <Nop>
nnoremap <C-h> <Nop>
nnoremap <C-t> <Nop>

" Настраиваем привязки
" 1. Код для открытия файлов с поддержкой абсолютных путей
nnoremap <C-l> :if filereadable(expand('<cfile>')) \| 
  \ execute 'tabedit ' . expand('<cfile>') \| 
  \ if !filewritable(expand('<cfile>')) \| 
  \   setlocal readonly \| 
  \ endif \| 
  \ else \| 
  \ echo "No such file or directory" \| 
  \ endif<CR>

" 2. Ctrl+E для переключения между вкладками вперёд, Ctrl+Q — назад
nnoremap <C-e> :tabnext<CR>
nnoremap <C-q> :tabprevious<CR>

" 3. Ctrl+W для переключения между NERDTree и рабочим пространством
nnoremap <C-w> :NERDTreeToggle<CR>

" 4. Ctrl+C для копирования текста в буфер обмена
vnoremap <C-c> "+y
nnoremap <C-c> "+yy

" 5. Ctrl+N для замены выделенных слов
vnoremap <C-n> :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>

" 6. NERDTree: автозапуск и оптимизация
autocmd VimEnter * if !argc() | NERDTree | wincmd p | endif
autocmd BufEnter * if bufname() == 'NERD_tree_' && winnr('$') == 1 | quit | endif
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '\~$', '\.swp$']
let g:NERDTreeQuitOnOpen = 1

" 7. Подсветка слов "error/ERROR/Error"
syntax match ErrorMsg /\<\([eE][rR][rR][oO][rR]\)\>/
highlight ErrorMsg ctermfg=red guifg=red

" 8. Фиксация нумерации строк
set number
set relativenumber
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" 9. vim-visual-multi (мультикурсор)
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-n>' " Использование Ctrl+N для выделения
let g:VM_maps['Find Subword Under'] = '<C-s>'

" 10. Включение поддержки управления мышью
set mouse=a " Включить управление мышью в нормальном и других режимах

" 11. Оптимизация производительности
set lazyredraw
set noswapfile
set nocompatible
set encoding=utf-8
set clipboard=unnamedplus
