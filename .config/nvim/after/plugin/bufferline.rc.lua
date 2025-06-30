local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = "slant",
		always_show_bufferline = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
		indicator = {
			style = "none",
		},
		diagnostics = "nvim_lsp",
		diagnostics_update_on_event = true, -- use nvim's diagnostic handler
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
	},
	highlights = {
		separator = {
			fg = "#073642",
			bg = "#002b36",
		},
		separator_selected = {
			fg = "#073642",
		},
		background = {
			fg = "#657b83",
			bg = "#002b36",
		},
		buffer_selected = {
			fg = "#fdf6e3",
			bg = "#111111",
			bold = true,
		},
		modified = {
			fg = "#50fa7b",
			bg = "#002b36",
		},
		modified_visible = {
			fg = "#50fa7b",
			bg = "#002b36",
		},
		modified_selected = {
			fg = "#50fa7b",
			bg = "#111111",
		},
		duplicate_selected = {
			fg = "#ff5555",
			bg = "#111111",
			bold = true,
		},
		duplicate_visible = {
			fg = "#ff5555",
			bg = "#002b36",
			bold = true,
		},
		duplicate = {
			fg = "#ff5555",
			bg = "#002b36",
			bold = true,
		},
		hint = {
			fg = "#10B981",
			bg = "#002b36",
		},
		hint_visible = {
			fg = "#10B981",
			bg = "#002b36",
		},
		hint_selected = {
			fg = "#10B981",
			bg = "#111111",
			bold = true,
		},
		hint_diagnostic = {
			fg = "#10B981",
			bg = "#002b36",
		},
		hint_diagnostic_visible = {
			fg = "#10B981",
			bg = "#002b36",
		},
		hint_diagnostic_selected = {
			fg = "#10B981",
			bg = "#111111",
			bold = true,
		},
		info = {
			fg = "#0db9d7",
			bg = "#002b36",
		},
		info_visible = {
			fg = "#0db9d7",
			bg = "#002b36",
		},
		info_selected = {
			fg = "#0db9d7",
			bg = "#111111",
			bold = true,
		},
		info_diagnostic = {
			fg = "#0db9d7",
			bg = "#002b36",
		},
		info_diagnostic_visible = {
			fg = "#0db9d7",
			bg = "#002b36",
		},
		info_diagnostic_selected = {
			fg = "#0db9d7",
			bg = "#111111",
			bold = true,
		},
		warning = {
			fg = "#e0af68",
			bg = "#002b36",
		},
		warning_visible = {
			fg = "#e0af68",
			bg = "#002b36",
		},
		warning_selected = {
			fg = "#e0af68",
			bg = "#111111",
			bold = true,
		},
		warning_diagnostic = {
			fg = "#e0af68",
			bg = "#002b36",
		},
		warning_diagnostic_visible = {
			fg = "#e0af68",
			bg = "#002b36",
		},
		warning_diagnostic_selected = {
			fg = "#e0af68",
			bg = "#111111",
			bold = true,
		},
		error = {
			fg = "#db4b4b",
			bg = "#002b36",
		},
		error_visible = {
			fg = "#db4b4b",
			bg = "#002b36",
		},
		error_selected = {
			fg = "#db4b4b",
			bg = "#111111",
			bold = true,
		},
		error_diagnostic = {
			fg = "#db4b4b",
			bg = "#002b36",
		},
		error_diagnostic_visible = {
			fg = "#db4b4b",
			bg = "#002b36",
		},
		error_diagnostic_selected = {
			fg = "#db4b4b",
			bg = "#111111",
			bold = true,
		},
		fill = {
			bg = "#073642",
		},
	},
})

-- Tab switch
vim.keymap.set("n", "<A-Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
