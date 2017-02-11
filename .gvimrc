set guifont=Menlo:h13
set linespace=0
set guioptions=mg

" macvim window size
set lines=44
set columns=120

" grep with ag
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set number
set laststatus=2
set relativenumber
set scrolloff=2
set linebreak
let g:gitgutter_enabled = 1
