" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug '/usr/local/opt/fzf'
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'NLKNguyen/papercolor-theme'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'ekalinin/Dockerfile.vim'
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
if ($TERM_BG == 'dark')
  se bg=dark
  colo PaperColor
elseif ($TERM_BG == 'light')
  se bg=light
  if has('gui_running')
    if has('gui_macvim')
      colo macvim
    endif
  else
    colo PaperColor
  endif
endif

if has('gui_running')
  " if has('gui_macvim')
  "   "let macvim_skip_colorscheme = 1
  "   "colo macvim
  " endif
else
  if has('termguicolors')
    se notermguicolors
  endif
  nn <space>Q :!source dark<CR><CR>:se bg=dark<CR>
  nn <space>W :!source light<CR><CR>:se bg=light<CR>
endif

nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>d :r!date<CR><esc>I// <esc>
nn <space>[ :se co=123<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nn <space>r :tabe $MYVIMRC<CR>:vs ~/.vimrc.local<CR>
nn <space>t :tabe %<CR>

no <space>1 a🧐<esc>
no <space>2 a🧠<esc>
no <space>3 a🐠<esc>
no <space>4 a🔮<esc>
no <space>5 a🦁<esc>
no <space>6 a🦖<esc>
no <space>7 a🎾<esc>
no <space>8 a🔰<esc>
no <space>9 a🧐<esc>
no <space>0 a🤡<esc>

let g:gitgutter_enabled = 1
autocmd BufNewFile,BufRead .babelrc,.nycrc,.stylelintrc set syntax=json
autocmd FileType javascript,javascript.jsx set kp=mdn

"nn <space>h :h netrw-quickmap<CR>
nn <space>h :se hls!<CR>


se ls=2 cul nu rnu sc
