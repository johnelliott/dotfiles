unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set nocp noswapfile nobk nojs gd ic wmnu wic
set ts=4 et sts=2 sw=2 bs=indent,eol,start
set udir=~/.vim/undo cb=unnamed mouse=a
sy on
nnoremap <space>s :up<CR>

" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'digitaltoad/vim-pug',
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'chriskempson/base16-vim'
silent! Plug 'vim-syntastic/syntastic', { 'on': 'SyntasticCheck', 'for': ['javascript', 'javascript.jsx', 'jsx'] }
silent! call plug#end()

" JSX
let g:jsx_ext_required = 0 " Highlight .js as .jsx

" GitGutter
let g:gitgutter_enabled = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" Have es-lint installed globally even when `npm bin` returns local path
let g:syntastic_javascript_checkers = ['eslint', 'standard']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
else
  let g:syntastic_javascript_eslint_exec = '$(npm bin)/eslint'
endif
let local_standard = finddir('node_modules', '.;') . '/.bin/standard'
if matchstr(local_standard, "^\/\\w") == ''
  let local_standard = getcwd() . "/" . local_standard
endif
if executable(local_standard)
  let g:syntastic_javascript_standard_exec = local_standard
else
  let g:syntastic_javascript_standard_exec = '$(npm bin)/standard'
endif
" http://stackoverflow.com/questions/28573553
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']

" make grep faster on OSX with ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
endif

" Colors
if has('termguicolors')
  try
    set notermguicolors
    if (&background == "light")
      silent! colorscheme base16-google-light
    else
      silent! colorscheme base16-monokai
    endif
  endtry
endif
