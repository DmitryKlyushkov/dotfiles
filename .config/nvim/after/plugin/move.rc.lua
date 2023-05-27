
-- Helpers
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
-- Normal-mode commands
map('n', '<A-j>', ':MoveLine(1)<CR>')
map('n', '<A-k>', ':MoveLine(-1)<CR>')

-- Visual-mode commands
map('v', '<A-j>', ':MoveBlock(1)<CR>')
map('v', '<A-k>', ':MoveBlock(-1)<CR>')