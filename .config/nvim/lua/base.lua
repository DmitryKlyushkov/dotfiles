vim.cmd("autocmd!")

-- File encodings
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true         -- Line numbering in the current window
vim.wo.relativenumber = true -- Relative line numbers

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
vim.opt.clipboard = "unnamedplus"                   -- Yank to copy to the system clipboard outside of Neovim

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
vim.opt.formatoptions:append { 'r' }

-- Add error undercurls
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Treesitter code folding
vim.opt.foldenable = false -- Disable folding at startup
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
