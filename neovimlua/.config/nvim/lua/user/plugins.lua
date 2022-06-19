local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use {"akinsho/toggleterm.nvim", branch = 'main'}
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  -- use { "axkirillov/telescope-changed-files" }
  -- DAP
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  use("HiPhish/debugpy.nvim")

  use("nvim-telescope/telescope-dap.nvim")

  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  use {
    "ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}
  }
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use  "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim" -- for outline
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use 'simrat39/rust-tools.nvim'
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
        { 'nvim-telescope/telescope-live-grep-raw.nvim' }
    }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "ojroques/vim-oscyank"
  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "https://github.com/rhysd/conflict-marker.vim"

  use {
    "tpope/vim-surround",
    keys = {"c", "d", "y", "S"}
  }
  -- use {
  --   "ur4ltz/surround.nvim",
  --   config = function()
  --     require"surround".setup {mappings_style = "surround"}
  --   end
  -- }
  use {
    "tpope/vim-unimpaired",
    keys = {"yo"}
  }
  use "MattesGroeger/vim-bookmarks"
  use {
    "tom-anders/telescope-vim-bookmarks.nvim"
  }
	-- Wilder Cmdline
  use("gelguy/wilder.nvim")

  -- Multi Virtual Cursor
  use("mg979/vim-visual-multi")
  -- hop
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' , multi_windows = true}
    end
  }
  use { "p00f/nvim-ts-rainbow" }
  use "windwp/nvim-ts-autotag"

  use "Pocco81/TrueZen.nvim"
  use {"sakhnik/nvim-gdb", run = './install.sh'}
  use "wesQ3/vim-windowswap"
  -- use "folke/zen-mode.nvim"
  use "hkupty/iron.nvim"
  use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim','sindrets/diffview.nvim'} }
  use {'will133/vim-dirdiff'}
  use 'tami5/sqlite.lua'
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'tami5/sqlite.lua', module = 'sqlite'},
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require('neoclip').setup({
        enable_persistent_history = true,
      })
    end,
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
