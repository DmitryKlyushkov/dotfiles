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
    sorting_strategy = "ascending", -- ascending, descending
    mappings = {
      n = {
        -- Close Telescope Window
        ["<esc>"] = actions.close,
        ["q"] = actions.close,
        -- Open File
        ["l"] = actions.select_default,
        -- Open File In a New Tab
        ["t"] = actions.file_tab,
        -- Open File In a Vertical/Horizontal Split
        ["sv"] = actions.file_vsplit,
        ["ss"] = actions.file_split,
        -- Delete Buffer (;r)
        ["<c-d>"] = actions.delete_buffer,
        -- Delete Mark (;m)
        ["dd"] = actions.delete_mark,
        -- Preview Scrolling
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-l>"] = actions.preview_scrolling_right,
        ["<C-h>"] = actions.preview_scrolling_left,
      },
    },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.4,
      },
    }
  },
  extensions = {
    file_browser = {
      hidden = true,
      sorting_strategy = "ascending", -- ascending, descending
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      initial_mode = "normal",
      mappings = {
        ["n"] = {
          ["h"] = fb_actions.goto_parent_dir, -- Go To Parent Directory
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
-- Key Mappings
local M = require("utils")
-- File Browser
M.map("n", "sf", function()
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
-- Marks
M.map('n', ';m', function()
  builtin.marks({
    initial_mode = "normal",
  })
end)
-- Find Files
M.map('n', ';f', function()
  builtin.find_files({
    hidden = true,
  })
end)
-- Live Grep
M.map('n', ';r', function()
  builtin.live_grep()
end)
-- Help Tags
M.map('n', ';t', function()
  builtin.help_tags()
end)
-- Errors
M.map('n', ';e', function()
  builtin.diagnostics({
    initial_mode = "normal"
  })
end)
-- Buffers
M.map('n', ';;', function()
  builtin.buffers({
    initial_mode = "normal"
  })
end)

