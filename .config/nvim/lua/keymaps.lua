-- Key-mapping function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end
-- Delete a whole line of text function
local function delete_line()
  vim.api.nvim_set_current_line('')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
end

-- Leader key
vim.g.mapleader = ' '
-- Create a new line below
map('n', '<C-CR>', 'o')
map('i', '<C-CR>', '<esc>o')
-- Save current file
map('n', '<leader>s', ':w<CR>')
-- Close buffer/all buffers
map('n', '<leader>qq', ':bd<CR>')
map('n', '<leader>qa', ':w | %bd | e#<CR>')
-- Delete forward char
map('i', '<C-l>', '<Del>')
-- Delete a line
map('n', '<A-w>', ':d<CR>')
map('i', '<A-w>', delete_line)
-- Put a word in quotes/parentheses/brackets
map('n', "q'", "ciw''<Esc>P")
map('n', 'q"', 'ciw""<Esc>P')
map('n', 'q`', 'ciw``<Esc>P')
map('n', 'q{', 'ciw{}<Esc>P')
map('n', 'q(', 'ciw()<Esc>P')
map('n', 'q[', 'ciw[]<Esc>P')
-- Put Selected text in quotes/parentheses/brackets
map('x', "q'", "xi''<Esc>P")
map('x', 'q"', 'xi""<Esc>P')
map('x', 'q`', 'xi``<Esc>P')
map('x', 'q{', 'xi{}<Esc>P')
map('x', 'q[', 'xi[]<Esc>P')
map('x', 'q(', 'xi()<Esc>P')
-- Delete quotes/parentheses/brackets around word/text
map('n', "dq'", "di'hPl2x")
map('n', 'dq"', 'di"hPl2x')
map('n', 'dq`', 'di`hPl2x')
map('n', 'dq{', 'di{hPl2x')
map('n', 'dq(', 'di(hPl2x')
map('n', 'dq[', 'di[hPl2x')
-- Beginning of line / end of line
map('n', '<Leader>1', '0')
map('n', '<Leader>2', '$')
-- Copy + Paste a line/selected lines
map('n', '<Leader>j', 'yyPj')
map('v', '<Leader>j', 'ygP')
-- Copy into + buffer (X11)
map('v', '<C-c>', '"+y')
-- Delete and Copy into + buffer (X11)
map('v', '<C-x>', '"+d')
-- Select all
map('n', '<leader>a', 'gg<S-v>G')
-- Create a new tab
map('n', '<Leader><Tab>', '<cmd>:tabnew<cr>')
-- Horisontal/Vertical Split
map('n', 'ss', ':split<Return><C-w>w')
map('n', 'sv', ':vsplit<Return><C-w>w')
-- Move around splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
-- Cancel Highlighting
map('n', '<leader><esc>', ':noh<return><esc>')
-- (vim-visual-multi) Add cursor
map('n', '<C-1>', '<Plug>(VM-Add-Cursor-At-Pos)')
-- Join below line and delete a space char
map("n", "J", "Jx")
