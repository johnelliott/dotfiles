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
if has('gui_running')
  "if has('gui_macvim')
  "  let macvim_skip_colorscheme = 1
  "endif
else
  if has('termguicolors')
    se notermguicolors
  endif
  nn <space>Q :!source dark<CR><CR>:se bg=dark<CR>
  nn <space>W :!source light<CR><CR>:se bg=light<CR>
  if has('touchbar')
    "remove items
    silent! aun TouchBar
    "add items
    "nme TouchBar.buffers :buffers<CR>
    nme TouchBar.marks :marks<CR>
    nme TouchBar.registers :registers<CR>
    "nme TouchBar.history :history<CR>
    "nme TouchBar.node\ % :!node %<CR>
    "nme icon=NSTouchBarSkipBackTemplate TouchBar.\<\< :cpf<CR>
    nme TouchBar.-flexspacenode- :
    nme icon=NSTouchBarRewindTemplate TouchBar.\< :cprevious<CR>
    nme TouchBar.clist :clist<CR>
    nme icon=NSTouchBarFastForwardTemplate TouchBar.\> :cnext<CR>
    nme TouchBar.-smain- :
    nme TouchBar.dark :se background=dark<CR>
    nme TouchBar.light :se background=light<CR>
    "nme icon=NSTouchBarSkipAheadTemplate TouchBar.\>\> :cnf<CR>
    nme TouchBar.-s3- :
    for i in ['🧐', '🤖', '🤮', '🐠', '👻', '⚠️', '🔮', '🤡', '🚨', '🎾', '👿', ]
      exec "ime TouchBar.".i." ".i
    endfor
    "an TouchBar.\.vimrc :tabe $MYVIMRC<CR>
    "an icon=NSTouchBarColorPickerStroke TouchBar.colo :colo *
    "an TouchBar.Escape\ Escape\ Escape\ Escape <Esc>
  endif
endif
nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>d :r!date<CR><esc>I// <esc>
nn <space>[ :se co=116<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nn <space>r :tabe $MYVIMRC<CR>:vs ~/.vimrc.local<CR>
nn <space>t :tabe %<CR>

let g:gitgutter_enabled = 1
autocmd BufNewFile,BufRead .babelrc,.nycrc,.stylelintrc set syntax=json

"nn <space>h :h netrw-quickmap<CR>
nn <space>h :se hls!<CR>

"se bg=dark
if ($TERM_BG == 'dark')
  se bg=dark
elseif ($TERM_BG == 'light')
  se bg=light
endif

colo PaperColor
se ls=2
