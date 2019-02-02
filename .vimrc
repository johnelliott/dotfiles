unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs gd ic wic hls sc
se ts=4 et sts=2 sw=2
se udir=~/.vim/undo cb=unnamed
let g:netrw_banner = 0

aug javascript
  au!
  au BufNewFile,BufRead *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc se ft=json
  au FileType javascript,javascript.jsx setl nu ls=2
  au FileType rust,javascript,javascript.jsx  nn <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
  au FileType rust  nn <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
  au FileType rust,javascript,javascript.jsx  nn <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  au FileType javascript,javascript.jsx nn <buffer> <space>l "lyawoconsole.log('😫 l', l)0
  if executable('mdn')
    au FileType javascript,javascript.jsx setl kp=mdn
  endif
aug END

if executable('ag')
  se gp=ag\ --vimgrep\ $*
endif

if has('gui_macvim')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
  se blurradius=15

  aug plaintext
    au!
    au FileType text se lbr wrap
  aug END
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

nn <space>s :up<CR>
nn <space>h :noh<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>c :colo *
nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>Q :se bg=dark<CR>:! dark<CR>
nn <space>W :se bg=light<CR>:! light<CR>
nn <space>[ :se co=112<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
nm <space>F <Plug>(ale_info)
nm <space>f <Plug>(ale_fix)

nn <space>t :tabe %<CR>
nn <space>e :Ex<CR>
nn <space>E :Sex<CR>
nn <space>v :Vex<CR>
nn <c-p> :FZF<CR>
nn <space>p :Tags<CR>

nn <Up> :cp<CR>
nn <Down> :cn<CR>
nn <Left> :cpf<CR>
nn <Right> :cnf<CR>
nn ]l <Plug>(ale_next_wrap)
nn [l <Plug>(ale_previous_wrap)

nn <space>g :GitGutterToggle<CR>
nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>$

ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🦁
ino <C-e>5 🦖
ino <C-e>6 😎

sil! call plug#begin() " https://github.com/junegunn/vim-plug
sil! Plug 'Glench/Vim-Jinja2-Syntax'
sil! Plug 'NLKNguyen/papercolor-theme'
sil! Plug 'ap/vim-css-color'
sil! Plug 'airblade/vim-gitgutter'
sil! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
sil! Plug 'cespare/vim-toml'
sil! Plug 'chr4/nginx.vim'
sil! Plug 'digitaltoad/vim-pug',
sil! Plug 'editorconfig/editorconfig-vim'
sil! Plug 'ekalinin/Dockerfile.vim'
sil! Plug 'jeffkreeftmeijer/vim-dim'
sil! Plug 'jparise/vim-graphql'
sil! Plug 'junegunn/fzf.vim'
sil! Plug 'leafgarland/typescript-vim'
sil! Plug 'lifepillar/pgsql.vim'
sil! Plug 'moll/vim-node'
sil! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
sil! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
sil! Plug 'rust-lang/rust.vim', { 'for': 'rust' }
sil! Plug 'stephenway/postcss.vim'
sil! Plug 'w0rp/ale'
sil! Plug 'pearofducks/ansible-vim'
sil! Plug 'NLKNguyen/c-syntax.vim'
sil! Plug '/usr/local/opt/fzf'
sil! Plug 'plan9-for-vimspace/acme-colors'
sil! Plug 'prettier/vim-prettier'
      \ 'for': ['javascript', 'typescript', 'css', 'less',
      \ 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
sil! Plug 'flazz/vim-colorschemes'
sil!  Plug 'itchyny/lightline.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
sil! call plug#end()

func! SetDarkMode()
  if has('osxdarwin')
    if (system("defaults read NSGlobalDomain AppleInterfaceStyle") ==? "Dark\n")
      set background=dark
    endif
  endif
endfunc
if v:vim_did_enter
  call SetDarkMode()
else
  aug darkmode
    au!
    au ColorSchemePre * call SetDarkMode()
  aug END
endif

if has('gui_running')
  if &bg == 'dark'
    colo Atelier_DuneDark
    "colo papercolor
    "colo acme
    "colo deep-space
    "colo jellybeans
    "colo inkpot
    "colo molokai
    "colo smyck
  endif
else
  sil! colo dim
endif

"rust
"let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ }
    "\ 'python': ['/usr/local/bin/pyls'],

"javascript
let g:sql_type_default = 'pgsql'
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
let g:ale_fix_on_save = 1
let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }
let eslintrc = findfile('.eslintrc', '.;')
if eslintrc != ''
  let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'jsx': ['stylelint', 'eslint'],
        \   'javascript.jsx': ['stylelint', 'eslint'],
        \}
  let g:ale_fixers = {
        \   'javascript': ['eslint'],
        \   'javascript.jsx': ['eslint'],
        \   'jsx': ['eslint'],
        \   '*': ['trim_whitespace'],
        \}
else
  " otherwise check for standard variants in our projects
  let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
  let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }
  let node_modules = finddir('node_modules', '.;')
  if len(node_modules)
    " later elements will override, so standard versions are in reverse order
    let standard_exec_names = ['standard', 'semistandard', 'standardx']
    for e in standard_exec_names
      let exec = node_modules . '/.bin/' . e
      if executable(exec)
        let g:ale_javascript_standard_executable = exec
      endif
    endfor
  endif
endif
