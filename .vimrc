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

" Горячая клавиша для замены текста во всем файле (Leader+R)
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

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

call plug#end()

" Установка цветовой схемы Gruvbox в темном режиме
colorscheme iceberg
set background=dark

" Настройка coc-explorer
let g:coc_global_extensions = ['coc-explorer']

" Включение vim-airline и использование встроенной цветовой схемы gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Горячие клавиши для замены текста во всем файле
nnoremap <Leader>r :%s///

" Горячие клавиши для замены выбранного текста
vnoremap <Leader>u :<C-u>%s///


" Enable mouse support for all modes and system clipboard`
set clipboard=unnamedplus

nnoremap <C-C> "+y
vnoremap <C-C> "+y

" Горячая клавиша для замены текста во всем файле (Leader+R)
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>


" Включить автоматический выбор первого элемента при открытии fzf
let g:fzf_preview_window = ['right:50%']
let g:fzf_layout = { 'window': 'right:50%' }

" Настройка fzf для использования grep вместо ag, если ag не найден
let g:fzf_command_prefix = 'Fzf'

" Использовать grep вместо ag, если ag не установлен
let g:fzf_files_command = 'grep -r ""'  " использование grep для поиска файлов
let g:fzf_preview_command = 'grep -r ""'  " использование grep для предварительного просмотра

" Горячие клавиши для fzf

" Поиск файлов с помощью fzf
nnoremap <Leader>f :Files<CR>

" Поиск буферов с помощью fzf
nnoremap <Leader>b :Buffers<CR>

" Поиск по истории команд с помощью fzf
nnoremap <Leader>h :History<CR>

" Поиск по строкам в открытом файле с помощью fzf
" Заменим на использование grep, так как ag может не быть установлен
nnoremap <Leader>s :Grep<CR>

" Пример: поиск файлов с помощью fzf и указание путей
nnoremap <Leader>g :GFiles<CR>
