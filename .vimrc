set nocompatible
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set modelines=0
set noswapfile
set backupskip=/tmp/*,/private/tmp/*

set tabstop=4
set expandtab
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start " Allow backspace in insert mode
set nojoinspaces
set gdefault
set wildmenu
set ignorecase
set wildignore+=.*

set title
set showcmd
set ruler
set nowrap
set scrolloff=1
set laststatus=1
set incsearch
set listchars=tab:»\ ,trail:·,eol:¬,nbsp:_ " invisible characters to show
"set list
"set shortmess=atI
"set showmode
"set number
"set relativenumber
"set nohlsearch

" disable ex mode Q
nnoremap Q <nop>
let mapleader=" "
noremap <Leader>s :update<CR>
noremap ,s :update<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>l :set wrap!<CR>
nnoremap <Leader>r :set number! relativenumber!<CR>
nnoremap <Leader>d o<esc>:r!date<CR><esc>o<esc>
nnoremap <Leader>ev :vs ~/.vimrc<CR>
nnoremap <Leader>c :colo base16-darktooth<CR>
nnoremap <Leader>v :colo base16-solar-flare<CR>
nnoremap <Leader>b :colo base16-bright<CR>
nnoremap <Leader>n :colo base16-google-light<CR>
nnoremap <Leader>m :colo base16-default-dark<CR>

if exists("&undodir")
  set undodir=~/.vim/undo
endif

if has("clipboard")
  set clipboard=unnamed "OS clipboard
endif

if exists("&wildignorecase")
  set wildignorecase
endif

if has("syntax")
  syntax on
  set synmaxcol=300
endif

if has("mouse")
  set mouse=a " Enable mouse in all modes
  set ttymouse=xterm2
endif

if has('belloff')
  silent! set belloff=error,esc
endif

if has("spell")
  set spelllang=en_us
  nnoremap <leader>p :set spell!<CR>
endif

if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'moll/vim-node', { 'for': 'javascript' }
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'chriskempson/base16-vim'
silent! Plug 'vim-syntastic/syntastic', { 'on': 'SyntasticCheck', 'for': ['javascript', 'javascript.jsx', 'jsx'] }
silent! Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
silent! Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
silent! Plug 'junegunn/fzf', { 'on': 'FZF' }
silent! Plug 'junegunn/fzf.vim', { 'on': 'FZF' }
" vim-scripts/applescript.vim
silent! call plug#end()
let g:gitgutter_enabled = 0
let g:jsx_ext_required = 0 " Highlight .js as .jsx
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" Have es-lint installed globally even when `npm bin` returns local path
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'

noremap <Leader>t :NERDTreeToggle<CR>
if has('gui_macvim')
  noremap <Leader>f :CtrlP<CR>
else
  noremap <Leader>f :FZF<CR>
endif

" let vim v7.4 use desert colorscheme
if has('termguicolors')
  try
    set termguicolors
    "colorscheme base16-google-light
    colorscheme base16-bright
  catch
    set notermguicolors
    silent! colorscheme desert
  endtry
else
  silent! colorscheme desert
endif
if has('gui_macvim')
  "silent! colorscheme base16-google-light
  silent! colorscheme base16-bright
endif
