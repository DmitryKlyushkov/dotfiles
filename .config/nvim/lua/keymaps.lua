-- Key-mapping function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Save current session and leave neovim
local function make_session()
  -- Session file path
  local session_file_path = "~/.config/nvim/sessions/"
  -- Name of the project
  local current_dir = vim.fn.getcwd()
  local folder_name = current_dir:match("([^\\/]*)$")
  -- Save the current session as a project name
  vim.cmd('mksession! ' .. session_file_path .. folder_name .. ".vim")
  -- Save buffers and close neovim
  vim.cmd(':wqa<CR>')
end

-- Open last saved session of this project
local function open_session()
  -- Session file path
  local session_file_path = "~/.config/nvim/sessions/"
  -- Name of the project
  local current_dir = vim.fn.getcwd()
  local folder_name = current_dir:match("([^\\/]*)$")
  -- Attempt to source the session file
  local success, message = pcall(function()
    vim.cmd(':source ' .. session_file_path .. folder_name .. ".vim")
  end)
  -- Check if sourcing was successful
  if not success then
    -- If there was an error, close telescope floating window and open session
    vim.cmd(':q!')
    vim.cmd(':source ' .. session_file_path .. folder_name .. ".vim")
  end
end

-- Leader key
vim.g.mapleader = ' '
-- Save current buffer
map('n', '<leader>s', ':w<CR>')
-- Close all buffers
map('n', '<leader>qa', ':w | %bd | e#<CR>')
-- Save current session and close neovim
map('n', '<leader>qq', make_session)
-- Open last saved session of this project
map('n', '<leader>ls', open_session)
-- Delete a line/selected block into _register
map('n', '<A-w>', '"_dd')
map('i', '<A-w>', '<Esc>"_dd')
map('x', '<A-w>', '"_d')
-- Delete next char
map('i', '<C-l>', '<Del>')
-- Jump over next/prev char
map('i', '<C-k>', '<ESC>la')
map('i', '<C-j>', '<ESC>ha')
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
map('x', 'q(', 'xi()<Esc>P')
map('x', 'q[', 'xi[]<Esc>P')
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
-- Copy/paste into/from +register (system clipboard)
map('v', '<C-c>', '"+y')
map('x', '<C-c>', '"+y')
map('n', '<C-v>', '"+p')
map('i', '<C-v>', '"+p')
-- Paste from unnamed "register
map('i', '<C-p>', '<C-r>"')
-- Delete and Copy into +register
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

