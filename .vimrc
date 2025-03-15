" Включение поддержки мыши
set mouse=a

" Функция открытия выбранного пути
function! OpenSelectedPath()
  if mode() ==# 'v'
    let l:sel = getline("'<", "'>")
    let l:path = join(l:sel, "\n")
  elseif getreg('*') != ''
    let l:path = getreg('*')
  else
    let l:path = expand('<cfile>')
  endif
  let l:path = substitute(l:path, '^\s*\|\s*$', '', '')
  if l:path !~ '^/'
    let l:fullpath = expand('%:p:h') . '/' . l:path
  else
    let l:fullpath = l:path
  endif
  let l:fullpath = fnamemodify(l:fullpath, ':p')
  if filereadable(l:fullpath) || isdirectory(l:fullpath)
    execute 'tabnew ' . fnameescape(l:fullpath)
  else
    echo "Нет такой ссылки: " . l:fullpath
  endif
endfunction

" Настройки для использования функции открытия пути
nnoremap <Leader>l :call OpenSelectedPath()<CR>
vnoremap <Leader>l :<C-u>call OpenSelectedPath()<CR>

" Автоматическое открытие NERDTree при запуске Vim
autocmd VimEnter * if argc() == 0 | NERDTree | endif

" Открытие/закрытие NERDTree с помощью Alt + n
nnoremap <A-n> :NERDTreeToggle<CR>


" Горячая клавиша для замены текста во всем файле (Leader+R)
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Горячая клавиша для замены выбранного текста (Leader+S)
vnoremap <Leader>s :s/\<<C-r><C-w>\>//g<Left><Left>

" Автоматическое выделение всех похожих слов при выделении текста
nnoremap <Leader>f :let @/ = '\V\<'.expand('<cword>').'\>'<CR>


" Горячие клавиши для работы с NERDTree
" Открытие файла в новом горизонтальном сплите
nmap <leader>i :NERDTreeFind<CR>
" Открытие файла в новом вертикальном сплите
nmap <leader>v :NERDTreeToggle<CR>:wincmd V<CR>

" Включение подсветки синтаксиса
syntax enable

" Настройка отображения ошибок
highlight MyError ctermfg=red guifg=red
syntax match MyError /\<\(error\|ERROR!\|ERROR\)\>/

" Горячие клавиши для переключения вкладок
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprevious<CR>

" Включение номеров строк
set number

" Инициализация менеджера плагинов Vim-Plug
call plug#begin('~/.vim/plugged')

" Установка плагинов
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'arzg/vim-colors-xcode'
Plug 'ayu-theme/ayu-vim'
Plug 'gkeep/iceberg-dark'
Plug 'cocopon/iceberg.vim'
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

" Установка цветовой схемы Gruvbox в темном режиме
colorscheme iceberg
set background=dark

" Автоматическое открытие NERDTree при запуске Vim
autocmd vimenter * NERDTree

" Включение vim-airline и использование встроенной цветовой схемы gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Горячие клавиши для замены текста во всем файле
nnoremap <Leader>r :%s///

" Горячие клавиши для замены выбранного текста
vnoremap <Leader>u :<C-u>%s///

" Автокоманда для закрытия текущего окна, включая NERDTree, с помощью :q
autocmd BufEnter * if winnr('$') == 1 && exists("t:NERDTreeBufName") && bufname("%") == t:NERDTreeBufName | q | endif

" Enable mouse support for all modes and system clipboard`
set clipboard=unnamedplus

nnoremap <Leader>y "+y
vnoremap <Leader>y "+y


" Горячая клавиша для замены текста во всем файле (Leader+R)
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Горячая клавиша для замены выбранного текста (Leader+S)
vnoremap <Leader>s :s/\<<C-r><C-w>\>//g<Left><Left>

" Автоматическое выделение всех похожих слов при выделении текста
nnoremap <Leader>f :let @/ = '\V\<'.expand('<cword>').'\>'<CR>
