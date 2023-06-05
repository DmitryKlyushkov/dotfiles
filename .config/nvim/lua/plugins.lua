local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use {
    "hrsh7th/nvim-cmp",     -- Completion
    requires = {
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim", -- Enables icons(vscode-like pictograms) on completions
      {
        "L3MON4D3/LuaSnip",   -- Snippets
        requires = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
      },
    },
  }
  use 'nvim-lualine/lualine.nvim'       -- Statusline
  use 'nvim-lua/plenary.nvim'           -- Common utilities
  use 'nvim-lua/popup.nvim'             -- Implementation of Popup API
  use 'hrsh7th/cmp-nvim-lsp'            -- nvim-cmp source for neovim's built-in LSP
  use 'neovim/nvim-lspconfig'           -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'kyazdani42/nvim-web-devicons'               -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim' -- Telescop-File-Browser
  use 'nvim-telescope/telescope-media-files.nvim'  -- Telescope-Media-Files
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
  use 'norcalli/nvim-colorizer.lua'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'
  use 'fedepujol/move.nvim' -- Moving Lines Up and Down
  -- use 'github/copilot.vim'
end)
