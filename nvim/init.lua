-- Set <space> as the leader key
-- See `:help mapleader`
-- Need to set this first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- JE: trying my own config
vim.opt.swapfile = false
vim.opt.bk = false
vim.opt.hls = false
vim.opt.joinspaces = false
vim.opt.formatoptions:append("j")
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.pvh = 14
vim.opt.ts = 4
vim.opt.sts = 2
vim.opt.sw = 2
-- Note: vim-sleuth plugin alters shiftwidth etc.
vim.opt.cul = false
vim.opt.laststatus = 2

-- Enable break indent
vim.opt.breakindent = true

-- Disable annoying nvim replace preview when i'm trying to read my code
vim.opt.inccommand = ""

vim.opt.clipboard:append({ "unnamedplus" })

-- Completion suggestings form blog thing
-- vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
-- JE: i want select in there since I want to use c-x c-l
vim.opt.completeopt = { "menuone" }
-- vim.opt.shortmess = vim.opt.shortmess + { c = true}

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	source = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

-- My keybinds are in keymaps.lua
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[
  aug go
    au!
    "au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl
    let g:go_doc_keywordprg_enabled = 1
    "au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et
    "au filetype go setl ls=2 sw=4 sts=4 ts=4 noet
    "au filetype go setl nu nowrap
    au filetype go nn <space>r :up\|GoRun<CR>
    au filetype go nn <space>b :GoBuild<CR>
    au filetype go nn <space>k :GoDocBrowser <cword><CR>
    au filetype go nn <space>l yiwofmt.Println("🐽 <c-r>"", <c-r>")<CR>
    "au filetype go nn gb :Gitsigns blame_line<CR>
  aug end

  " JavaScript setup
  aug javascript
    au!
    au bufnewfile,bufread *.gltf,.graphqlrc,.stylelintrc,.babelrc,.firebaserc,*.eslintrc,.nycrc se ft=json
    "au filetype json,rust,javascript,javascript.jsx,typescript,typescriptreact setl ls=2 nu
    au filetype javascript,javascript.jsx,typescript,typescriptreact nn <buffer> <space>l "lyiwoconsole.log(`l=${l}`);0
    au filetype javascript,javascript.jsx,typescript,typescriptreact nn <buffer> <space>L "lyiwoconsole.log(`l`, l);0
    "au filetype javascript,javascript.jsx,typescript nn <buffer> <space>L "lyiwolog('^R" ' + ^R");^[<80><fd>a0
    " This MDN thing is from vim9
    "if executable('mdn')
    "  au filetype javascript,javascript.jsx setl kp=mdn
    "endif
  aug end
]])
