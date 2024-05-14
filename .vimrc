unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs fo+=j gd ic wic sc
se ts=4 et sts=2 sw=2 pvh=18
se udir=~/.vim/undo cb=unnamed

se nocul

" tmux knows the extended mouse mode
if has("mouse_sgr")
  se ttym=sgr
endif

if executable('rg')
  se gp=rg\ --vimgrep\ $*
elseif executable('ag')
  se gp=ag\ --vimgrep\ $*
endif

func! BgDark()
  se bg=dark
  "try
  "  if has('gui_macvim')
  "    "colo monokai
  "    colo lunaperche
  "  else
  "    "call Dim()
  "    colo lunaperche
  "  endif
  "  "colo jellybeans
  "catch /^Vim\%((\a\+)\)\=:E185/
  "  colo default
  "endtry
endfunc

func! BgLight()
  se bg=light
  "try
  "  if has('gui_macvim')
  "    colo lunaperche
  "    "colo monokai
  "  else
  "    colo lunaperche
  "    "colo github
  "  endif
  "catch /^Vim\%((\a\+)\)\=:E185/
  "  colo default
  "endtry
endfunc

func! SetColor()
  colo lunaperche
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
  "se guifont=SF\ Mono:h12,Monaco:h12,Menlo:h13
  se guifont=Monaco:h12,Menlo:h13,SF\ Mono:h12
  se blurradius=2
  se transparency=2
else
  nn <space>m :! open -a macvim.app %<CR><CR>
endif

nn <space>s :up<CR>
nn <space>n :se nu!<CR>
nn <space>N :se rnu!<CR>
nn <space>o :cope<CR>
nn <space>l :se wrap!<CR>
nn <space>L :se lbr!<CR>
nn <space>h :noh<CR>
nn <space>H :se hls!<CR>
nn <space>R :tabe $MYVIMRC<CR>
"nn <space>c :Colors<CR>
nn <space>c :colo<space>
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

let g:gitgutter_enabled=0 " Don't start gg at startup
let g:ale_set_loclist=1
let g:ale_set_quickfix=0
let g:gruvbox_italic=0
let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_sign_column='bg0'

nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>I# <esc>o<esc>0
ino <C-e>1 🧐
ino <C-e>2 🔶
ino <C-e>3 🐠
ino <C-e>4 🦁
ino <C-e>5 🦖
ino <C-e>6 😎

" names
iab miccah Miccah
iab greg Greg
iab hameto Hameto
iab aaron Aaron
iab dilian Dilian
iab tripp Tripp

""" if has('gui_macvim')
"""   aug ui
"""     au!
"""     au OSAppearanceChanged * call SetColor()
"""   aug end
""" endif

aug javascript
  au!
  let b:ale_fix_on_save=0
<<<<<<< Updated upstream
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,.eslintrc,.nycrc se ft=json
  au filetype json,rust,javascript,javascript.jsx,typescript setl ls=2 nu
  au filetype javascript,javascript.jsx,typescript nn <buffer> <space>l "lyiwoconsole.log('l', l);0
||||||| Stash base
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,*.eslintrc,.nycrc se ft=json
  au filetype json,rust,javascript,javascript.jsx,typescript setl ls=2 nu
  au filetype javascript,javascript.jsx,typescript nn <buffer> <space>l "lyiwoconsole.log('l', l);0
=======
  au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,*.eslintrc,.nycrc se ft=json
  au filetype json,rust,javascript,javascript.jsx,typescript,typescriptreact setl ls=2 nu
  au filetype javascript,javascript.jsx,typescript,typescriptreact nn <buffer> <space>l "lyiwoconsole.log(`💬 l`, l);0
  au filetype javascript,javascript.jsx,typescript,typescriptreact nn <buffer> <space>L "lyiwolog('l ' + l);0
  "au filetype javascript,javascript.jsx,typescript nn <buffer> <space>L "lyiwolog('^R" ' + ^R");^[<80><fd>a0
>>>>>>> Stashed changes
  au bufnewfile,bufread *.test.js let b:ale_fix_on_save=0
  if executable('mdn')
    au filetype javascript,javascript.jsx setl kp=mdn
  endif
aug end

aug cpp
  au!
  au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et nu
  au filetype cpp se cmdheight=2
  au filetype cpp let g:ale_linters = { 'cpp': ['gcc'] }
  au filetype cpp let g:ale_fixers = { 'cpp': ['uncrustify'] }
aug end

aug scheme
  au!
  au filetype scheme nn <space>r :up\|!cat %\|scheme<CR>
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
  au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl
  let g:go_doc_keywordprg_enabled = 1
  au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et
<<<<<<< Updated upstream
  au filetype go setl ls=2 sw=4 sts=4 ts=4 noet nu
||||||| Stash base
  au filetype go setl ls=2 sw=4 sts=4 ts=4 noet nu nowrap
=======
  au filetype go setl ls=2 sw=4 sts=4 ts=4 noet cmdheight=2
  "au filetype go setl nu nowrap
>>>>>>> Stashed changes
  au filetype go nn <space>r :up\|GoRun<CR>
  au filetype go nn <space>b :GoBuild<CR>
  au filetype go nn <space>k :GoDocBrowser <cword><CR>
  au filetype go nn <space>l yiwofmt.Println("<c-r>"", <c-r>")<CR>

  " hugo projects, until https://github.com/gohugoio/hugo/issues/3230 is
  " implemented
  au BufRead,BufNewFile ~/code/johnelliott.org/layouts/*.html setfiletype gohtmltmpl
  au BufRead,BufNewFile ~/code/johnelliott.org/layouts/*.xml setfiletype gotexttmpl
  au BufRead,BufNewFile ~/code/randophelliott/layouts/*.html setfiletype gohtmltmpl
aug end

" Learning python
aug python
  au!
  au filetype python nn <space>r :up\|!python %<CR>
aug end

aug markdown
  au!
  au filetype markdown setl lbr wrap
aug end

aug hdl
  au!
  " for Nand2Tetris
  au filetype hdl se sts=4 sw=4
aug end

" https://github.com/pearofducks/ansible-vim
aug ansible
  au!
  au BufRead,BufNewFile ~/code/ansible/**/*.yml set filetype=yaml.ansible
  au BufRead,BufNewFile ~/code/scn/ansible/**/*.yml set filetype=yaml.ansible
  au BufRead,BufNewFile ~/code/scn/ansible/*.yml set filetype=yaml.ansible
aug end


let g:monotone_color = [53, 4, 57]
let g:monotone_secondary_hue_offset = 17
let g:ale_c_parse_makefile=1
let g:ale_set_balloons=1
let g:sql_type_default = 'pgsql'
let g:ale_completion_enabled=1
"javascript
let g:jsx_ext_required = 0 " Highlight .js as .jsx
"linter setup
let g:ale_set_balloons=1
let g:ale_fix_on_save = 1
let g:ale_linters = { 'cpp': ['g++'], 'javascript': ['eslint'], 'css': ['stylelint'], 'html': ['stylelint'] }
let g:ale_fixers = { 'yaml': 'yamlfix', 'go': ['gofmt', 'goimports'], 'cpp': ['uncrustify'], 'javascript': ['eslint'], 'css': ['stylelint'], 'html': ['stylelint'] }

func! Dim()
  "colo github
  colo dim
  hi link GitGutterAdd          Type
  hi link GitGutterChange       Statement
  hi link GitGutterDelete       WarningMsg
  hi link GitGutterChangeDelete Statement
  hi SignColumn ctermbg=NONE
endfunc

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin() " https://github.com/junegunn/vim-plug
  " Extensions
  Plug 'airblade/vim-gitgutter'
  Plug 'editorconfig/editorconfig-vim'
  if executable('fzf')
    Plug 'junegunn/fzf.vim'
    Plug '/opt/homebrew/opt/fzf'
  endif
  sil! Plug 'w0rp/ale'
" post install (yarn install | npm install) then load plugin only for editing supported files
"  Plug 'prettier/vim-prettier', {
"    \ 'do': 'yarn install',
"    \ 'for': ['javascript', 'typescriptreact', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
  " Languages
  Plug 'nfnty/vim-nftables'
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
  Plug 'cmcaine/vim-uci'
  "Plug 'darfink/vim-plist'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'hashivim/vim-terraform'
  Plug 'fatih/vim-hclfmt'
  Plug 'vito-c/jq.vim'
  "Plug 'davidbeckingsale/writegood.vim'
  "  Plug 'RRethy/vim-hexokinase' " css colorizer
  "Plug 'pantharshit00/vim-prisma'
  Plug 'sevko/vim-nand2tetris-syntax'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ClockworkNet/vim-junos-syntax'

  " Colorschemes
  Plug 'jeffkreeftmeijer/vim-dim'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'plan9-for-vimspace/acme-colors'
  Plug 'crusoexia/vim-monokai'
  "Plug 'sjl/badwolf'

  " Disabled colors
  "Plug 'NLKNguyen/papercolor-theme'
  "Plug 'chriskempson/vim-tomorrow-theme'
  "Plug 'dracula/vim'
  "Plug 'reedes/vim-colors-pencil'
  Plug 'lifepillar/vim-solarized8'
  "Plug 'morhetz/gruvbox'
  "Plug 'rakr/vim-one'
  "Plug 'w0ng/vim-hybrid'
  "Plug 'Lokaltog/vim-monotone'
  "Plug 'qualiabyte/vim-colorstepper'
  "Plug 'ajh17/spacegray.vim'
  "Plug 'nanotech/jellybeans.vim'
  "Plug 'trusktr/seti.vim'
  "Plug 'vim-scripts/summerfruit256.vim'
  "Plug 'jnurmine/Zenburn'
  "Plug 'vim-scripts/bclear'
  " Monokais
  "Plug 'lsdr/monokai'
  "Plug 'sickill/vim-monokai'
  "Plug 'tomasr/molokai'
  "let g:molokai_original = 1
  call plug#end()
endif

call SetColor()
