-- Set <space> as the leader key
-- See `:help mapleader`
-- Need to set this first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- JE: trying my own config
vim.opt.swapfile = false
vim.opt.bk = false
vim.opt.hls = false
vim.opt.joinspaces = false
vim.opt.formatoptions:append('j')
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
-- vim.opt.laststatus = 1

vim.opt.pvh = 18
vim.opt.ts = 4
vim.opt.sts = 2
vim.opt.sw = 2
-- Note: vim-sleuth plugin alters shiftwidth etc.
vim.opt.cul = false

-- Enable break indent
vim.opt.breakindent = true

-- Disable annoying nvim replace preview when i'm trying to read my code
vim.opt.inccommand = ""

vim.opt.clipboard:append { "unnamedplus" }

-- Completion suggestings form blog thing
-- vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
-- JE: i want select in there since I want to use c-x c-l
vim.opt.completeopt = {'menuone'}
-- vim.opt.shortmess = vim.opt.shortmess + { c = true}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  source = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 250
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--   group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
--   callback = function ()
--     vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
--   end
-- })


-- vim.api.nvim_create_autocmd('DiagnosticChanged', {
--   callback = function(_)
--     -- local diagnostics = _.data.diagnostics
--     -- vim.print(diagnostics)
--     -- TODO je see if i can scope this down, probably getting called when it doesn't need to be lol
--     vim.diagnostic.setqflist({ open = false, })
--   end,
-- })

-- My keybinds
vim.keymap.set('n', '<leader>s', ':up<CR>');
vim.keymap.set('n', '<leader>n', ':se nu!<CR>');
vim.keymap.set('n', '<leader>N', ':se rnu!<CR>');
vim.keymap.set('n', '<leader>l', ':se wrap!<CR>');
vim.keymap.set('n', '<leader>L', ':se lbr!<CR>');
vim.keymap.set('n', '<leader>h', ':noh<CR>');
vim.keymap.set('n', '<leader>H', ':se hls!<CR>');
vim.keymap.set('n', '<leader>R', ':tabe $MYVIMRC<CR>');
vim.keymap.set('n', '<leader>c', ':colo<space>');
vim.keymap.set('n', '<leader>t', ':tabe %<CR>');
vim.keymap.set('n', '<leader>e', ':Ex<CR>');
vim.keymap.set('n', '<leader>E', ':Sex<CR>');
vim.keymap.set('n', '<leader>v', ':Vex<CR>');

-- TODO: keymap for linter next
-- TODO: keymap for linter previous
-- TODO: keymap for fuzzy finder
-- TODO: keymap for leader-p for ctags or tags etc.
-- TODO see if I need to get these things moved below the plugin config in case
-- they are broken by plugins

-- ctags with arrow keys
vim.keymap.set('n', '<Up>', ':cp<CR>');
vim.keymap.set('n', '<Down>', ':cn<CR>');
vim.keymap.set('n', '<Left>', ':cpf<CR>');
vim.keymap.set('n', '<Right>', ':cnf<CR>');
vim.keymap.set('n', 'g<Left>', ':colder<CR>');
vim.keymap.set('n', 'g<Right>', ':cnewer<CR>');
vim.keymap.set('n', 'g<Up>', ':cope<CR>');
vim.keymap.set('n', 'g<Down>', ':ccl<CR>');
vim.keymap.set('n', '<PageUp>', ':lp<CR>');
vim.keymap.set('n', '<PageDown>', ':lne<CR>');
vim.keymap.set('n', 'g<PageUp>', ':lop<CR>');
vim.keymap.set('n', 'g<PageDown>', ':lcl<CR>');

-- My date command
vim.keymap.set('n', '<leader>d', [[o<esc>:r!date "+\%a \%Y-\%m-\%d \%H:\%M"<CR>I# <esc>o<esc>0]]);

vim.cmd[[
  aug go
    au!
    au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl
    let g:go_doc_keywordprg_enabled = 1
    au filetype cpp setl ls=2 sw=4 sts=4 ts=4 et
    au filetype go setl ls=2 sw=4 sts=4 ts=4 noet cmdheight=2
    "au filetype go setl nu nowrap
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
]]
vim.cmd [[
aug rust
  au!
  nno <leader>f :RustFmt<CR>
  " :make check for cargo likes a large quickfix window
  nno g<Up> :cope 12<CR>
  " take colorscheme shortcut to do rust check and quickfix list
  nn <leader>c :RustFmt\|:up\|:mak check<CR>

  " auto-inserting // during the rust book is annoying and so
  " disable inserting comments for o and pressing enter in insert mode
  au FileType rust setlocal formatoptions-=o formatoptions-=r
]]
vim.cmd [[
aug yaml
  au!
  " Format on save
  au BufRead,BufNewFile ~/code/scn/ansible/*.yml setfiletype yaml.ansible
  au BufRead,BufNewFile ~/code/scn/ansible/**/*.yml setfiletype yaml.ansible
]]

-- Use ripgrep as grep program
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep $*"
end

function ToggleTheme()
  -- if vim.o.background == "dark" then
  -- else
  -- end
  vim.cmd("colorscheme lunaperche")
end

-- quick hack for background
-- Requires more lua-foo, so just pretend to type for now :)
vim.keymap.set('n', '<space>w', [[:se background=light<CR>:!light<CR>:lua ToggleTheme()<CR><Esc>]]);
vim.keymap.set('n', '<space>q', [[:se background=dark<CR>:!dark<CR>:lua ToggleTheme()<CR><Esc>]]);

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy.nvim
require("lazy").setup({
  -- begin lazy.nvim plugin setup block

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  --
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.

  'lewis6991/gitsigns.nvim',
  'isundil/vim-irssi-syntax',
  'johnelliott/vim-kinesis-kb900',
  'nfnty/vim-nftables',
  'cmcaine/vim-uci',
  'NoahTheDuke/vim-just',
  'sevko/vim-nand2tetris-syntax',
  'vim-scripts/applescript.vim',
  'bfrg/vim-jq', -- TODO: add https://github.com/wader/jq-lsp once I need JQ again
  'rust-lang/rust.vim',
  'fatih/vim-go',
  'leafOfTree/vim-svelte-plugin',
  -- 'onsails/diaglist.nvim',

  'Glench/Vim-Jinja2-Syntax',
  'vim-scripts/applescript.vim',
  'cespare/vim-toml',
  'ekalinin/Dockerfile.vim',
  'pearofducks/ansible-vim',
  'NLKNguyen/c-syntax.vim',
  'andrewstuart/vim-kubernetes',
  'cmcaine/vim-uci',
  'darfink/vim-plist',
  'mustache/vim-mustache-handlebars',
  'hashivim/vim-terraform',
  'fatih/vim-hclfmt',
  'vito-c/jq.vim',
  'nfnty/vim-nftables',
  'ClocqworkNet/vim-junos-syntax',
  -- from vim9 vimrc -- 'cakebaker/scss-syntax.vim', -- , { 'for': ['scss', 'scss.css'] },
  -- from vim9 vimrc -- 'vim-scripts/irssilog.vim',
  -- from vim9 vimrc -- 'isundil/vim-irssi-syntax',
  -- from vim9 vimrc -- 'chr4/nginx.vim',
  -- from vim9 vimrc -- 'johnelliott/vim-kinesis-kb900',
  -- from vim9 vimrc -- 'digitaltoad/vim-pug',
  -- from vim9 vimrc -- 'jparise/vim-graphql',
  'leafgarland/typescript-vim',
  -- from vim9 vimrc -- 'lifepillar/pgsql.vim',
  'moll/vim-node',
  'mxw/vim-jsx', -- , { 'for': ['javascript', 'javascript.jsx'] },
  -- from vim9 vimrc -- 'pangloss/vim-javascript', -- , { 'for': 'javascript' },
  -- from vim9 vimrc -- 'stephenway/postcss.vim',
  -- from vim9 vimrc -- 'davidbeckingsale/writegood.vim',
  -- from vim9 vimrc -- -- 'pantharshit00/vim-prisma',
  -- from vim9 vimrc -- 'sevko/vim-nand2tetris-syntax',

  -- Try LLM shit
  -- Custom Parameters (with defaults)
  {
    "David-Kunz/gen.nvim",
    opts = {
      -- model = "deepseek-coder:33b-instruct", -- The default model to use.
      model = "llama3:70b", -- The default model to use.
      host = "localhost", -- The host running the Ollama service.
      port = "11434", -- The port on which the Ollama service is listening.
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      quit_map = "q", -- set keymap for quit
      no_auto_close = false, -- Never closes the window automatically.
      init = function(_) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      -- Function to initialize Ollama
      command = function(options)
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      debug = false -- Prints errors and the command which is run.
    }
  },
  -- End LLM shit

  -- Treesitter is parsing toolset
  -- also used in Telescope.nvim
  -- TODO: See what there is I can do with treesitter, possibilities abound
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- JE: not going to use this at first, just seems weird....
      -- -- Useful status updates for LSP
      -- -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', opts = {} },

      -- neodev helps set up editing init.lua, see docs for it
      'folke/neodev.nvim',
    },
  },

  -- holy moly snippets and completion please don't break vim
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'amarakon/nvim-cmp-buffer-lines',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  -- TODO: none-ls for javascript
  {
    "nvimtools/none-ls.nvim",
    -- This is how you can use non-lsp things,
    -- none-lsp is a generic tool lsp wrapper
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        -- Use this on_attach to un-break 'gqq'
        -- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1432408485
        on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
        end,
        sources = {
          null_ls.builtins.completion.spell,
          -- null_ls.builtins.diagnostics.markdownlint,
          -- null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.formatting.jq, -- TODO see above for JQ support
          -- have LSP for null_ls.builtins.diagnostics.eslint_d,
          -- python linter
          -- null_ls.builtins.formatting.black.with({
          --   extra_args = { "--line-length=120" }
          -- }),
          -- python import sorting
          null_ls.builtins.formatting.isort,
        },
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  },

  -- fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    build = ':TSUpdate',
  },

  -- TODO: individual language plugins not supported by mason etc.
  -- TODO: linter testing with javascript
  -- TODO: tackle auto-completion after language support and colors are working well
  -- TODO: un-break ctrl-Y confirms an autocompletion as in Vim9
  -- TODO: un-break s/ doing highlights

  -- Dark mode support, would like this to work faster
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        -- ToggleTheme()
      end,
      set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
        -- ToggleTheme()
      end,
    },
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 900,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 900,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,    -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 900,
    opts = {
      -- Adjusts the brightness of the colors of the **Day** style.
      -- Number between 0 and 1, from dull to vibrant colors
      day_brightness = 0.25,
      on_colors = function(colors)
        colors.fg_gutter = "#737aa2"
        -- colors.comment = "#737aa2"
        colors.comment = "#828bb8"
      end
    },
  },
  {
    'olimorris/onedarkpro.nvim',
    lazy = true,
    -- priority = 1000,
    -- opts = {},
  },
  { 'plan9-for-vimspace/acme-colors', lazy = true  },
  { 'cormacrelf/vim-colors-github', lazy = true },
  -- end lazy.nvim plugin setup block
},
  -- lazy.nvim opts
  {
    ui = {
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
  })

-- -- color setup
-- require("onedarkpro").setup({
--   highlights = {
--     StatusLine = { bg = "#e3e3e3" },
--     StatusLineNC = { bg = "#efefef", fg = "#bebebe" },
--   }
-- })
require("catppuccin").setup({
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
})
-- Git Signs setup
-- TODO: need any more gitgutter stuff?
require("gitsigns").setup({
  -- See `:help gitsigns.txt`
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  -- This on_attach thing may be jank
  on_attach = function()
    vim.keymap.set('n', '<leader>g', package.loaded.gitsigns.toggle_signs, { desc = 'Toggle Git signs' });
  end
})

-- Treesitter
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  highlight = {
    enable = true,
    -- markdown support sucks as of Thu 2024-01-25 21:43
    disable = { "markdown" },
  },
  indent = { enable = true },
})

require("telescope").setup {
  extensions = {
    -- e.g. https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-setup-and-configuration
    fzf = {},
  },
}
require('telescope').load_extension('fzf')
-- TODO: Add more Telescope keymaps
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Search Files CTRL-p' })

-- LSP stuff
-- Mason
require("mason").setup()
-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  tsserver = {},
  rust_analyzer = {},
  terraformls = {},
  arduino_language_server = {},
  jqls = {},
  -- gradle_ls={}; -- ik concurrency class
  ansiblels = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- junk to feed on_attach, see below about null-ls
local function is_null_ls_formatting_enabed(bufnr)
  local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local generators = require("null-ls.generators").get_available(
    file_type,
    require("null-ls.methods").internal.FORMATTING
  )
  return #generators > 0
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- See `:help K` for why this keymap
  nmap('<C-space>', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')


  -- TODO: see the kickstart.nvim for more of this
  -- Fix 'gqq' (not sure i need this actually) 
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
  if capabilities.documentFormattingProvider then
    if
        client.name == "null-ls" and is_null_ls_formatting_enabed(bufnr)
        or client.name ~= "null-ls"
    then
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
      vim.keymap.set("n", "<leader>gq", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
        { desc = "extra gqq keymapping" })
    else
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
    end
  end
end

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}


-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup cmp
local cmp = require('cmp')
-- TODO see what is broken here compared to old setup
cmp.setup({
  -- doc for view: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
  view = {
    -- entries = { name = "native"  },
  },
  window = {
    completion = cmp.config.window,
    documentation = cmp.config.window,
  },
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
      cmp.TriggerEvent.InsertEnter,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- NB: control-space might be intercepted by MacOS:
    -- https://github.com/hrsh7th/nvim-cmp/issues/1404#issuecomment-1472856977
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = {
    -- see here for the list of sources
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'buffer-lines', option = { line_numbers = false, } },
  },
})

-- -- Going to stop using this because it's half baked as of Tue 2024-03-26 12:08
-- require("diaglist").init({
--     -- optional settings
--     -- below are defaults
--     debug = false,
-- 
--     -- increase for noisy servers
--     debounce_ms = 150,
-- })

-- Colorschemes
-- lunaperche is the best default one I've found since it has dark and light
vim.cmd(ToggleTheme())

-- modeline in lua
-- vim: ts=2 sts=2 sw=2 et
