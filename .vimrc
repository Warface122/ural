" Enable mouse support
set mouse=a
set lazyredraw
set encoding=utf-8
set fileencoding=utf-8
set termguicolors
set termencoding=utf-8

" Function to open the selected path
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

  if l:path !~ '^\(\/\|[A-Za-z]:\)' " Check for absolute path
    let l:fullpath = fnamemodify(expand('%:p:h') . '/' . l:path, ':p')
  else
    let l:fullpath = fnamemodify(l:path, ':p')
  endif

  if filereadable(l:fullpath) || isdirectory(l:fullpath)
    execute 'tabnew ' . fnameescape(l:fullpath)
  else
    echo "Path not found: " . l:fullpath
  endif
endfunction

" Settings for using the path-opening function
nnoremap <C-l> :call OpenSelectedPath()<CR>
vnoremap <C-l> :<C-u>call OpenSelectedPath()<CR>

" Configure proper closing of NERDTree and other windows
function! CustomQuit()
  if bufname() =~ 'NERD_tree_' && winnr('$') == 1
    quit
  elseif bufname() =~ 'NERD_tree_'
    execute 'NERDTreeClose'
    if winnr('$') == 1
      quit
    endif
  else
    quit
  endif
endfunction

" Override the :q command with CustomQuit
command! -nargs=0 Q call CustomQuit()

" Bind <Ctrl+Q> to call the :Q command
nnoremap <C-q> :Q<CR>

" Auto-close Vim if only NERDTree remains
autocmd BufEnter * if bufname() =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

" Enable syntax highlighting
syntax enable

" Key mappings for tabs
nnoremap <C-,> :tabprevious<CR>
nnoremap <C-.> :tabnext<CR>

" Enable line numbers
set number

" Auto-open NERDTree on startup if a folder is opened
autocmd VimEnter * NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif

" Initialize Vim-Plug plugin manager
call plug#begin('~/.vim/plugged')

" Install plugins
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

" Set the color scheme
colorscheme iceberg
set background=dark

" Enable vim-airline and set the gruvbox theme
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Enable the system clipboard
set clipboard=unnamedplus

" Key mappings for copying to the system clipboard
nnoremap <C-C> "+y
vnoremap <C-C> "+y

" Key mappings for fzf
nnoremap <C-e> :Files<CR>
nnoremap <C-d> :Buffers<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-s> :Grep<CR>
nnoremap <C-g> :GFiles<CR>

" Key mappings for NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-Alt-f> :NERDTreeFind<CR>
