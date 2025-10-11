-- My keybinds
vim.keymap.set("n", "<leader>s", ":up<CR>")
vim.keymap.set("n", "<leader>n", ":se nu!<CR>")
vim.keymap.set("n", "<leader>N", ":se rnu!<CR>")
vim.keymap.set("n", "<leader>l", ":se wrap!<CR>")
vim.keymap.set("n", "<leader>L", ":se lbr!<CR>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")
vim.keymap.set("n", "<leader>H", ":se hls!<CR>")
vim.keymap.set("n", "<leader>R", ":tabe $MYVIMRC<CR>:norm `.<CR>:norm zz<CR>")
vim.keymap.set("n", "<leader>c", ":colo<space>")
vim.keymap.set("n", "<leader>t", ":tabe %<CR>")
-- vim.keymap.set("n", "<leader>e", ":Ex<CR>")
-- vim.keymap.set("n", "<leader>E", ":Sex<CR>")
vim.keymap.set("n", "<leader>E", ":Ex<CR>")
vim.keymap.set("n", "<leader>v", ":Vex<CR>")
vim.keymap.set("n", "<leader>1", ":colo wildcharm<CR>")
vim.keymap.set("n", "<leader>2", ":colo gruvbox<CR>")
vim.keymap.set("n", "<leader>3", ":colo onedark<CR>")
vim.keymap.set("n", "<leader>4", ":colo lunaperche<CR>")
vim.keymap.set("n", "<leader>5", ":colo tokyonight<CR>")
vim.keymap.set("n", "<leader>6", ":colo dracula<CR>")
vim.keymap.set("n", "<leader>7", ":colo delek<CR>")

-- TODO: keymap for linter next
-- TODO: keymap for linter previous
-- TODO: keymap for fuzzy finder
-- TODO: keymap for leader-p for ctags or tags etc.
-- TODO see if I need to get these things moved below the plugin config in case
-- they are broken by plugins

-- quickfix with arrow keys
vim.keymap.set("n", "<Up>", ":cp<CR>")
vim.keymap.set("n", "<Down>", ":cn<CR>")
vim.keymap.set("n", "<Left>", ":cpf<CR>")
vim.keymap.set("n", "<Right>", ":cnf<CR>")
vim.keymap.set("n", "g<Left>", ":colder<CR>")
vim.keymap.set("n", "g<Right>", ":cnewer<CR>")
vim.keymap.set("n", "g<Up>", ":cope<CR>")
vim.keymap.set("n", "g<Down>", ":ccl<CR>")
vim.keymap.set("n", "<PageUp>", ":lp<CR>")
vim.keymap.set("n", "<PageDown>", ":lne<CR>")
vim.keymap.set("n", "g<PageUp>", ":lop<CR>")
vim.keymap.set("n", "g<PageDown>", ":lcl<CR>")

-- My date command
vim.keymap.set("n", "<leader>d", [[o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>I# <esc>o<esc>0]])

-- Fixing LazyVim's keybinds
