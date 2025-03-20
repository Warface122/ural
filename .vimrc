" Включение поддержки мыши
set mouse=a

" Проверка файла под курсором и открытие его в новой вкладке
nnoremap <C-l> :let filename = expand('<cfile>')<CR>:if filename != '' | execute 'tabnew '.filename | else | echo 'Нет файла под курсором!' | endif<CR>

"nnoremap <C-l> :tabe <cfile><CR>
nnoremap <C-x> :b#<CR>
nnoremap <C-S-l> :e <cfile><CR>


"" Настройка функции для правильного закрытия NERDTree и других окон
function! CustomQuit()
  " Если это NERDTree и только одно окно, полностью закрыть Vim
  if bufname() =~ 'NERD_tree_' && winnr('$') == 1
    quit
  " Если это NERDTree, но есть другие окна
  elseif bufname() =~ 'NERD_tree_'
    execute 'NERDTreeClose'
    " Проверяем, если это последний оставшийся буфер, закрыть Vim
    if winnr('$') == 1
      quit
    endif
  " Закрываем терминал или другие буферы
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
syntax match MyError /\<error\|ERROR!\|ERROR\>/

" Горячие клавиши для вкладок
nnoremap <C-q> :tabprevious<CR>  " Переключение на предыдущую вкладку
nnoremap <C-e> :tabnext<CR>      " Переключение на следующую вкладку

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
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Установка цветовой схемы
colorscheme iceberg
set background=dark

" Включение vim-airline и использование цветовой схемы gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='iceberg'

" Горячая клавиша для замены текста во всем файле (Ctrl+Shift+R)
nnoremap <C-S-r> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Включение системного буфера обмена
set clipboard=unnamedplus

" Горячие клавиши для копирования в системный буфер
nnoremap <C-C> "+y                " Копирование в системный буфер
vnoremap <C-C> "+y                " Копирование выделенного текста в системный буфер

" Горячие клавиши для NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>    " Открыть/закрыть NERDTree
nnoremap <C-Alt-f> :NERDTreeFind<CR>  " Найти текущий файл в NERDTree



