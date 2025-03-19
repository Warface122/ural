" Enabling mouse support
set mouse=a
set lazyredraw
"set t_ut=
"let &t_ti = '' 
"let &t_te = '' 
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
  if l:path !~ '^/'
    let l:fullpath = expand('%:p:h') . '/' . l:path
  else
    let l:fullpath = l:path
  endif
  let l:fullpath = fnamemodify(l:fullpath, ':p')
  if filereadable(l:fullpath) || isdirectory(l:fullpath)
    execute 'tabnew ' . fnameescape(l:fullpath)
  else
    echo "No such link: " . l:fullpath
  endif
endfunction

" Settings to use the function to open the path
" Replace <Leader>l with <Ctrl+L>
nnoremap <C-l> :call OpenSelectedPath()<CR>
vnoremap <C-l> :<C-u>call OpenSelectedPath()<CR>


"" Configure the function for proper closing of NERDTree and other windows
function! CustomQuit()
  " If this is NERDTree and only one window, completely exit Vim
  if bufname() =~ 'NERD_tree_' && winnr('$') == 1
    quit
  " If this is NERDTree but there are other windows
  elseif bufname() =~ 'NERD_tree_'
    execute 'NERDTreeClose'
    " Check if this is the last remaining buffer, exit Vim
    if winnr('$') == 1
      quit
    endif
  " Close terminal or other buffers
  else
    quit
  endif
endfunction

" Override the :q command to call CustomQuit
command! -nargs=0 Q call CustomQuit()

" Bind <Ctrl+T> to call the :Q command
nnoremap <C-t> :Q<CR>

" Auto-close Vim if only NERDTree remains
autocmd BufEnter * if bufname() =~ 'NERD_tree_' && winnr('$') == 1 | quit | endif


" Enable syntax highlighting
syntax enable

" Configure error highlighting
highlight MyError ctermfg=red guifg=red
syntax match MyError /\<error\|ERROR!\|ERROR\>/

" Hotkeys for tabs
nnoremap <C-,> :tabprevious<CR>  " Switch to the previous tab
nnoremap <C-.> :tabnext<CR>      " Switch to the next tab

" Hotkeys for windows
nnoremap <C-w> <C-w>w           " Switch between windows

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

" Enable vim-airline and use the gruvbox color scheme
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Hotkey for replacing text in the whole file (Ctrl+Shift+R)
nnoremap <C-S-r> :%s/\<<C-r><C-w>\>//g<Left><Left>

" Enable system clipboard
set clipboard=unnamedplus

" Hotkeys for copying to the system clipboard
nnoremap <C-C> "+y                " Copy to the system clipboard
vnoremap <C-C> "+y                " Copy selected text to the system clipboard

" Hotkeys for fzf
nnoremap <C-e> :Files<CR>        " Open files with fzf
nnoremap <C-d> :Buffers<CR>      " Switch between buffers
nnoremap <C-h> :History<CR>      " View history
nnoremap <C-s> :Grep<CR>         " Search text
nnoremap <C-g> :GFiles<CR>       " Search files in Git

" Hotkeys for NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>    " Open/close NERDTree
nnoremap <C-Alt-f> :NERDTreeFind<CR>  " Find the current file in NERDTree

"autocmd InsertLeave * redraw! 
"autocmd BufEnter * redraw!
"autocmd WinEnter * redraw!
