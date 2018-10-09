silent! source $VIMRUNTIME/defaults.vim
se nocp noswapfile nobk nojs gd ic wmnu wic
se ts=4 et sts=2 sw=2 bs=indent,eol,start
se udir=~/.vim/undo cb=unnamed mouse=a
sy on

nn <space>[ :se co=106<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nn <space>c :colo *
nn <space>d o<esc>:r!date<CR><esc>o<esc>
nn <space>e :Sex<CR>
nn <space>f :ALEFix<CR>
nn <space>m :! open -a macvim.app %<CR><CR>
nn <space>n :bn<CR>
nn <space>p :bp<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <c-p> :FZF<CR>
nn <space>s :up<CR>
nn <space>v :Vex<CR>
autocmd BufNewFile,BufRead .babelrc,.firebaserc set syntax=json
let g:netrw_banner = 0

func! PostPlug() "call last
  if has('termguicolors')
    se notermguicolors
    silent! colo base16-default
  endif
  if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
endfunc

" Make grep faster on OSX with ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  "se grepformat=%f:%l:%c:%m
endif

if has('gui_running')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
endif

" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug '/usr/local/opt/fzf'
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'digitaltoad/vim-pug',
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'jparise/vim-graphql'
silent! Plug 'junegunn/fzf.vim'
silent! Plug 'moll/vim-node'
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'w0rp/ale'
silent! Plug 'stephenway/postcss.vim'
silent! Plug 'ekalinin/Dockerfile.vim'
silent! Plug 'prettier/vim-prettier'
silent! Plug 'lifepillar/pgsql.vim'
"silent! Plug 'cespare/vim-toml'
silent! Plug 'NLKNguyen/papercolor-theme'
silent! Plug 'chriskempson/base16-vim'
"silent! Plug 'cocopon/iceberg.vim'
silent! Plug 'endel/vim-github-colorscheme'
silent! Plug 'juanedi/predawn.vim'
silent! Plug 'mhinz/vim-janah'
silent! Plug 'morhetz/gruvbox'
silent! Plug 'nanotech/jellybeans.vim'
silent! Plug 'noahfrederick/vim-hemisu'
silent! Plug 'plan9-for-vimspace/acme-colors'
silent! Plug 'rakr/vim-one'
silent! Plug 'reedes/vim-colors-pencil'
let g:pencil_gutter_color = 1
let g:pencil_higher_contrast_ui = 0
let g:pencil_neutral_code_bg = 0
let g:pencil_neutral_headings = 0
let g:pencil_spell_undercurl = 0

silent! call plug#end()
let g:sql_type_default = 'pgsql'
let g:jsx_ext_required = 0 " Highlight .js as .jsx
let g:gitgutter_enabled = 0
let g:ale_set_loclist = 0
hi link ALEError SpellLocal

call PostPlug()
