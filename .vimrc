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
nnoremap <C-l> :call OpenSelectedPath()<CR>
vnoremap <C-l> :<C-u>call OpenSelectedPath()<CR>

" Горячие клавиши для замены текста
nnoremap <C-r> :%s/\<<C-r><C-w>\>//g<Left><Left>  " Замена по всему файлу
vnoremap <C-u> :<C-u>%s///                       " Замена выделенного текста

" Включение подсветки синтаксиса
syntax enable

" Настройка отображения ошибок
highlight MyError ctermfg=red guifg=red
syntax match MyError /\<\(error\|ERROR!\|ERROR\)\>/

" Навигация по вкладкам
nnoremap <C-<> :tabprevious<CR>  " Предыдущая вкладка
nnoremap <C->> :tabnext<CR>      " Следующая вкладка

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

" Настройки fzf
let g:fzf_preview_window = ['right:50%']
let g:fzf_layout = { 'window': 'right:50%' }
nnoremap <C-f> :Files<CR>         " Поиск файлов
nnoremap <C-d> :Buffers<CR>       " Поиск буферов
nnoremap <C-s> :Grep<CR>          " Поиск строк
nnoremap <C-g> :GFiles<CR>        " Поиск git-файлов
nnoremap <C-h> :History<CR>       " Поиск по истории

" Настройки NERDTree
autocmd VimEnter *  NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif
nnoremap <silent><C-t> :NERDTreeToggle<CR>  " Открыть/закрыть NERDTree
nnoremap <silent><S-T> :NERDTreeFind<CR>    " Найти текущий файл
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_enable_nerdtree_git=1
