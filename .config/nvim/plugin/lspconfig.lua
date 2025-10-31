--vim.lsp.set_log_level("debug")

local protocol = require("vim.lsp.protocol")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	---@diagnostic disable-next-line: unused-function, unused-local
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
end

protocol.CompletionItemKind = {
	"󰦪", -- Text
	"󰊕", -- Method
	"󰊕", -- Function
	"󰫰", -- Constructor
	"", -- Field
	"󰫧", -- Variable
	"", -- Class
	"󰫶", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"󰬃", -- Value
	"", -- Enum
	"󰌋", -- Keyword
	"󰩫", -- Snippet
	"", -- Color
	"", -- File
	"󰭔", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.enable({
	-- CSS variables autocompletion and go-to-definition
	-- https://github.com/vunguyentuan/vscode-css-variables/
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/css_variables.lua
	"css_variables",
	-- CSS language server extracted from VSCode
	-- https://github.com/hrsh7th/vscode-langservers-extracted
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/cssls.lua
	"cssls",
	-- Language server for autocompletion and go-to-definition functionality for CSS modules
	-- https://github.com/antonk52/cssmodules-language-server
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/cssmodules_ls.lua
	"cssmodules_ls",
	-- HTML language server extracted from VSCode
	-- https://github.com/hrsh7th/vscode-langservers-extracted
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/html.lua
	"html",
	-- Emmet language server
	-- https://github.com/olrtg/emmet-language-server
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/emmet_language_server.lua
	"emmet_language_server",
	-- JSON language server extracted from VSCode
	-- https://github.com/hrsh7th/vscode-langservers-extracted
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jsonls.lua
	"jsonls",
	-- Lua language server
	-- https://github.com/luals/lua-language-serve
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
	"lua_ls",
	-- Typescript language server
	-- https://github.com/typescript-language-server/typescript-language-server
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua
	-- configs: https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
	"ts_ls",
	-- Tailwind CSS Language Server
	-- https://github.com/tailwindlabs/tailwindcss-intellisense
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
	"tailwindcss",
	-- Language Server for the Prisma JavaScript and TypeScript ORM
	-- default vim.lsp.config(): https://github.com/neovim/nvim-lspconfig/blob/master/lsp/prismals.lua
	"prismals",
})

-- lua_ls configs
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

-- ts_ls configs
vim.lsp.config("ts_ls", {
	on_attach = function(_, _)
		local function goto_source_definiton()
			local params = vim.lsp.util.make_position_params(0, "utf-16")
			vim.lsp.buf_request(0, "workspace/executeCommand", {
				command = "_typescript.goToSourceDefinition",
				arguments = { vim.uri_from_bufnr(0), params.position },
			}, function(err, result, _, _)
				if err then
					vim.notify(
						"Error executing _typescript.goToSourceDefinition: " .. err.message,
						vim.log.levels.ERROR
					)
					return
				end
				if result and result[1] then
					vim.lsp.util.show_document(result[1], "utf-16", { focus = true })
				else
					vim.notify("No source definition found", vim.log.levels.INFO)
				end
			end)
		end
		vim.keymap.set("n", "gs", goto_source_definiton)
	end,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	underline = true,
-- 	update_in_insert = false,
-- 	virtual_text = { spacing = 4, prefix = "●" },
-- 	severity_sort = true,
-- })
--
-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "󰗖 ", Warn = "󰀪 ", Hint = "󰛩 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	severity_sort = true, -- Sort by severity: errors first, then warnings, etc.
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		-- "if_many" or "always"
		source = "if_many",
	},
})
