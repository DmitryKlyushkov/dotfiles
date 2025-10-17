local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({
	ui = {
		winblend = 10,
		border = "rounded",
		colors = {
			normal_bg = "#002b36",
		},
	},
	lightbulb = {
		enable = false,
	},
	code_action = {
		keys = {
			quit = { "q", "<ESC>" },
		},
	},
	definition = {
		keys = {
			quit = { "q", "<ESC>" },
			vsplit = "sv",
			split = "ss",
			tabnew = "t",
		},
	},
	rename = {
		keys = {
			quit = { "<ESC>" },
		},
	},
	finder = {
		keys = {
			quit = { "q", "<ESC>" },
			toggle_or_open = "l",
			vsplit = "sv",
			split = "ss",
			tabnew = "t",
		},
	},
	outline = {
		close_after_jump = true,
		keys = {
			quit = { "q", "<ESC>", "<leader>`" },
			toggle_or_jump = "h",
			jump = "l",
		},
	},
})

local M = require("utils")

-- Diagnostic jump next/prev error
M.map("n", "<Leader>3", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
M.map("n", "<Leader>4", "<Cmd>Lspsaga diagnostic_jump_prev<CR>")
-- Show line diagnostics
M.map("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>")
-- Peek type definition
M.map("n", "pt", "<Cmd>Lspsaga peek_type_definition<CR>")
-- Peek definition
M.map("n", "pd", "<Cmd>Lspsaga peek_definition<CR>")
-- Peek References
M.map("n", "pr", "<Cmd>Lspsaga finder<CR>")
-- Peek Implementations
M.map("n", "pi", "<Cmd>Lspsaga finder imp<CR>")
-- Go to Definition
M.map("n", "gd", "<Cmd>Lspsaga goto_definition<CR>")
-- Go to Type Definition
M.map("n", "gt", "<Cmd>Lspsaga goto_type_definition<CR>")
-- Code action
M.map({ "n", "v" }, "<A-q>", "<Cmd>Lspsaga code_action<CR>")
-- Hover Doc
M.map("n", "zz", "<Cmd>Lspsaga hover_doc<CR>")
-- Rename all
M.map("n", "<C-e>", "<Cmd>Lspsaga rename<CR>")
-- Find all
M.map("n", "<C-f>", "<Cmd>Lspsaga finder<CR>")
-- Toggle outline
M.map("n", "<leader>`", "<cmd>Lspsaga outline<CR>")
