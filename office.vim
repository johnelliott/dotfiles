" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug '/usr/local/opt/fzf'
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'NLKNguyen/papercolor-theme'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'ekalinin/Dockerfile.vim'
silent! Plug 'jeffkreeftmeijer/vim-dim'
silent! Plug 'jparise/vim-graphql'
silent! Plug 'junegunn/fzf.vim'
silent! Plug 'lifepillar/pgsql.vim'
silent! Plug 'moll/vim-node'
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'stephenway/postcss.vim'
silent! Plug 'w0rp/ale'
silent! call plug#end()
nn <c-p> :FZF<CR>
" Linting
"let g:ale_linters_explicit = 1
let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'] }
let local_semistandard = finddir('node_modules', '.;') . '/.bin/semistandard'
if executable(local_semistandard)
  let g:ale_javascript_standard_executable = local_semistandard
endif
let local_prettier = finddir('node_modules', '.;') . '/.bin/prettier'
if executable(local_prettier)
  let g:ale_linters = {}
  let g:ale_fixers = { '*': ['prettier'] }
  let b:ale_fix_on_save = 1
endif
" http://stackoverflow.com/questions/28573553 Updated for w0rp/ale
let eslintrc = findfile('.eslintrc', '.;')
if eslintrc != ''
  let g:ale_linters = { 'javascript': ['eslint'] }
endif

" Colors & GUI
if $TERM_BG =~? 'dark'
  set bg=dark
elseif $TERM_BG =~? 'light'
  set bg=light
endif
if has('gui_macvim')
  "let macvim_skip_colorscheme = 1
  colo macvim
else
  "silent! colo PaperColor
  silent! colo dim
endif
silent! se notgc

nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>d :r!date<CR><esc>I// <esc>
nn <space>[ :se co=123<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nn <space>r :tabe $MYVIMRC<CR>:vs ~/.vimrc.local<CR>
nn <space>t :tabe %<CR>

ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🔮
ino <C-e>5 🦁
ino <C-e>6 🦖
ino <C-e>7 🎾
ino <C-e>8 🔰
ino <C-e>9 🤡

let g:gitgutter_enabled = 1
autocmd BufNewFile,BufRead .babelrc,.nycrc,.stylelintrc set syntax=json
autocmd FileType javascript,javascript.jsx set kp=mdn

"nn <space>h :h netrw-quickmap<CR>
nn <space>h :se hls!<CR>

se ls=2 cul nu rnu sc hls
