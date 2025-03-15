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
Plug 'lambdalisue/fern.vim'

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


" 📂 Автозапуск Fern при старте Vim (открывает текущую папку)
autocmd VimEnter * ++nested Fern . -drawer -toggle -reveal=%  

" 🔁 Оставлять Fern открытым при переходе в файлы
let g:fern#keep = 1

" 🖥️ Переключение Fern с помощью <Leader>e
nnoremap <Leader>e :Fern . -drawer -toggle -reveal=%<CR>

" 🖱️ Открытие файлов в Fern с двойным щелчком
let g:fern#default_hidden=1 " Показывать скрытые файлы (например, .gitignore)

" 📌 Улучшенный вид
let g:fern#renderer = "nerdfont" " Иконки (если установлены)

" 📛 Убираем ошибки в терминале
set termguicolors

" 🚀 Улучшенные горячие клавиши в Fern
augroup FernSettings
  autocmd! *
  autocmd FileType fern nnoremap <buffer> <CR> <Plug>(fern-action-open)
  autocmd FileType fern nnoremap <buffer> o <Plug>(fern-action-open:select)
  autocmd FileType fern nnoremap <buffer> t <Plug>(fern-action-open:tabedit)
  autocmd FileType fern nnoremap <buffer> r <Plug>(fern-action-reload)
  autocmd FileType fern nnoremap <buffer> m <Plug>(fern-action-move)
  autocmd FileType fern nnoremap <buffer> c <Plug>(fern-action-copy)
  autocmd FileType fern nnoremap <buffer> d <Plug>(fern-action-remove)
  autocmd FileType fern nnoremap <buffer> n <Plug>(fern-action-new-file)
  autocmd FileType fern nnoremap <buffer> N <Plug>(fern-action-new-dir)
augroup END








