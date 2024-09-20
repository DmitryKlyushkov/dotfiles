require('move').setup({
  line = {
    enable = true, -- Enables line movement
    indent = true  -- Toggles indentation
  },
  block = {
    enable = true, -- Enables block movement
    indent = true  -- Toggles indentation
  },
})

local M = require("utils")

-- Normal-mode commands
M.map('n', '<A-j>', ':MoveLine(1)<CR>')
M.map('n', '<A-k>', ':MoveLine(-1)<CR>')

-- Visual-mode commands
M.map('v', '<A-j>', ':MoveBlock(1)<CR>')
M.map('v', '<A-k>', ':MoveBlock(-1)<CR>')
