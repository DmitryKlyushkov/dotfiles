vim.opt.cursorline = true    -- Highlights the current line
vim.opt.termguicolors = true -- Allows true color syntax highlighting and other color-related features
vim.opt.winblend = 0         -- Transparency for floating and popup windows
vim.opt.winblend = 0         -- Transparency for floating and popup windows
vim.opt.wildoptions = 'pum'  -- Enables partial and menu-based completion
vim.opt.pumblend = 5         -- Transparency level of the pum menu
vim.opt.background = 'dark'  -- Dark color scheme

-- Highlights yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]

