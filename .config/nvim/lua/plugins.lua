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
  use "nvim-lualine/lualine.nvim"      -- Statusline
  use "nvim-lua/plenary.nvim"          -- Common Utilities
  use "nvim-lua/popup.nvim"            -- Implementation Of Popup API
  use "neovim/nvim-lspconfig"          -- Quickstart Configs For Nvim LSP
  use {
    "nvimtools/none-ls.nvim",          -- Bridge To Support LSP Diagnostics, Code Actions, Hover, Formatting, Linting
    requires = {
      "nvimtools/none-ls-extras.nvim", -- Extra plugins(eslint_d) for none-ls
    }
  }
  use {
    "nvimdev/lspsaga.nvim",         -- UI For LSP Diagnoctics, Code Actions, Hover, etc
    requires = {
      "nvim-tree/nvim-web-devicons" -- lspsaga Icons
    }
  }
  use {
    "nvim-treesitter/nvim-treesitter", -- Interface For A Tree-Sitter (Language Parsing Tool)
    run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  }
  use "nvim-telescope/telescope.nvim"               -- Fuzzy Finder Over Lists
  use "nvim-telescope/telescope-file-browser.nvim"  -- File Browser Extension For Telescope
  use "windwp/nvim-ts-autotag"                      -- Treesitter To Auto Close And Auto Rename HTML Tags
  use "windwp/nvim-autopairs"                       -- Autopair Characters
  use {
    "numToStr/Comment.nvim",                        -- Comment Plugin
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring" -- Treesitter Plugin For Setting The Commentstring Based On The Cursor Location In A File
    }
  }
  use "norcalli/nvim-colorizer.lua"   -- Color Highlighter
  use "akinsho/nvim-bufferline.lua"   -- Bufferline
  use "fedepujol/move.nvim"           -- Moving Lines Up and Down
  use "jake-stewart/multicursor.nvim" -- Multiple Cursors
  use 'karb94/neoscroll.nvim'         -- Smooth Scroll
  use "sindrets/diffview.nvim"        -- Diffview For Git
  use {
    'vhyrro/luarocks.nvim',           -- Neovim Support For Luarocks
    priority = 1001,                  -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  }
  use {
    '3rd/image.nvim', -- Images Support In Neovim
    dependencies = { 'luarocks.nvim' },
    config = function(_, opts)
      opts.integrations = opts.integrations or {}
      opts.integrations.markdown = opts.integrations.markdown or {}
      opts.integrations.markdown.only_render_image_at_cursor = true
      opts.hijack_file_patterns = opts.hijack_file_patterns or {}
      opts.hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif', '*.heic' }
      opts.window_overlap_clear_enabled = true -- tried to remove or change it to false, the outcome was the same
      require('image').setup(opts)
    end,
  }
  -- use "github/copilot.vim"       -- GitHub Copilot
end)
