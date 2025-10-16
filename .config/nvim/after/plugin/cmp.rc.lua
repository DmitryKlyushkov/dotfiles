local status, cmp = pcall(require, "cmp")
if not status then
	return
end
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local function formatForTailwindCSS(entry, vim_item)
	if vim_item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
		if r then
			local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
			local group = "Tw_" .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

luasnip.filetype_extend("typescript", { "typescript" })
local snippets_path = vim.fs.joinpath(vim.fn.stdpath("config"), "after", "snippets")
require("luasnip.loaders.from_vscode").load({ paths = snippets_path })

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		-- ['<CR>'] = cmp.mapping.confirm({
		--   behavior = cmp.ConfirmBehavior.Replace,
		--   select = true
		-- }),
		-- ['<C-l>'] = cmp.mapping.confirm({
		--   behavior = cmp.ConfirmBehavior.Replace,
		--   select = true
		-- }),
		["<C-p>"] = cmp.config.disable,
		["<C-u>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				luasnip = "[snip]",
				nvim_lua = "[api]",
				path = "[path]",
				buffer = "[buf]",
			},
			before = function(entry, vim_item)
				vim_item = formatForTailwindCSS(entry, vim_item)
				return vim_item
			end,
		}),
	},
})
