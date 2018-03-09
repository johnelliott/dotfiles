se guifont=Inconsolata:h15
se guioptions=mg

" make grep faster on OSX with ag
if executable('ag')
  se grepprg=ag\ --vimgrep\ $*
  se grepformat=%f:%l:%c:%m
endif

if strftime("%H") < 17
  silent! colo base16-atelier-forest-light
else
  silent! colo base16-solarflare
endif
