silent! source $VIMRUNTIME/defaults.vim
se nocp noswapfile nobk nojs gd ic wmnu wic
se ts=4 et sts=2 sw=2 bs=indent,eol,start
se udir=~/.vim/undo cb=unnamed mouse=a
sy on

" Departures
"se nu lbr nowrap so=1 ls=2
nn <space>s :up<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>h :se hls!<CR>
nn <space>n :noh<CR>
nn <space>c :colo *
nn <space>d o<esc>:r!date<CR><esc>o<esc>
nn <space>g :GitGutterLineHighlightsToggle<CR>
nn <space>f :ALEFix<CR>
nn <space>t :FZF<CR>
nn <c-p> :e %:h/*
nn <space>e :Sex<CR>
nn <space>v :Vex<CR>
nn <space>[ :se co=130<CR><C-W>=
nn <space>] :se co=224<CR><C-W>=
let g:netrw_banner = 0

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
silent! call plug#end()

" JSX
let g:jsx_ext_required = 0 " Highlight .js as .jsx

" GitGutter
let g:gitgutter_enabled = 1

" Ale, async linter
let g:ale_set_loclist = 0
" fix annoting base16 error hightlighting
hi link ALEError SpellLocal
" let g:ale_set_quickfix = 1
let g:ale_fixers = { 'javascript': ['standard'], 'scss': ['stylelint'] }

let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if executable(local_eslint)
  let g:ale_javascript_eslint_executable = local_eslint
  let g:ale_linters = { 'javascript': ['eslint'] }
else
  let g:ale_javascript_eslint_executable = '$(npm bin)/eslint'
endif

let local_standard = finddir('node_modules', '.;') . '/.bin/semistandard'
if !executable(local_standard)
  let local_standard = finddir('node_modules', '.;') . '/.bin/standard'
endif
if executable(local_standard)
  let g:ale_javascript_standard_executable = local_standard
  let g:ale_linters = { 'javascript': ['standard'] }
else
  let g:ale_javascript_standard_executable = '$(npm bin)/semistandard'
endif
" http://stackoverflow.com/questions/28573553 Updated for w0rp/ale
autocmd FileType javascript let b:ale_linters = findfile('.eslintrc', '.;') != '' ? { 'javascript': ['eslint'] } : { 'javascript': ['standard'] }

" make grep faster on OSX with ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  "se grepformat=%f:%l:%c:%m
endif

" Colors & GUI
if has('gui_running')
  "must set go one-at-a-time
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
 let day = strftime("%w")
 let hour = strftime("%H")
 if day < 6 && day > 0 && hour > 8 && hour < 17
    "silent! colo base16-google-light
    silent! colo base16-one-light
    "silent! colo base16-atelier-forest-light
    "silent! colo base16-gruvbox-light-hard
 else
  "silent! colo base16-eighties
  silent! colo base16-onedark
  "silent! colo base16-gruvbox-dark-hard
  "silent! colo base16-monokai
 endif
else
  if has('termguicolors')
    se notermguicolors
    silent! colo base16-eighties
  endif
endif
