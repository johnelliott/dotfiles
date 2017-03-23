set nocompatible

" Overrides for pairing
set list&vim
set showmode&vim
set nu&vim
set rnu&vim
set hls&vim
set cursorline&vim
set smartcase&vim
set statusline&vim
set wildmode&vim

set encoding=utf-8 nobomb " Use UTF-8 without BOM
set noswapfile
set backupskip=/tmp/*,/private/tmp/*

set tabstop=4
set expandtab
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start " Allow backspace in insert mode
set nojoinspaces
set gdefault
set ignorecase

set title
"set showcmd
set ruler
set nowrap
set scrolloff=1
set laststatus=1
set incsearch
set listchars=tab:»\ ,trail:·,eol:¬,nbsp:_ " invisible characters to show
"set list
set shortmess=atI
"set showmode
"set number
"set relativenumber
"set nohlsearch

" disable Q entering ex mode
nnoremap Q <nop>
let mapleader=" "
noremap <Leader>s :update<CR>
nnoremap ,s :update<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>l :set wrap!<CR>
nnoremap <Leader>r :set number! relativenumber!<CR>
nnoremap <Leader>d :pu _<CR>:r!date<CR>:pu _<CR> 
nnoremap <Leader>ev :vs $MYVIMRC<CR>

nnoremap <Leader>m :set tgc<CR>:colo base16-bright<CR>
nnoremap <Leader>n :set tgc<CR>:colo base16-google-light<CR>
nnoremap <Leader>b :set notermguicolors<CR>:colo default<CR>
nnoremap <Leader>v :set tgc<CR>:colo base16-solarized-light<CR>
nnoremap <Leader>c :set tgc<CR>:colo base16-solarflare<CR>
nnoremap <Leader>x :set tgc<CR>:colo base16-default-dark<CR>

if exists("&undodir")
  set undodir=~/.vim/undo
endif

if has("clipboard")
  set clipboard=unnamed "OS clipboard
endif

if has("wildmenu")
  set wildmenu
endif

if has("wildignore")
  set wildignore+=.*
  set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*
  set wildignore+=*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
endif

if exists("&wildignorecase")
  set wildignorecase
endif

if has("syntax")
  syntax on
  set synmaxcol=400
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
  " Easier git commits
  autocmd FileType gitcommit set textwidth=72
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
silent! Plug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPBuffer'] }
silent! Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
silent! Plug 'junegunn/fzf', { 'on': 'FZF' }
silent! Plug 'junegunn/fzf.vim', { 'on': 'FZF' }
silent! call plug#end()
"let g:gitgutter_enabled = 0
let g:jsx_ext_required = 0 " Highlight .js as .jsx
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" Have es-lint installed globally even when `npm bin` returns local path
let g:syntastic_javascript_checkers = ['eslint', 'standard']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_standard_exe = '$(npm bin)/standard'
" http://stackoverflow.com/questions/28573553
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']

noremap <Leader>t :NERDTreeToggle<CR>

nnoremap <c-b> :CtrlPBuffer<cr>
nnoremap <c-p> :CtrlP<cr>
"If a file is already open, open it again in a new pane instead of switching to the existing pane
"let g:ctrlp_switch_buffer = 'et'
if has('gui_macvim')
  noremap <Leader>f :CtrlP<CR>
else
  noremap <Leader>f :FZF<CR>
endif

if has('termguicolors')
  try
    set termguicolors
    silent! colorscheme base16-solarflare
  catch
    set notermguicolors
  endtry
endif
