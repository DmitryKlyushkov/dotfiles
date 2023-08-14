local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'                 -- Neovim Plugin Manager
  use "williamboman/mason.nvim"                -- Package Manager
  use "williamboman/mason-lspconfig.nvim"      -- Lspconfigs For Mason
  use {
    'svrana/neosolarized.nvim',                -- Solarized Theme
    requires = { 'tjdevries/colorbuddy.nvim' } -- Colorscheme Helper
  }
  use {
    "hrsh7th/nvim-cmp",                   -- Completion Engine
    requires = {
      "hrsh7th/cmp-buffer",               -- nvim-cmp Source For Buffer Words
      "hrsh7th/cmp-nvim-lsp",             -- nvim-cmp Source For Neovim's Built-in Language Server Client
      "hrsh7th/cmp-nvim-lua",             -- nvim-cmp Source For Neovim Lua API
      "hrsh7th/cmp-path",                 -- nvim-cmp Source For Filesystem Paths
      "onsails/lspkind-nvim",             -- Enables Icons(Vscode-like Pictograms) On Completions
      {
        "L3MON4D3/LuaSnip",               -- Snippets
        requires = {
          "saadparwaiz1/cmp_luasnip",     -- nvim-cmp Source For Luasnip
          "rafamadriz/friendly-snippets", -- Set Of Preconfigured Snippets
        },
      },
    },
  }
  use "nvim-lualine/lualine.nvim"       -- Statusline
  use "nvim-lua/plenary.nvim"           -- Common Utilities
  use "nvim-lua/popup.nvim"             -- Implementation Of Popup API
  use "neovim/nvim-lspconfig"           -- Quickstart Configs For Nvim LSP
  use "jose-elias-alvarez/null-ls.nvim" -- LSP Diagnostics, Code Actions, Hover, Formatting, Linting
  use {
    "glepnir/lspsaga.nvim",             -- UI For LSP Diagnoctics, Code Actions, Hover, etc
    requires = {
      "nvim-tree/nvim-web-devicons"     -- lspsaga Icons
    }
  }
  use {
    "nvim-treesitter/nvim-treesitter", -- Interface For A Tree-Sitter
    run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  }
  use "nvim-telescope/telescope.nvim"               -- Fuzzy Finder Over Lists
  use "nvim-telescope/telescope-file-browser.nvim"  -- File Browser Extension For Telescope
  use "nvim-telescope/telescope-media-files.nvim"   -- Images And Font Previews For Telescope
  use "windwp/nvim-ts-autotag"                      -- Treesitter To Auto Close And Auto Rename HTML Tags
  use "windwp/nvim-autopairs"                       -- Autopair Characters
  use {
    "numToStr/Comment.nvim",                        -- Comment Plugin
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring" -- Treesitter Plugin For Setting The Commentstring Based On The Cursor Location In A File
    }
  }
  use "norcalli/nvim-colorizer.lua" -- Color Highlighter
  use({
    "iamcco/markdown-preview.nvim", -- Markdown Preview Plugin
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use "akinsho/nvim-bufferline.lua" -- Bufferline
  use "fedepujol/move.nvim"         -- Moving Lines Up and Down
  use "mg979/vim-visual-multi"      -- Multi cursor
  -- use "github/copilot.vim"       -- GitHub Copilot
end)
