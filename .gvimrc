se guifont=Inconsolata:h16
se linespace=0
se guioptions=mg

" macvim window size
se lines=70
se columns=140

" make grep faster on OSX with ag
if executable('ag')
  se grepprg=ag\ --vimgrep\ $*
  se grepformat=%f:%l:%c:%m
endif

if strftime("%H") < 16
  silent! colo base16-atelier-forest-light
else
  silent! colo base16-materia
endif
