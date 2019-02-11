unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs gd ic wic sc
se ts=4 et sts=2 sw=2
se udir=~/.vim/undo cb=unnamed

if executable('ag')
  se gp=ag\ --vimgrep\ $*
endif

func! Colors()
  if has('osxdarwin')
    if (system("defaults read NSGlobalDomain AppleInterfaceStyle") ==? "Dark\n")
      set background=dark
    endif
  endif

  if has('gui_running')
    "if &bg == 'light'
    "  colo bclear
    "elseif &bg == 'dark'
    "  colo Tomorrow-Night
    "else
    "  if has('gui_macvim')
    "    colo macvim
    "  endif
    "endif
    sil! colo papercolor
  else
    sil! colo dim
  endif
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
nn <space>h :noh<CR>
nn <space>H :se hls!<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>c :colo *
nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>Q :se bg=dark<CR>:! dark<CR>
nn <space>W :se bg=light<CR>:! light<CR>
nn <space>[ :se co=112<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=
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

nn <space>g :GitGutterToggle<CR>
nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>$

ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🦁
ino <C-e>5 🦖
ino <C-e>6 😎

aug javascript
  au!
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc se ft=json
  au filetype rust,javascript,javascript.jsx setl ls=2
  au filetype javascript,javascript.jsx nn <buffer> <space>l "lyiwoconsole.log('😫 l', l)0
  if executable('mdn')
    au filetype javascript,javascript.jsx setl kp=mdn
  endif
aug end

let g:netrw_banner=0
let g:gitgutter_enabled=0
let g:ale_c_parse_makefile=1
"let g:ale_completion_enabled=1
"
"LSP
"let g:CoC_autoStart = 0
"aug languageserver
"  au!
"  "CoC Remap keys for gotos
"  " g* are vim commands
"  au filetype javascript,javascript.jsx nmap <silent> <space>gd <Plug>(coc-definition)
"  au filetype javascript,javascript.jsx nmap <silent> <space>gy <Plug>(coc-type-definition)
"  au filetype javascript,javascript.jsx nmap <silent> <space>gi <Plug>(coc-implementation)
"  au filetype javascript,javascript.jsx nmap <silent> <space>gr <Plug>(coc-references)
"aug end

"javascript
let g:sql_type_default = 'pgsql'
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
let g:ale_fix_on_save = 1
"let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
"let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'], 'html': ['stylelint'] }
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

sil! call plug#begin() " https://github.com/junegunn/vim-plug
sil! Plug 'Glench/Vim-Jinja2-Syntax'
sil! Plug 'airblade/vim-gitgutter'
sil! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
sil! Plug 'cespare/vim-toml'
sil! Plug 'chr4/nginx.vim'
sil! Plug 'digitaltoad/vim-pug',
sil! Plug 'editorconfig/editorconfig-vim'
sil! Plug 'ekalinin/Dockerfile.vim'
sil! Plug 'jparise/vim-graphql'
sil! Plug 'junegunn/fzf.vim'
sil! Plug '/usr/local/opt/fzf'
sil! Plug 'leafgarland/typescript-vim'
sil! Plug 'lifepillar/pgsql.vim'
sil! Plug 'moll/vim-node'
sil! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
sil! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
sil! Plug 'rust-lang/rust.vim', { 'for': 'rust' }
sil! Plug 'stephenway/postcss.vim'
sil! Plug 'pearofducks/ansible-vim'
sil! Plug 'NLKNguyen/c-syntax.vim'
sil! Plug 'w0rp/ale'
"sil! Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'scss.css'] }
"sil! Plug 'prettier/vim-prettier'
"      \ 'for': ['javascript', 'typescript', 'css', 'less',
"      \ 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"Plug 'neoclide/coc.nvim', {'for': ['javascript', 'javascript.jsx'],'do': { -> coc#util#install()}}
"Color schemes
sil! Plug 'NLKNguyen/papercolor-theme'
sil! Plug 'chriskempson/vim-tomorrow-theme'
sil! Plug 'jeffkreeftmeijer/vim-dim'
sil! Plug 'jnurmine/Zenburn'
sil! Plug 'lsdr/monokai'
sil! Plug 'morhetz/gruvbox'
sil! Plug 'nanotech/jellybeans.vim'
sil! Plug 'plan9-for-vimspace/acme-colors'
sil! Plug 'rakr/vim-one'
sil! Plug 'reedes/vim-colors-pencil'
sil! Plug 'sickill/vim-monokai'
sil! Plug 'sjl/badwolf'
sil! Plug 'trusktr/seti.vim'
sil! Plug 'vim-scripts/bclear'
sil! Plug 'vim-scripts/summerfruit256.vim'
sil! Plug 'w0ng/vim-hybrid'
sil! call plug#end()

call Colors()
