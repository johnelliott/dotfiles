" Linting
"let g:ale_linters_explicit = 1
let g:ale_linters = { 'javascript': ['standard'], 'css': ['stylelint'] }
let g:ale_fixers = { 'javascript': ['standard'], 'css': ['stylelint'] }
let local_semistandard = finddir('node_modules', '.;') . '/.bin/semistandard'
if executable(local_semistandard)
  let g:ale_javascript_standard_executable = local_semistandard
endif
let local_prettier = finddir('node_modules', '.;') . '/.bin/prettier'
if executable(local_prettier)
  let g:ale_linters = {}
  let g:ale_fixers = { '*': ['prettier'] }
  let b:ale_fix_on_save = 1
endif
" http://stackoverflow.com/questions/28573553 Updated for w0rp/ale
let eslintrc = findfile('.eslintrc', '.;')
if eslintrc != ''
  let g:ale_linters = { 'javascript': ['eslint'] }
endif

" Colors & GUI
if has('gui_running')
  if has('touchbar')
    "remove items
    silent! aun TouchBar
    "add items
    "nme TouchBar.buffers :buffers<CR>
    nme TouchBar.marks :marks<CR>
    nme TouchBar.registers :registers<CR>
    "nme TouchBar.history :history<CR>
    "nme TouchBar.node\ % :!node %<CR>
    "nme icon=NSTouchBarSkipBackTemplate TouchBar.\<\< :cpf<CR>
    nme TouchBar.-flexspacenode- :
    nme icon=NSTouchBarRewindTemplate TouchBar.\< :cprevious<CR>
    nme TouchBar.clist :clist<CR>
    nme icon=NSTouchBarFastForwardTemplate TouchBar.\> :cnext<CR>
    nme TouchBar.-smain- :
    nme TouchBar.dark :silent! exec "colo ".dark<CR>
    nme TouchBar.light :silent! exec "colo ".light<CR>
    "nme icon=NSTouchBarSkipAheadTemplate TouchBar.\>\> :cnf<CR>
    nme TouchBar.-s3- :
    for i in ['🧐', '🤖', '🤮', '🐠', '👻', '⚠️', '🔮', '🤡', '🚨', '🎾', '👿', ]
      exec "ime TouchBar.".i." ".i
    endfor
    "an TouchBar.\.vimrc :tabe $MYVIMRC<CR>
    "an icon=NSTouchBarColorPickerStroke TouchBar.colo :colo *
    "an TouchBar.Escape\ Escape\ Escape\ Escape <Esc>
  endif
endif
