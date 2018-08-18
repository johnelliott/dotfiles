silent! source $VIMRUNTIME/defaults.vim
se nocp noswapfile nobk nojs gd ic wmnu wic
se ts=4 et sts=2 sw=2 bs=indent,eol,start
se udir=~/.vim/undo cb=unnamed mouse=a
sy on

"Departures
"se nu
"se lbr
"se nowrap
"se so=1
se ls=2
"nn <space>h :se hls!<CR>
"nn <space>n :noh<CR>
nn gn :bn<CR>
nn gN :bp<CR>
nn gp :bp<CR>

nn <space>s :up<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>m :! open -a macvim.app %<CR><CR>
nn <space>c :colo *
nn <space>d o<esc>:r!date<CR><esc>o<esc>
nn <space>g :GitGutterLineHighlightsToggle<CR>
nn <space>f :ALEFix<CR>
nn <c-p> :FZF<CR>
nn <space>e :Sex<CR>
nn <space>v :Vex<CR>
nn <space>[ :se co=130<CR><C-W>=
nn <space>] :se co=224<CR><C-W>=
let g:netrw_banner = 0

autocmd BufNewFile,BufRead .babelrc,.nycrc,.firebaserc set syntax=json

" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug '/usr/local/opt/fzf'
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'chriskempson/base16-vim'
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
silent! call plug#end()

" JSX
let g:jsx_ext_required = 0 " Highlight .js as .jsx

" GitGutter
let g:gitgutter_enabled = 1

" Ale, async linter
let g:ale_set_loclist = 0
hi link ALEError SpellLocal
let g:ale_linters_explicit = 1
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

" make grep faster on OSX with ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  "se grepformat=%f:%l:%c:%m
endif

" Colors & GUI
if has('gui_running')
  let dark = 'base16-harmonic-dark'
  let light = 'base16-one-light'
  let day = strftime("%w")
  let hour = strftime("%H")
  if day < 6 && day > 0 && hour > 8 && hour < 18
    silent! exec "colo ".light
  else
    silent! exec "colo ".dark
  endif

  "must set go one-at-a-time
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
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
    nme TouchBar.dark :silent! exec "colo ".dark<CR>
    nme TouchBar.light :silent! exec "colo ".light<CR>
    "nme icon=NSTouchBarSkipAheadTemplate TouchBar.\>\> :cnf<CR>
    nme TouchBar.-s3- :
    for i in ['🧐', '🤖', '🤮', '🐠', '👻', '⚠️', '🔮', '🤡', '🚨', '🎾', '👿', ]
      exec "ime TouchBar.".i." ".i
    endfor
    "an TouchBar.\.vimrc :tabe $MYVIMRC<CR>
    "an icon=NSTouchBarColorPickerStroke TouchBar.colo :colo *
    "an TouchBar.Escape\ Escape\ Escape\ Escape <Esc>
  endif
else
  if has('termguicolors')
    se notermguicolors
    silent! colo base16-eighties
  endif
endif
