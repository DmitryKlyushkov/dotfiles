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
  lightbulb = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = { 'q', '<ESC>' }
    }
  },
  definition = {
    keys = {
      quit = { 'q', '<ESC>' },
      vsplit = "sv",
      split = "ss",
      tabnew = 't',
    }
  },
  rename = {
    keys = {
      quit = { '<ESC>' }
    }
  },
  finder = {
    keys = {
      quit = { 'q', '<ESC>' },
      toggle_or_open = 'l',
      vsplit = 'sv',
      split = 'ss',
      tabnew = 't'
    }
  },
  outline = {
    close_after_jump = true,
    keys = {
      quit = { 'q', '<ESC>' },
      toggle_or_jump = 'h',
      jump = 'l'
    }
  }
})

-- Helpers
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Diagnostic jump
map('n', '<Leader>3', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '<Leader>4', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
-- Show line diagnostics
map('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>')
-- Peek type definition / Go to type definition
map('n', 'pt', '<Cmd>Lspsaga peek_type_definition<CR>')
map('n', 'gt', '<Cmd>Lspsaga goto_type_definition<CR>')
-- Peek definition / Go to definition
map('n', 'pd', '<Cmd>Lspsaga peek_definition<CR>')
map('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>')
-- Code action
map({ 'n', 'v' }, '<A-q>', '<Cmd>Lspsaga code_action<CR>')
-- Hover Doc
map('n', 'zz', '<Cmd>Lspsaga hover_doc<CR>')
-- Rename all
map('n', '<C-e>', '<Cmd>Lspsaga rename<CR>')
-- Find all
map('n', '<C-f>', '<Cmd>Lspsaga finder<CR>')
-- Toggle outline
map("n", "<leader>`", "<cmd>Lspsaga outline<CR>")
