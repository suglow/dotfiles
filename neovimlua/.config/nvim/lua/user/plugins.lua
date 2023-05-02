local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Have packer use a popup window

-- Install your plugins here
return lazy.setup({
  -- My plugins here
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- Easily comment stuff
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
  { 'akinsho/bufferline.nvim', version = "*",  dependencies = { 'kyazdani42/nvim-web-devicons' } },
  "moll/vim-bbye",
  --[[ use {"nvim-lualine/lualine.nvim", ]]
  --[[   config = function() ]]
  --[[     require 'lualine'.setup {} ]]
  --[[   end ]]
  --[[ } ]]
  {
    "rebelot/heirline.nvim",
    config = function()
      require("user.heirline")
    end,
    dependencies = { 'kyazdani42/nvim-web-devicons', 'mfussenegger/nvim-dap', 'SmiteshP/nvim-navic',
      'sainnhe/gruvbox-material' },
  },

  { "akinsho/toggleterm.nvim", branch = 'main' },
  "ahmedkhalf/project.nvim",
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
  "folke/which-key.nvim",
  "mattn/emmet-vim",
  -- { "axkirillov/telescope-changed-files" },
  -- DAP
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",
  "HiPhish/debugpy.nvim",

  "nvim-telescope/telescope-dap.nvim",

  { 'kevinhwang91/nvim-bqf',                  ft = 'qf' },
  -- Colorschemes
  --[[ "lunarvim/colorschemes", -- A bunch of colorschemes you can try out ]]
  -- use "lunarvim/darkplus.nvim"
  --[[ use { ]]
  --[[   "ellisonleao/gruvbox.nvim", dependencies = { "rktjmp/lush.nvim" } ]]
  --[[ } ]]

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.cursorline = true
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.cmd("colorscheme gruvbox-material")
    end,
  },

  -- UI
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
  "ghillb/cybu.nvim",
  -- cmp plugins
  "hrsh7th/nvim-cmp",         -- The completion plugin
  "hrsh7th/cmp-buffer",       -- buffer completions
  "hrsh7th/cmp-path",         -- path completions
  "hrsh7th/cmp-cmdline",      -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  {
    "j-hui/fidget.nvim",
    config = function()
      require 'fidget'.setup {}
    end
  },
  -- snippets
  "L3MON4D3/LuaSnip",             --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "nvim-lua/lsp_extensions.nvim",
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "b0o/SchemaStore.nvim",
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  }, -- for outline
  "ray-x/lsp_signature.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },
  -- rust
  -- use { "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" }
  "Saecki/crates.nvim",
  --[[ use {'simrat39/rust-tools.nvim', branch = "modularize_and_inlay_rewrite"} ]]
  { 'simrat39/rust-tools.nvim',                branch = "master" },
  --[[ use {'suglow/rust-tools.nvim', branch = "modularize_and_inlay_rewrite" } ]]
  -- Lua
  "folke/neodev.nvim",
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" }
    }
  },
  --[[ use { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } ]]
  { 'nvim-telescope/telescope-fzy-native.nvim' },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "ojroques/vim-oscyank",
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "gitsigns".setup {
        signs = {
          add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      }
    end
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "LineNr"
    end
  },
  "ruifm/gitlinker.nvim",
  "https://github.com/rhysd/conflict-marker.vim",
  --[[ use "RRethy/vim-illuminate" ]]
  {
    "ur4ltz/surround.nvim",
    config = function()
      require "surround".setup { mappings_style = "surround" }
    end
  },
  {
    "tpope/vim-unimpaired",
    keys = { "yo" }
  },
  "MattesGroeger/vim-bookmarks",
  {
    "tom-anders/telescope-vim-bookmarks.nvim"
  },
  -- Wilder Cmdline
  "gelguy/wilder.nvim",

  -- Multi Virtual Cursor
  "mg979/vim-visual-multi",
  -- hop
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran', multi_windows = true }
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end
  },
  { "p00f/nvim-ts-rainbow" },
  "windwp/nvim-ts-autotag",

  "Pocco81/true-zen.nvim",
  { "sakhnik/nvim-gdb",    build = './install.sh' },
  "wesQ3/vim-windowswap",
  -- use "folke/zen-mode.nvim"
  -- use "hkupty/iron.nvim"
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'TimUntersberger/neogit', dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' } },
  'ZSaberLv0/ZFVimJob',
  'ZSaberLv0/ZFVimDirDiff',
  {
    'anuvyklack/hydra.nvim',
    dependencies = 'anuvyklack/keymap-layer.nvim' -- needed only for pink hydras
  },
  'ray-x/go.nvim',
  'ray-x/guihua.lua',
  "gbprod/yanky.nvim",
  'ibhagwan/smartyank.nvim',
  "wsdjeg/vim-fetch",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup()
    end
  },
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
}, {
  install = { colorscheme = { "gruvbox-material" } },
})
