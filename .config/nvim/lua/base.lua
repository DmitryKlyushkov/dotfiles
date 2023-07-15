vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

-- Options
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'powershell.exe'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true          -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Helpers
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function delete_line()
  vim.api.nvim_set_current_line('')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
end

--- KeyMapping ---
-- Leader key
vim.g.mapleader = ' '
-- Create a new line below
map('n', '<C-CR>', 'o')
map('i', '<C-CR>', '<esc>o')
-- Save
map('n', '<leader>s', ':w<CR>')
-- Close buffer/all buffers
map('n', '<leader>qq', ':bd<CR>')
map('n', '<leader>qa', ':w | %bd | e#<CR>')
-- Delete forward char
map('i', '<C-l>', '<Del>')
-- Delete a line
map('n', '<A-w>', ':d<CR>')
map('i', '<A-w>', delete_line)
-- Quote/unquote ''/"" a word
map('n', "q'", "ciw''<Esc>P")
map('n', 'q"', 'ciw""<Esc>P')
map('n', "d'", "di'hPl2x")
map('n', 'd"', 'di"hPl2x')
-- Put Selected text in quotes ''/""
map('x', "q'", "xi''<Esc>P")
map('x', 'q"', 'xi""<Esc>P')
-- Put Selected text in {} / []
map('x', 'q{', 'xi{}<Esc>P')
map('x', 'q[', 'xi[]<Esc>P')
-- End of file
map('n', 'ge', '100%')
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
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
vim.opt.formatoptions:append { 'r' }

