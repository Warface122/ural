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

" Включение подсветки синтаксиса
syntax enable

" Настройка отображения ошибок
highlight MyError ctermfg=red guifg=red
syntax match MyError /\<\(error\|ERROR!\|ERROR\)\>/

" Горячие клавиши для переключения вкладок
" Горячие клавиши для переключения на следующую вкладку
nnoremap <C-<> :tabnext<CR>

" Горячие клавиши для переключения на предыдущую вкладку
nnoremap <C->> :tabprevious<CR>

" Включение номеров строк
set number

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

" Установка цветовой схемы Gruvbox в темном режиме
colorscheme iceberg
set background=dark

" Включение vim-airline и использование встроенной цветовой схемы gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Горячая клавиша для замены текста во всем файле (Leader+R)
nnoremap <C-S-s> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Горячие клавиши для замены выбранного текста
vnoremap <C-S-u> :<C-u>%s///

" Enable mouse support for all modes and system clipboard`
set clipboard=unnamedplus

nnoremap <C-C> "+y
vnoremap <C-C> "+y

" Горячая клавиша для замены текста во всем файле (Ctrl+Shift+R)
nnoremap <C-S-r> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Включить автоматический выбор первого элемента при открытии fzf
let g:fzf_preview_window = ['right:50%']
let g:fzf_layout = { 'window': 'right:50%' }

" Настройка fzf для использования grep вместо ag, если ag не найден
let g:fzf_command_prefix = 'Fzf'

" Использовать grep вместо ag, если ag не установлен
let g:fzf_files_command = 'grep -r ""'  " использование grep для поиска файлов
let g:fzf_preview_command = 'grep -r ""'  " использование grep для предварительного просмотра

" Горячие клавиши для fzf

"Поиск файла с помощью fzf
nnoremap <C-e> :Files<CR>

" Поиск буферов с помощью fzf
nnoremap <C-d> :Buffers<CR>

" Поиск по истории команд с помощью fzf
nnoremap <C-h> :History<CR>

" Поиск строк в текущем файле с использованием grep
nnoremap <C-s> :Grep<CR>

" Поиск файлов в Git-репозитории
nnoremap <C-g> :GFiles<CR>


" Автоматическое открытие NERDTree при запуске Vim, если открыта папка
autocmd VimEnter *  NERDTree
" Закрытие Vim, если закрыто окно NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

" Горячие клавиши
nnoremap <C-t> :NERDTreeToggle<CR> " Открыть/закрыть NERDTree
nnoremap <C-Alt-f> :NERDTreeFind<CR> " Найти текущий файл в дереве
autocmd FileType nerdtree nnoremap <buffer><silent> <leader><CR> :call NERDTreeOpenInVerticalSplit()<CR>

" Настройки NERDTree
let g:NERDTreeShowHidden=1 " Показывать скрытые файлы
let g:NERDTreeMinimalUI=1 " Минималистичный интерфейс
let g:NERDTreeDirArrows=1 " Показывать стрелки для директорий

" Настройки иконок для файлов (если установлен vim-devicons)
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_enable_nerdtree_git=1

nnoremap <C-Tab> :call ToggleNERDTree()<CR>

function! ToggleNERDTree()
    if exists("t:nerdtree") && t:nerdtree.isTabTree()
        exe "NERDTreeClose"
    else
        exe "NERDTreeToggle"
    endif
endfunction
