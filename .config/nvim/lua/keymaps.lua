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

local M = require("utils")
-- Leader key
vim.g.mapleader = ' '
-- Save current buffer
M.map('n', '<leader>s', ':w<CR>')
-- Close all buffers
M.map('n', '<leader>qa', ':w | %bd | e#<CR>')
-- Save current session and close neovim
M.map('n', '<leader>qq', make_session)
-- Open last saved session of this project
M.map('n', '<leader>ls', open_session)
-- Delete a line/selected block into _register
M.map('n', '<A-w>', '"_dd')
M.map('i', '<A-w>', '<Esc>"_dd')
M.map('x', '<A-w>', '"_d')
-- Delete next char
M.map('i', '<C-l>', '<Del>')
-- Jump over next/prev char
M.map('i', '<C-k>', '<ESC>la')
M.map('i', '<C-j>', '<ESC>ha')
-- Put a word in quotes/parentheses/brackets
M.map('n', "q'", "ciw''<Esc>P")
M.map('n', 'q"', 'ciw""<Esc>P')
M.map('n', 'q`', 'ciw``<Esc>P')
M.map('n', 'q{', 'ciw{}<Esc>P')
M.map('n', 'q(', 'ciw()<Esc>P')
M.map('n', 'q[', 'ciw[]<Esc>P')
-- Put Selected text in quotes/parentheses/brackets
M.map('x', "q'", "xi''<Esc>P")
M.map('x', 'q"', 'xi""<Esc>P')
M.map('x', 'q`', 'xi``<Esc>P')
M.map('x', 'q{', 'xi{}<Esc>P')
M.map('x', 'q(', 'xi()<Esc>P')
M.map('x', 'q[', 'xi[]<Esc>P')
-- Delete quotes/parentheses/brackets around word/text
M.map('n', "dq'", "di'hPl2x")
M.map('n', 'dq"', 'di"hPl2x')
M.map('n', 'dq`', 'di`hPl2x')
M.map('n', 'dq{', 'di{hPl2x')
M.map('n', 'dq(', 'di(hPl2x')
M.map('n', 'dq[', 'di[hPl2x')
-- Beginning of line / end of line
M.map('n', '<Leader>1', '0')
M.map('n', '<Leader>2', '$')
-- Copy + Paste a line/selected lines
M.map('n', '<Leader>j', 'yyPj')
M.map('v', '<Leader>j', 'ygP')
-- Copy/paste into/from +register (system clipboard)
M.map('v', '<C-c>', '"+y')
M.map('x', '<C-c>', '"+y')
M.map('n', '<C-v>', '"+p')
M.map('i', '<C-v>', '"+p')
-- Paste from unnamed "register
M.map('i', '<C-p>', '<C-r>"')
-- Delete and Copy into +register
M.map('v', '<C-x>', '"+d')
-- Select all
M.map('n', '<leader>a', 'gg<S-v>G')
-- Create a new tab
M.map('n', '<Leader><Tab>', '<cmd>:tabnew<cr>')
M.map('n', '<Leader>t', '<cmd>:tabclose<cr>')
-- Horisontal/Vertical Split
M.map('n', 'ss', ':split<Return><C-w>w')
M.map('n', 'sv', ':vsplit<Return><C-w>w')
-- Move around splits
M.map('n', '<C-h>', '<C-w>h')
M.map('n', '<C-j>', '<C-w>j')
M.map('n', '<C-k>', '<C-w>k')
M.map('n', '<C-l>', '<C-w>l')
-- Cancel Highlighting
M.map('n', '<leader><esc>', ':noh<return><esc>')
-- (vim-visual-multi) Add cursor
M.map('n', '<C-1>', '<Plug>(VM-Add-Cursor-At-Pos)')
-- Join below line and delete a space char
M.map("n", "J", "Jx")
