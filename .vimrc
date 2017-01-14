" basics
set nocompatible
set ttyfast
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set modelines=0
set nobackup
set noswapfile
set nowritebackup

" mechanics
set backspace=indent,eol,start " Allow backspace in insert mode
set esckeys " Allow cursor keys in insert mode
set nojoinspaces
set tabstop=4
set expandtab
set softtabstop=2
set shiftwidth=2

" searches
set gdefault " default global search with s/a/b/
set wildmenu
set ignorecase " Ignore case of searches
set wildignore+=.*
if exists("&wildignorecase")
  set wildignorecase
endif

" feedback
set shortmess=atI
if has('belloff')
  silent! set belloff=error,esc
endif
set lcs=tab:»\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set scrolloff=5
set nocursorline
set showmode
set showcmd
set ruler
set title
set laststatus=2
set incsearch " Highlight dynamically as pattern is typed
set nohlsearch
set list
set nowrap
set number
set relativenumber

let mapleader=","
nnoremap Q <nop>
noremap <Leader>s :update<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <Leader>l :set wrap! lbr!<CR>
nnoremap <Leader>r :set number! relativenumber!<CR>
" read date into buffer
nnoremap <Leader>d o<esc>:r!date<CR><esc>o<esc>
"vimrc helpers
nnoremap <Leader>ev :vs ~/.vimrc<CR>
nnoremap <Leader>! :source ~/.vimrc<CR>

if has("syntax")
  syntax on
  set synmaxcol=300 "2k screen
endif

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
if has("clipboard")
  set clipboard=unnamed
endif

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

if has("spell")
  set spelllang=en_us
  nnoremap <leader>p :set spell!<CR>
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Enable mouse in all modes
if has("mouse")
  set mouse=a
  set ttymouse=xterm2
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
silent! Plug 'vim-syntastic/syntastic', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
silent! Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
silent! Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
silent! Plug 'junegunn/fzf', { 'on': 'FZF' }
silent! Plug 'junegunn/fzf.vim', { 'on': 'FZF' }
silent! call plug#end()
noremap <Leader>t :NERDTreeToggle<CR>
if has('gui_macvim')
  noremap <Leader>f :CtrlP<CR>
else
  noremap <Leader>f :FZF<CR>
endif

let g:gitgutter_enabled = 1

" Highlight .js as .jsx
let g:jsx_ext_required = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
" Be sure to have eslint installed globally even when `npm bin` returns local
" path
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" let vim v7.4 use default colorscheme
if has('termguicolors')
  try
    set termguicolors
    colorscheme base16-default-dark
  catch
    set notermguicolors
    colorscheme default
  endtry
endif
if has('gui_macvim')
  silent! colorscheme base16-solar-flare
endif
noremap <Leader>c :colo base16-darktooth<CR>
noremap <Leader>v :colo base16-solar-flare<CR>
noremap <Leader>b :colo base16-bright<CR>
noremap <Leader>n :colo base16-google-light<CR>
noremap <Leader>m :colo base16-default-dark<CR>
