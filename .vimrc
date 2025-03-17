" Включение поддержки мыши во всех режимах
set mouse=a

" Включение использования системного буфера обмена
set clipboard=unnamedplus

" Функция для открытия выбранного пути или файла
function! OpenSelectedPath()
  if mode() ==# 'v' " Если в визуальном режиме, получить выделенный текст
    let l:sel = getline("'<", "'>")
    let l:path = join(l:sel, "\n")
  elseif getreg('*') != '' " Если есть текст в буфере обмена
    let l:path = getreg('*')
  else " В противном случае использовать путь под курсором
    let l:path = expand('<cfile>')
  endif
  " Удалить пробелы по краям
  let l:path = substitute(l:path, '^\s*\|\s*$', '', '')
  " Обработать относительный путь
  if l:path !~ '^/'
    let l:fullpath = expand('%:p:h') . '/' . l:path
  else
    let l:fullpath = l:path
  endif
  let l:fullpath = fnamemodify(l:fullpath, ':p')
  " Если файл существует или это директория, открыть его в новой вкладке
  if filereadable(l:fullpath) || isdirectory(l:fullpath)
    execute 'tabnew ' . fnameescape(l:fullpath)
  else
    echo "Нет такой ссылки: " . l:fullpath
  endif
endfunction

" Горячие клавиши
" Копирование строки или выделенного текста в системный буфер обмена
nnoremap <C-C> "+y
vnoremap <C-C> "+y

" Открытие файла или папки из указанного пути
nnoremap <C-L> :call OpenSelectedPath()<CR>

" Работа с вкладками
nnoremap <C-Right> :tabnext<CR>       " Перейти к следующей вкладке
nnoremap <C-Left> :tabprevious<CR>    " Перейти к предыдущей вкладке

" Поиск с помощью fzf
nnoremap <C-F> :Files<CR>             " Поиск файлов
nnoremap <C-D> :Buffers<CR>           " Поиск среди открытых буферов
nnoremap <C-S> :Grep<CR>              " Поиск строк в текущем файле
nnoremap <C-G> :GFiles<CR>            " Поиск файлов в git-репозитории
nnoremap <C-H> :History<CR>           " Поиск в истории команд

" Управление NERDTree
nnoremap <C-T> :NERDTreeToggle<CR>    " Открыть/закрыть NERDTree
nnoremap <C-S-F> :NERDTreeFind<CR>    " Найти текущий файл в дереве
nnoremap <C-Tab> :NERDTreeFocus<CR>   " Переключиться на дерево
nnoremap <S-Tab> :NERDTreeToggle<CR>  " Закрыть NERDTree

" Замена текста
nnoremap <C-R> :%s///g<Left><Left>    " Замена текста во всем файле
vnoremap <C-U> :<C-u>%s///g<Left><Left> " Замена выделенного текста

" Быстрое обновление подсветки синтаксиса
nnoremap <C-E> :syntax enable<CR>

" Включение подсветки синтаксиса
syntax enable

" Включение нумерации строк
set number

" Настройка менеджера плагинов Vim-Plug
call plug#begin('~/.vim/plugged')

" Установка плагинов
Plug 'morhetz/gruvbox'                 " Цветовая схема Gruvbox
Plug 'arzg/vim-colors-xcode'           " Цветовая схема Xcode
Plug 'gkeep/iceberg-dark'              " Цветовая схема Iceberg (тёмная)
Plug 'cocopon/iceberg.vim'             " Альтернативная цветовая схема Iceberg
Plug 'vim-airline/vim-airline'         " Удобный статус-бар
Plug 'joshdick/onedark.vim'            " Цветовая схема One Dark
Plug 'arcticicestudio/nord-vim'        " Цветовая схема Nord
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Поддержка мультивыделения
Plug 'junegunn/fzf'                    " Fuzzy finder fzf
Plug 'junegunn/fzf.vim'                " Плагин fzf для Vim
Plug 'preservim/nerdtree'              " Файловый менеджер NERDTree
Plug 'ryanoasis/vim-devicons'          " Иконки для файлов в Vim

call plug#end()

" Установка цветовой схемы Iceberg
colorscheme iceberg
set background=dark

" Настройка vim-airline
let g:airline#extensions#tabline#enabled = 1  " Включение строки вкладок
let g:airline_powerline_fonts = 1             " Использование шрифтов Powerline
let g:airline_theme='gruvbox'                " Тема Gruvbox для vim-airline

" Настройки fzf
let g:fzf_preview_window = ['right:50%']     " Предпросмотр справа
let g:fzf_layout = { 'window': 'right:50%' } " Расположение окна fzf

" Настройки NERDTree
let g:NERDTreeShowHidden=1    " Показывать скрытые файлы
let g:NERDTreeMinimalUI=1     " Минималистичный интерфейс
let g:NERDTreeDirArrows=1     " Показывать стрелки для директорий
let g:webdevicons_enable_nerdtree=1          " Включить иконки для файлов
let g:webdevicons_enable_nerdtree_git=1      " Включить иконки git-репозиториев

" Автоматическое открытие NERDTree при запуске Vim
autocmd VimEnter * NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

" Функция для открытия файлов в вертикальном сплите
function! NERDTreeOpenInVerticalSplit()
  if exists("g:NERDTree")
    exec "wincmd p | vsplit | NERDTreeMirror | wincmd p"
  endif
endfunction
