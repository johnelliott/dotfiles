unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
se nocp noswapfile nobk nojs gd ic wmnu wic
se ts=4 et sts=2 sw=2 bs=indent,eol,start ls=2
se udir=~/.vim/undo cb=unnamed mouse=a
sy on
nnoremap <space>s :up<CR>
"nnoremap <space>r :tabe $MYVIMRC<CR>:sp $MYGVIMRC<CR>
nnoremap <space>r :tabe $MYVIMRC<CR>
nnoremap <space>h :se hls!<CR>
nnoremap <Space>c :colo *

" daily JS coding
se nu nornu lbr wrap ls=2

" Plugins via vim-plug: https://github.com/junegunn/vim-plug
silent! call plug#begin()
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'digitaltoad/vim-pug',
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'chriskempson/base16-vim'
silent! Plug 'w0rp/ale'
silent! Plug 'jparise/vim-graphql'
silent! call plug#end()

" JSX
let g:jsx_ext_required = 0 " Highlight .js as .jsx

" GitGutter
let g:gitgutter_enabled = 1

" Ale, async linter
let g:ale_linters = { 'javascript': ['eslint', 'standard'] }
let g:ale_sign_column_always = 1
"let g:ale_javascript_standard_executable = 'semistandard'

" Have es-lint installed globally even when `npm bin` returns local path

" Find local .eslint if it exists
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
" Set eslint executable if we found it
if executable(local_eslint)
  let g:ale_javascript_eslint_executable = local_eslint
else
  let g:ale_javascript_eslint_executable = '$(npm bin)/eslint'
endif
" Find local semistandard  if it exists
let local_standard = finddir('node_modules', '.;') . '/.bin/semistandard'
" Find local semistandard  if it exists
if local_standard == ''
  let local_standard = finddir('node_modules', '.;') . '/.bin/standard'
endif
" Set standard/semistandard executable if we found it
if matchstr(local_standard, "^\/\\w") == ''
  let local_standard = getcwd() . "/" . local_standard
endif
if executable(local_standard)
  let g:ale_javascript_standard_executable = local_standard
else
  let g:ale_javascript_standard_executable = '$(npm bin)/standard'
endif
" http://stackoverflow.com/questions/28573553 Updated for w0rp/ale
autocmd FileType javascript let b:ale_linters = findfile('.eslintrc', '.;') != '' ? { 'javascript': ['eslint'] } : { 'javascript': ['standard'] }

" make grep faster on OSX with ag
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  "se grepformat=%f:%l:%c:%m
endif

" Colors
if has('termguicolors')
  set notermguicolors
  silent! colorscheme base16-monokai
endif
