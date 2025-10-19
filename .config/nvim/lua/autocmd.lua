-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Kill eslint_d and prettierd processes when leaving Neovim
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	callback = function()
		vim.fn.jobstart("killall eslint_d prettierd", { detach = true })
	end,
})

-- Do not continue comments in Normal/Insert mode
vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	callback = function()
		vim.opt_local.formatoptions:remove("r") -- Do not continue comments when pressing <Enter> in Insert mode. `:h fo-r`
		vim.opt_local.formatoptions:remove("o") -- Do not continue comments when pressing 'o' or 'O' in Normal mode. `:h fo-o`
	end,
})

-- Always use vertical split for :help
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.txt", -- Match help buffers (help files use .txt extension)
	callback = function()
		-- Check if the buffer is a help buffer
		if vim.bo.filetype == "help" then
			-- Move the current window to a vertical split on the right
			vim.cmd("wincmd L")
			-- Optionally set a fixed width for the help window
			vim.cmd("vertical resize 80")
		end
	end,
})
