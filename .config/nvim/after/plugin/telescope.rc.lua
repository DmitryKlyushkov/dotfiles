local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["<esc>"] = actions.close,
        ["l"] = actions.select_default,
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top
      },
      i = {
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top
      }
    },
  },
  extensions = {
    file_browser = {
      hidden = true,
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      initial_mode = "normal",
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          -- ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["h"] = fb_actions.goto_parent_dir,
        },
      },
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
      -- find command (defaults to `fd`)
      find_cmd = "rg"
    }
  },
}

telescope.load_extension("file_browser")
telescope.load_extension("media_files")

vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      hidden = true
    })
  end)
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
  builtin.resume()
end)
vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
  })
end)
vim.keymap.set("n", "sm", function()
  telescope.extensions.media_files.media_files()
end)

