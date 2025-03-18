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
" Замена <Leader>l на <Ctrl+L>
nnoremap <C-l> :call OpenSelectedPath()<CR>
vnoremap <C-l> :<C-u>call OpenSelectedPath()<CR>

" Отключение других назначений на <Ctrl+L>, если они есть
unmap <C-l>

" Настройка функции для последовательного закрытия NERDTree и других окон
function! CustomQuit()
  " Если единственное открытое окно - NERDTree, закрываем Vim
  if bufname() =~ 'NERD_tree_' && winnr('$') == 1
    quit
  " Если NERDTree открыт вместе с другими окнами
  elseif bufname() =~ 'NERD_tree_'
    execute 'NERDTreeClose'
  " Если открыт терминал
  elseif &buftype == 'terminal'
    quit
  " Если активен обычный буфер
  else
    quit
  endif
endfunction

" Переопределение команды :q на вызов CustomQuit
command! -nargs=0 Q call CustomQuit()

" Привязка <Ctrl+T> для вызова команды :Q
nnoremap <C-t> :Q<CR>

" Авто-закрытие Vim, если остаётся только NERDTree
autocmd BufEnter * if bufname() =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif



" Включение подсветки синтаксиса
syntax enable

" Настройка отображения ошибок
highlight MyError ctermfg=red guifg=red
syntax match MyError /\<error\|ERROR!\|ERROR\>/

" Горячие клавиши для вкладок
nnoremap <C-,> :tabprevious<CR>  " Переключение на предыдущую вкладку
nnoremap <C-.> :tabnext<CR>      " Переключение на следующую вкладку

" Горячие клавиши для окон
nnoremap <C-w> <C-w>w           " Переключение между окнами

" Включение номеров строк
set number

" Автооткрытие NERDTree при запуске, если открыта папка
autocmd VimEnter * NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Установка цветовой схемы
colorscheme iceberg
set background=dark

" Включение vim-airline и использование цветовой схемы gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Горячая клавиша для замены текста во всем файле (Ctrl+Shift+R)
nnoremap <C-S-r> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Включение системного буфера обмена
set clipboard=unnamedplus

" Горячие клавиши для копирования в системный буфер
nnoremap <C-C> "+y                " Копирование в системный буфер
vnoremap <C-C> "+y                " Копирование выделенного текста в системный буфер

" Горячие клавиши для fzf
nnoremap <C-e> :Files<CR>        " Открытие файлов через fzf
nnoremap <C-d> :Buffers<CR>      " Переключение между буферами
nnoremap <C-h> :History<CR>      " Просмотр истории
nnoremap <C-s> :Grep<CR>         " Поиск текста
nnoremap <C-g> :GFiles<CR>       " Поиск файлов в Git

" Горячие клавиши для NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>    " Открыть/закрыть NERDTree
nnoremap <C-Alt-f> :NERDTreeFind<CR>  " Найти текущий файл в NERDTree

" Отключение любых конфликтных настроек, если они существуют
" Используйте unmap для отключения ненужных горячих клавиш
