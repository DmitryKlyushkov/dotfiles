local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    }
  },
  code_action = {
    keys = {
      quit = { 'q', '<ESC>' }
    }
  },
  definition = {
    quit = { 'q', '<ESC>' },
    edit = "<CR>",
    vsplit = "sv",
    split = "ss",
    tabe = "t",
  },
  rename = {
    quit = '<ESC>'
  },
  finder = {
    keys = {
      expand_or_jump = 'l',
      vsplit = 'sv',
      split = 'ss',
    }
  },
  outline = {
    keys = {
      expand_or_jump = 'l',
    }
  },
})

-- Helpers
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local diagnostic = require("lspsaga.diagnostic")
-- Diagnostic jump
map('n', '<Leader>3', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '<Leader>4', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
-- Peek type definition / Go to type definition
map('n', 'pt', '<Cmd>Lspsaga peek_type_definition<CR>')
map('n', 'gt', '<Cmd>Lspsaga gt_type_definition<CR>')
-- Peek definition / Go to definition
map('n', 'pd', '<Cmd>Lspsaga peek_definition<CR>')
map('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>')
-- Show line diagnostics
map('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>')
-- Code action
map({ 'n', 'v' }, '<A-q>', '<Cmd>Lspsaga code_action<CR>')
-- Hover Doc
map('n', 'zz', '<Cmd>Lspsaga hover_doc<CR>', { remap = true, silent = true })
-- Rename all
map('n', '<C-d>', '<Cmd>Lspsaga rename<CR>')
-- Find all
map('n', '<C-f>', '<Cmd>Lspsaga lsp_finder<CR>', { remap = true, silent = true })
-- Toggle outline
map("n", "<leader>q", "<cmd>Lspsaga outline<CR>")
