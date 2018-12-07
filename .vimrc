unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif
se nocp noswapfile nobk nojs gd ic wic
se ts=4 et sts=2 sw=2
se udir=~/.vim/undo cb=unnamed
" Stuff I don't need because of defaults.vim
"sy on
"se mouse=a bs=indent,eol,start wmnu

nn <space>c :colo *
nn <space>e :Sex<CR>
nn <space>f :ALEFix<CR>
nn <space>n :bn<CR>
nn <space>p :bp<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>s :up<CR>
nn <space>v :Vex<CR>
let g:netrw_banner = 0

" Make grep faster on macOS using ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
endif

if has('gui_running')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

if filereadable(glob("~/.vimrc.local"))
  " if we have a local file, then just do that
  source ~/.vimrc.local
else
  autocmd BufNewFile,BufRead .stylelintrc,.babelrc,.firebaserc set syntax=json
  autocmd BufNewFile,BufRead *.js.applescript set syntax=javascript
  autocmd FileType javascript,javascript.jsx set kp=mdn
  nn <space>[ :se co=112<CR><C-W>=
  nn <space>] :se co=188<CR><C-W>=
  nn <space>d o<esc>:r!date<CR><esc>o<esc>
  nn <space>r :tabe $MYVIMRC<CR>
  nn <space>q :se bg=dark<CR>
  nn <space>w :se bg=light<CR>
  nn <space>Q :se bg=dark<CR>:! dark<CR>
  nn <space>W :se bg=light<CR>:! light<CR>
  nn <space>t :tabe  %<CR>

  ino <C-e>1 🧐
  ino <C-e>2 🧠
  ino <C-e>3 🐠
  ino <C-e>4 🔮
  ino <C-e>5 🦁
  ino <C-e>6 🦖
  ino <C-e>7 🎾
  ino <C-e>8 🔰
  ino <C-e>9 🤡

  " Plugins https://github.com/junegunn/vim-plug
  silent! call plug#begin()
  silent! Plug '/usr/local/opt/fzf'
  silent! Plug 'Glench/Vim-Jinja2-Syntax'
  silent! Plug 'NLKNguyen/papercolor-theme'
  silent! Plug 'airblade/vim-gitgutter'
  silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
  silent! Plug 'chr4/nginx.vim'
  silent! Plug 'digitaltoad/vim-pug',
  silent! Plug 'editorconfig/editorconfig-vim'
  silent! Plug 'ekalinin/Dockerfile.vim'
  silent! Plug 'jeffkreeftmeijer/vim-dim'
  silent! Plug 'jparise/vim-graphql'
  silent! Plug 'junegunn/fzf.vim'
  silent! Plug 'lifepillar/pgsql.vim'
  silent! Plug 'moll/vim-node'
  silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
  silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  silent! Plug 'prettier/vim-prettier'
  silent! Plug 'stephenway/postcss.vim'
  silent! Plug 'w0rp/ale'
  silent! call plug#end()
  nn <c-p> :FZF<CR>
  let g:sql_type_default = 'pgsql'
  let g:jsx_ext_required = 0 " Highlight .js as .jsx
  let g:gitgutter_enabled = 1
  let g:ale_set_loclist = 0
  let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
  let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }
  "let g:ale_linters_explicit = 0

  let g:apple_interface_style=system("defaults read -g AppleInterfaceStyle")
  if g:apple_interface_style ==? "dark\n"
    set bg=dark
  elseif g:apple_interface_style ==? "light\n"
    set bg=light
  endif
  silent! se notgc
  if has('gui_macvim')
    "let macvim_skip_colorscheme = 1
    colo macvim
  else
    silent! colo dim
  endif

  nn <space>x :!scheme < %<CR>
endif
