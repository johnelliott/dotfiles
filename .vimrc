unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs fo+=j gd ic wic sc
se ts=4 et sts=2 sw=2 pvh=18
se udir=~/.vim/undo cb=unnamed

" tmux knows the extended mouse mode
if &term =~ '^screen'
  "se ttym=xterm2
  "se mouse-=v
elseif has("mouse_sgr")
  se ttym=sgr
endif

if executable('rg')
  se gp=rg\ --vimgrep\ $*
elseif executable('ag')
  se gp=ag\ --vimgrep\ $*
endif

func! BgDark()
  se bg=dark
  try
    if has('gui_macvim')
      colo jellybeans
    else
      call Dim()
      "colo Tomorrow-Night
    endif
    "colo jellybeans
  catch /^Vim\%((\a\+)\)\=:E185/
    colo default
  endtry
endfunc

func! BgLight()
  se bg=light
  try
    if has('gui_macvim')
      colo Tomorrow
    else
      call Dim()
    endif
  catch /^Vim\%((\a\+)\)\=:E185/
    colo default
  endtry
endfunc

func! SetColor()
  try
    " macvim
    if has("gui_macvim")
      if v:os_appearance == 1 | v:os_appearance == 3
        call BgDark()
      else
        call BgLight()
      endif
    else
      " Use defaults when v:os_appearance isn't available
      if has('osxdarwin')
        if (system("defaults read NSGlobalDomain AppleInterfaceStyle") ==? "Dark\n")
          call BgDark()
        else
          call BgLight()
        endif
      endif
    endif
  catch /^Vim\%((\a\+)\)\=:E185/
    colo default
  endtry
endfunc

let g:ale_fix_on_save=0

if has('gui_macvim')
  " guioptions are changed individually
  se go-=e "native tab pages
  se go-=r "permenant right scrollbar
  se go-=L "some other scrollbar
  se go+=k "keep window size
  se guifont=SF\ Mono:h12,Inconsolata:h15,Menlo:h13
  se blurradius=2
  se transparency=2
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

nn <space>s :up<CR>
nn <space>n :se nu!<CR>
nn <space>N :se rnu!<CR>
nn <space>8 :gr <cword><CR>
nn <space>o :cope<CR>
nn <space>l :se wrap!<CR>
nn <space>L :se lbr!<CR>
nn <space>h :noh<CR>
nn <space>H :se hls!<CR>
nn <space>R :tabe $MYVIMRC<CR>
nn <space>c :colo *
nn <space>q :call BgDark()<CR>
nn <space>w :call BgLight()<CR>
nn <space>Q :call BgDark()<CR>:! dark<CR>
nn <space>W :call BgLight()<CR>:! light<CR>
nn <space>[ :se co=132<CR><c-W>=<c-l>
nn <space>] :se co=230<CR><c-W>=<c-l>
nn <space>t :tabe %<CR>
nn <space>e :Ex<CR>
nn <space>E :Sex<CR>
nn <space>v :Vex<CR>
nn <space>1 :call UsePrettier()<CR>:ALELint<CR>:echom 'prettier'<CR>
nn <space>2 :call UseStandard()<CR>:ALELint<CR>:echom 'standard'<CR>
nn <space>3 :call UseSemiStandard()<CR>:ALELint<CR>:echom 'semistandard'<CR>
nn <space>3 :call UseEslint()<CR>:ALELint<CR>:echom 'eslint'<CR>
nn ]e <Plug>(ale_next)
nn [e <Plug>(ale_previous)
nn <space>g :GitGutterToggle<CR>
nn <space>f :ALEFix<CR>
nn <c-p> :FZF<CR>
nn <space>p :Tags<CR>

nn <Up> :cp<CR>
nn <Down> :cn<CR>
nn <Left> :cpf<CR>
nn <Right> :cnf<CR>
nn g<Left> :colder<CR>
nn g<Right> :cnewer<CR>
nn g<Up> :cope<CR>
nn g<Down> :ccl<CR>
nn <PageUp> :lp<CR>
nn <PageDown> :lne<CR>
nn g<PageUp> :lop<CR>
nn g<PageDown> :lcl<CR>

let g:ale_set_loclist=1
let g:ale_set_quickfix=0
let g:gruvbox_italic=0
let g:gruvbox_contrast_light='medium'
let g:gruvbox_contrast_dark='soft'

nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>o<esc>
ino jj <esc>
ino <C-e>1 🧐
ino <C-e>2 🔶
ino <C-e>3 🐠
ino <C-e>4 🦁
ino <C-e>5 🦖
ino <C-e>6 😎

if has('gui_macvim')
  aug ui
    au!
    au OSAppearanceChanged * call SetColor()
  aug end
endif

aug javascript
  au!
  let b:ale_fix_on_save=0
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc se ft=json
  au filetype json,rust,javascript,javascript.jsx,typescript setl ls=2
  au filetype javascript,javascript.jsx,typescript nn <buffer> <space>l "lyiwoconsole.log('l', l);0
  au bufnewfile,bufread *.test.js let b:ale_fix_on_save=0
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

aug webloc
  au!
  " Output operations
  autocmd BufWriteCmd,FileWriteCmd *.webloc call plist#Write()

  " Input operations
  autocmd BufReadCmd *.webloc call plist#Read(1) | call plist#ReadPost()
  autocmd FileReadCmd *.webloc call plist#Read(0) | call plist#SetFiletype()
aug end

aug go
  au!
  let g:go_doc_keywordprg_enabled = 1
  au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et
  au filetype go setl ls=2 sw=4 sts=4 ts=4 noet
  au filetype go nn <space>r :up\|GoRun<CR>
  au filetype go nn <space>b :GoBuild<CR>
  au filetype go nn <space>k :GoDocBrowser <cword><CR>
  au filetype go nn <space>l yiwofmt.Println("<c-r>"", <c-r>")<CR>
aug end

aug markdown
  au!
  au filetype markdown setl lbr wrap
aug end

let g:monotone_color = [53, 4, 57]
let g:monotone_secondary_hue_offset = 17
let g:ale_c_parse_makefile=1
let g:ale_set_balloons=1
let g:sql_type_default = 'pgsql'
"let g:ale_completion_enabled=1
"javascript
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
let g:ale_set_balloons=1
let g:ale_fix_on_save = 1
let g:ale_linters = { 'cpp': ['g++'], 'javascript': ['eslint'], 'css': ['stylelint'], 'html': ['stylelint'] }
let g:ale_fixers = { 'go': ['gofmt', 'goimports'], 'cpp': ['uncrustify'], 'javascript': ['eslint'], 'css': ['stylelint'], 'html': ['stylelint'] }

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
    let g:ale_fixers.javascript = ['eslint']
    let g:ale_fixers['javascript.jsx'] = ['eslint']
    let g:ale_fixers.jsx = ['eslint']
  endif
endfunc

func! UsePrettier()
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

func! Dim()
  colo dim
  highlight link GitGutterAdd          Type
  highlight link GitGutterChange       Statement
  highlight link GitGutterDelete       WarningMsg
  highlight link GitGutterChangeDelete Statement
endfunc

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin() " https://github.com/junegunn/vim-plug
  " Extensions
  Plug 'airblade/vim-gitgutter'
  Plug 'editorconfig/editorconfig-vim'
  if executable('fzf')
    Plug 'junegunn/fzf.vim'
    Plug '/usr/local/opt/fzf'
  endif
  sil! Plug 'w0rp/ale'
  " Languages
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'vim-scripts/irssilog.vim'
  Plug 'isundil/vim-irssi-syntax'
  Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'scss.css'] }
  Plug 'cespare/vim-toml'
  Plug 'chr4/nginx.vim'
  Plug 'johnelliott/vim-kinesis-kb900'
  Plug 'digitaltoad/vim-pug',
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'jparise/vim-graphql'
  Plug 'leafgarland/typescript-vim'
  Plug 'lifepillar/pgsql.vim'
  Plug 'moll/vim-node'
  Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'fatih/vim-go'
  Plug 'stephenway/postcss.vim'
  Plug 'pearofducks/ansible-vim'
  Plug 'NLKNguyen/c-syntax.vim'
  Plug 'andrewstuart/vim-kubernetes'
  Plug 'darfink/vim-plist'
  Plug 'mustache/vim-mustache-handlebars'
  "  Plug 'RRethy/vim-hexokinase' " css colorizer
  " Colorschemes
  Plug 'Lokaltog/vim-monotone'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'chriskempson/vim-tomorrow-theme'
  Plug 'jeffkreeftmeijer/vim-dim'
  Plug 'morhetz/gruvbox'
  Plug 'nanotech/jellybeans.vim'
  Plug 'plan9-for-vimspace/acme-colors'
  Plug 'rakr/vim-one'
  Plug 'vim-scripts/bclear'
  call plug#end()
endif

call SetColor()

" TODO command! PackUpdate call pack#update()
" minpac
" volt
" dein.vim similar to plugupdate, deoplete

"call UseStandard()
"call UseSemiStandard()
"call UseEslint()

"let g:ycm_key_list_select_completion = []
"let g:ycm_key_list_previous_completion = []
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_key_detailed_diagnostics = ''
".....
"let g:ale_fixers = {
"            \ 'typescript': ['prettier'],
"            \ 'javascript': ['prettier'],
"            \ 'jsx': ['prettier'],
"            \ 'json': ['prettier'],
"            \ 'css': ['prettier'],
"            \ 'scss': ['prettier']
"            }
".....
"nnoremap <Leader>rr :YcmCompleter RefactorRename<Space>
"nnoremap <leader>jd :YcmCompleter GoTo<CR>
"nnoremap <leader>gt :YcmCompleter GetType<CR>
"nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
"nnoremap <Leader>b :YcmCompleter Format<CR>
"nnoremap <Leader>oi :YcmCompleter OrganizeImports<CR>
".....
"nnoremap <F5> :ALELint<CR>
"nnoremap <Leader>f :ALEFix<CR>
"nnoremap <Leader>d :ALEDetail<CR>
