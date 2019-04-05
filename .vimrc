unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs fo+=j gd ic wic sc
se ts=4 et sts=2 sw=2
se udir=~/.vim/undo cb=unnamed
se pvh=24
let g:netrw_liststyle= 3

if executable('ag')
  se gp=ag\ --vimgrep\ $*
endif

func! SetScheme()
  if has('gui_running')
    colo papercolor
  else
    colo dim
    highlight link GitGutterAdd          Type
    highlight link GitGutterChange       Statement
    highlight link GitGutterDelete       WarningMsg
    highlight link GitGutterChangeDelete Statement
  endif
endfunc

func! BgDark()
  se bg=dark
  call SetScheme()
endfunc

func! BgLight()
  se bg=light
  call SetScheme()
endfunc

if has('gui_macvim')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h12,Inconsolata:h15,Menlo:h13
  "se blurradius=15
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

nn <space>s :up<CR>
nn <space>n :se nu!<CR>
nn <space>N :se rnu!<CR>
nn <space>8 :gr <cword><CR>
nn <space>o :cope<CR>
nn <space>g :GitGutterToggle<CR>
nn <space>l :se wrap!<CR>
nn <space>h :noh<CR>
nn <space>H :se hls!<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>c :colo *
nn <space>q :call BgDark()<CR>
nn <space>w :call BgLight()<CR>
nn <space>Q :call BgDark()<CR>:! dark<CR>
nn <space>W :call BgLight()<CR>:! light<CR>
nn <space>[ :se co=140<CR><c-W>=<c-l>
nn <space>] :se co=242<CR><c-W>=<c-l>
nm <space>f <Plug>(ale_fix)
nn <space>t :tabe %<CR>
nn <space>e :Ex<CR>
nn <space>E :Sex<CR>
nn <space>v :Vex<CR>
nn <space>1 :call UseEslint()<CR>:ALELint<CR>
nn <space>2 :call UseStandard()<CR>:ALELint<CR>
nn <space>3 :call UseSemiStandard()<CR>:ALELint<CR>
nn <c-p> :FZF<CR>
nn <space>p :Tags<CR>
nn <Up> :cp<CR>
nn <Down> :cn<CR>
nn <Left> :cpf<CR>
nn <Right> :cnf<CR>
nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>o<esc>
ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🦁
ino <C-e>5 🦖
ino <C-e>6 😎

aug javascript
  au!
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc se ft=json
  au filetype json,rust,javascript,javascript.jsx setl ls=2
  au filetype javascript,javascript.jsx,typescript nn <buffer> <space>l "lyiwoconsole.log('😫 l', l);0
  if executable('mdn')
    au filetype javascript,javascript.jsx setl kp=mdn
  endif
aug end

aug cpp
  au!
  au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et
  au filetype cpp se cmdheight=2
  au filetype cpp let g:ale_linters = { 'cpp': ['gcc'] }
  au filetype cpp let g:ale_fixers = { 'cpp': ['uncrustify'] }
aug end

aug go
  au!
  au filetype go nn <space>r :up\|GoRun<CR>
aug end

let g:netrw_banner=0
"let g:gitgutter_enabled=0
let g:ale_c_parse_makefile=1
"let g:ale_completion_enabled=1
let g:sql_type_default = 'pgsql'
"javascript
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
let g:ale_fix_on_save = 1
let g:ale_linters = { 'cpp': ['g++'], 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }
let g:ale_fixers = { 'go': ['gofmt', 'goimports'], 'cpp': ['uncrustify'], 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }

func! UseEslint()
  let eslintrc = findfile('.eslintrc', '.;')
  if eslintrc != ''
    let g:ale_linters.scss = ['stylelint']
    let g:ale_linters.css = ['stylelint']
    let g:ale_linters.javascript = ['eslint']
    let g:ale_linters.jsx = ['stylelint', 'eslint']
    let g:ale_linters['javascript.jsx'] = ['stylelint', 'eslint']
    let g:ale_fixers.scss = ['stylelint']
    let g:ale_fixers.css = ['stylelint']
    let g:ale_fixers.javascript = ['eslint', 'prettier']
    let g:ale_fixers['javascript.jsx'] = ['eslint', 'prettier']
    let g:ale_fixers.jsx = ['eslint', 'prettier']
  endif
endfunc

func! StandardLinters()
  let g:ale_linters.scss = ['stylelint']
  let g:ale_linters.css = ['stylelint']
  let g:ale_linters.javascript = ['standard']
  let g:ale_linters.jsx = ['stylelint', 'standard']
  let g:ale_linters['javascript.jsx'] = ['stylelint', 'standard']
  let g:ale_fixers.scss = ['stylelint']
  let g:ale_fixers.css = ['stylelint']
  let g:ale_fixers.javascript = ['standard']
  let g:ale_fixers['javascript.jsx'] = ['standard']
  let g:ale_fixers.jsx = ['standard']
endfunc

func! UseSemiStandard()
  let node_modules = finddir('node_modules', '.;')
  if len(node_modules)
    let exec = node_modules . '/.bin/semistandard'
    if executable(exec)
      let g:ale_javascript_standard_executable = exec
      let g:ale_javascript_eslint_use_global = 1
      call StandardLinters()
    endif
  endif
endfunc

func! UseStandard()
  let node_modules = finddir('node_modules', '.;')
  if len(node_modules)
    let exec = node_modules . '/.bin/standard'
    if executable(exec)
      let g:ale_javascript_standard_executable = exec
      let g:ale_javascript_eslint_use_global = 1
      call StandardLinters()
    endif
  endif
endfunc

sil! call plug#begin() " https://github.com/junegunn/vim-plug
" Extensions
sil! Plug 'airblade/vim-gitgutter'
sil! Plug 'editorconfig/editorconfig-vim'
sil! Plug 'junegunn/fzf.vim'
sil! Plug '/usr/local/opt/fzf'
sil! Plug 'w0rp/ale'
" Languages
sil! Plug 'Glench/Vim-Jinja2-Syntax'
sil! Plug 'vim-scripts/irssilog.vim'
sil! Plug 'isundil/vim-irssi-syntax'
sil! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
sil! Plug 'cespare/vim-toml'
sil! Plug 'chr4/nginx.vim'
sil! Plug 'johnelliott/vim-kinesis-kb900'
sil! Plug 'digitaltoad/vim-pug',
sil! Plug 'ekalinin/Dockerfile.vim'
sil! Plug 'jparise/vim-graphql'
sil! Plug 'leafgarland/typescript-vim'
sil! Plug 'lifepillar/pgsql.vim'
sil! Plug 'moll/vim-node'
sil! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
sil! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
sil! Plug 'rust-lang/rust.vim', { 'for': 'rust' }
sil! Plug 'fatih/vim-go'
sil! Plug 'stephenway/postcss.vim'
sil! Plug 'pearofducks/ansible-vim'
sil! Plug 'NLKNguyen/c-syntax.vim'
" Colorschemes
sil! Plug 'jeffkreeftmeijer/vim-dim'
sil! Plug 'NLKNguyen/papercolor-theme'
sil! Plug 'rakr/vim-one'
sil! Plug 'plan9-for-vimspace/acme-colors'
sil! call plug#end()

if has('osxdarwin')
  if (system("defaults read NSGlobalDomain AppleInterfaceStyle") ==? "Dark\n")
    set background=dark
  endif
endif
call SetScheme()
