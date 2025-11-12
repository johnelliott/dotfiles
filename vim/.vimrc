unlet! skip_defaults_vim
if (filereadable($VIMRUNTIME .'/defaults.vim'))
  source $VIMRUNTIME/defaults.vim
elseif (filereadable($VIMRUNTIME .'/vimrc_example.vim'))
  source $VIMRUNTIME/vimrc_example.vim
endif

se noswapfile nobk nojs fo+=j gd ic wic sc nocul
se ts=4 et sts=2 sw=2 pvh=18
se udir=~/.vim/undo cb=unnamed

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
  try
    if has('gui_macvim')
      "colo monokai
      "colo lunaperche
    else
      "call Dim()
      "colo lunaperche
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
      "colo lunaperche
    else
      "colo lunaperche
    endif
  catch /^Vim\%((\a\+)\)\=:E185/
    colo default
  endtry
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

nn <space>d o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>I# <esc>o<esc>0

""" if has('gui_macvim')
"""   aug ui
"""     au!
"""     au OSAppearanceChanged * call SetColor()
"""   aug end
""" endif

aug markdown
  au!
  au filetype markdown setl lbr wrap
aug end

call SetColor()
