se guifont=Inconsolata:h15
se linespace=0
se guioptions=mg

" macvim window size
se lines=56
se columns=128

" grep with ag
se grepprg=ag\ --vimgrep\ $*
se grepformat=%f:%l:%c:%m

silent! colo base16-monokai
