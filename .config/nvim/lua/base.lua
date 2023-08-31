vim.cmd("autocmd!")

-- File encodings
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true -- Line numbering in the current window

-- Options
vim.opt.title = true                                -- Window title
vim.opt.autoindent = true                           -- Automatic indentation
vim.opt.smartindent = true                          -- Auto-indentation
vim.opt.hlsearch = true                             -- Highlighting of search results
vim.opt.backup = false                              -- Creation of backup files when writing a file
vim.opt.showcmd = true                              -- Display of the command in the last line of the screen
vim.opt.cmdheight = 1                               -- Height of the command line
vim.opt.laststatus = 2                              -- Status line (0 - not visible, 1 - visible when two windows, 2 - always visible)
vim.opt.shiftwidth = 2                              -- Each level of indentation will consist of two spaces
vim.opt.tabstop = 2                                 -- Tab = 2 spaces
vim.opt.expandtab = true                            -- Spaces insted of tab characters
vim.opt.smarttab = true                             -- Tab inserts vim.opt.shiftwidth amount of spaces
vim.opt.scrolloff = 10                              -- Minimum number of lines to keep visible above and below the cursor when scrolling
vim.opt.shell = '/usr/bin/fish'                     -- Default shell
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' } -- Files that should be skipped when creating backup files
vim.opt.inccommand = 'split'                        -- Incremental highlighting during substitution commands
vim.opt.ignorecase = true                           -- Case insensitive searching UNLESS /C or capital in search
vim.opt.breakindent = true                          -- Auto-adjust the indentation of wrapped lines for better visual distinction
vim.opt.wrap = true                                 -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }    -- Allows Backspace key to delete characters at the start & end of the line & within the indentation)
vim.opt.path:append { '**' }                        -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }    -- Folders/Files ignored by file navigation commands like :edit and :find

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
vim.opt.formatoptions:append { 'r' }

-- Helpers --
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

-- KeyMappings --
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
-- Kill eslint_d & prettierd processes on neovim leave
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "!killall -9 eslint_d",
})
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "!killall -9 prettierd",
})
