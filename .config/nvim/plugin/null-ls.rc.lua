local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	debug = true,
	sources = {
		-- Lua Formatter
		null_ls.builtins.formatting.stylua,
		-- JS/TS Formatter/Linter
		null_ls.builtins.formatting.prettierd,
		require("none-ls.diagnostics.eslint_d").with({
			extra_args = { "--no-ignore" }, -- Example of passing extra arguments
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" })
			end,
			eslint_disable_if_no_config = true, -- Disable eslint_d if no config file is found
		}),
		-- C++ Formatter/Linter
		null_ls.builtins.formatting.clang_format,
		require("none-ls.diagnostics.cpplint"),
		-- Python Formatters
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		-- require("none-ls.diagnostics.pylint"),
	},
	-- Format On Save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
