unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se nocp noswapfile nobk nojs gd ic wic hls sc
se ts=4 et sts=2 sw=2
se udir=~/.vim/undo cb=unnamed
se bg=dark
let g:netrw_banner = 0

nn <space>s :up<CR>
nn <space>r :tabe $MYVIMRC<CR>
nn <space>c :colo *
nn <space>q :se bg=dark<CR>
nn <space>w :se bg=light<CR>
nn <space>Q :se bg=dark<CR>:! dark<CR>
nn <space>W :se bg=light<CR>:! light<CR>
nn <space>[ :se co=122<CR><C-W>=
nn <space>] :se co=212<CR><C-W>=

nn <space>t :tabe %<CR>
nn <space>E :Sex<CR>
nn <space>e :Ex<CR>
nn <space>v :Vex<CR>
nn <c-p> :FZF<CR>
nn <space>p :Tags<CR>

nn <Up> :cp<CR>
nn <Down> :cn<CR>
nn <Left> :cpf<CR>
nn <Right> :cnf<CR>
nn ]l :ALENext<CR>
nn [l :ALEPrevious<CR>

nn <space>F :ALEInfo<CR>
nn <space>f :ALEFix<CR>
nn <space>g :GitGutterToggle<CR>

nn <space>d o<esc>:r!date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>2E

func! PostPlug()
  if has('gui_running') && (has('gui_macvim'))
    se transparency=5
    se blurradius=15
    colo papercolor "deep-space jellybeans inkpot molokai smyck
  else
    silent! colo dim
  endif
endfunc

autocmd BufNewFile,BufRead .stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc set filetype=json
autocmd FileType javascript,javascript.jsx setl cul nu ls=2
if executable('mdn')
  autocmd FileType javascript,javascript.jsx setl kp=mdn
endif

silent! call plug#begin() " https://github.com/junegunn/vim-plug
silent! Plug 'Glench/Vim-Jinja2-Syntax'
silent! Plug 'NLKNguyen/papercolor-theme'
silent! Plug 'airblade/vim-gitgutter'
silent! Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
silent! Plug 'cespare/vim-toml'
silent! Plug 'chr4/nginx.vim'
silent! Plug 'digitaltoad/vim-pug',
silent! Plug 'editorconfig/editorconfig-vim'
silent! Plug 'ekalinin/Dockerfile.vim'
silent! Plug 'jeffkreeftmeijer/vim-dim'
silent! Plug 'jparise/vim-graphql'
silent! Plug 'junegunn/fzf.vim'
silent! Plug 'lifepillar/pgsql.vim'
silent! Plug 'moll/vim-node'
silent! Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
silent! Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
silent! Plug 'rust-lang/rust.vim', { 'for': 'rust' }
silent! Plug 'stephenway/postcss.vim'
silent! Plug 'w0rp/ale'
silent! Plug '/usr/local/opt/fzf'
silent! Plug 'prettier/vim-prettier'
  \ 'for': ['javascript', 'typescript', 'css', 'less',
    \ 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"silent! Plug 'vim-scripts/xoria256.vim'
"silent! Plug 'flazz/vim-colorschemes'
silent! call plug#end()
call PostPlug()

let g:sql_type_default = 'pgsql'
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
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

if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
endif

if has('gui_running')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h13,Inconsolata:h15,Menlo:h13
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

ia :brain: 🧠
ia :clown: 🤡
ia :dino: 🦖
ia :face: 🤪
ia :fish: 🐠
ia :guy: 😎
ia :hmm: 🧐
ino <C-e>1 🧐
ino <C-e>2 🧠
ino <C-e>3 🐠
ino <C-e>4 🔮
ino <C-e>5 🦁
ino <C-e>6 🦖
ino <C-e>7 🎾
ino <C-e>8 🔰
ino <C-e>9 🤡
