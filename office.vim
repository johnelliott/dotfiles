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
silent! Plug 'johnelliott/auto-darkmode.vim'
silent! Plug 'w0rp/ale'
silent! Plug 'jeffkreeftmeijer/vim-dim'
silent! call plug#end()
let g:gitgutter_enabled = 1

autocmd BufNewFile,BufRead .babelrc,.nycrc,.stylelintrc set syntax=json
autocmd FileType javascript,javascript.jsx set kp=mdn cul nu ls=2
se sc hls
nn <space>h :noh<CR>
nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>Q :se bg=dark<CR>:! dark<CR>
nn <space>W :se bg=light<CR>:! light<CR><CR>
nn <space>p :Tags<CR>
nn <space>d :r!date<CR><esc>
nn <space>[ :se co=123<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nn <space>r :tabe ~/.vimrc.local<CR>
nn <space>t :tabe %<CR>
nn <c-f> :ALEFix<CR>
nn <c-F> :ALEInfo<CR>
nn <c-p> :FZF<CR>

silent! se notgc
if has('gui_running')
  colo papercolor
else
  silent! colo dim
endif

" Linting
" http://stackoverflow.com/questions/28573553 Updated for w0rp/ale
"let eslintrc = findfile('.eslintrc', '.;')
let eslintrc = findfile('.eslintrc.json', '.;')
if eslintrc != ''
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'jsx': ['stylelint', 'eslint'],
  \   'javascript.jsx': ['stylelint', 'eslint'],
  \}
  let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'javascript.jsx': ['eslint'],
  \   'jsx': ['eslint']
  \}
else
  let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
  let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'] }
endif
"TODO learn vimscript 🙄
let local_std = finddir('node_modules', '.;') . '/.bin/standard'
if executable(local_std)
  let g:ale_javascript_standard_executable = local_std
endif
let local_std = finddir('node_modules', '.;') . '/.bin/semistandard'
if executable(local_std)
  let g:ale_javascript_standard_executable = local_std
endif
let local_std = finddir('node_modules', '.;') . '/.bin/standardx'
if executable(local_std)
  let g:ale_javascript_standard_executable = local_std
endif

ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🔮
ino <C-e>5 🦁
ino <C-e>6 🦖
ino <C-e>7 🎾
ino <C-e>8 🔰
ino <C-e>9 🤡
iab :hmm: 🧐
iab :brain: 🧠
iab :face: 🤪
iab :guy: 😎
iab :fish: 🐠
iab :dino: 🦖
iab :clown: 🤡
