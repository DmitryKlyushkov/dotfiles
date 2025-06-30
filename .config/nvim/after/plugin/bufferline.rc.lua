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
		fill = {
			bg = "#073642",
		},
	},
})

-- Tab switch
vim.keymap.set("n", "<A-Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
