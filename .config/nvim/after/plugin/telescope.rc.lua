local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

local function telescope_image_preview()
	local supported_images = { "svg", "png", "jpg", "jpeg", "gif", "webp", "avif" }
	local from_entry = require("telescope.from_entry")
	local Path = require("plenary.path")
	local conf = require("telescope.config").values
	local Previewers = require("telescope.previewers")

	local previewers = require("telescope.previewers")
	local image_api = require("image")

	local is_image_preview = false
	local image = nil
	local last_file_path = ""

	local is_supported_image = function(filepath)
		local split_path = vim.split(filepath:lower(), ".", { plain = true })
		local extension = split_path[#split_path]
		return vim.tbl_contains(supported_images, extension)
	end

	local delete_image = function()
		if not image then
			return
		end

		image:clear()

		is_image_preview = false
	end

	local create_image = function(filepath, winid, bufnr)
		image = image_api.hijack_buffer(filepath, winid, bufnr)

		if not image then
			return
		end

		vim.schedule(function()
			image:render()
		end)

		is_image_preview = true
	end

	local function defaulter(f, default_opts)
		default_opts = default_opts or {}
		return {
			new = function(opts)
				if conf.preview == false and not opts.preview then
					return false
				end
				opts.preview = type(opts.preview) ~= "table" and {} or opts.preview
				if type(conf.preview) == "table" then
					for k, v in pairs(conf.preview) do
						opts.preview[k] = vim.F.if_nil(opts.preview[k], v)
					end
				end
				return f(opts)
			end,
			__call = function()
				local ok, err = pcall(f(default_opts))
				if not ok then
					error(debug.traceback(err))
				end
			end,
		}
	end

	-- NOTE: Add teardown to cat previewer to clear image when close Telescope
	local file_previewer = defaulter(function(opts)
		opts = opts or {}
		local cwd = opts.cwd or vim.loop.cwd()
		return Previewers.new_buffer_previewer({
			title = "File Preview",
			dyn_title = function(_, entry)
				return Path:new(from_entry.path(entry, true)):normalize(cwd)
			end,

			get_buffer_by_name = function(_, entry)
				return from_entry.path(entry, true)
			end,

			define_preview = function(self, entry, _)
				local p = from_entry.path(entry, true)
				if p == nil or p == "" then
					return
				end

				conf.buffer_previewer_maker(p, self.state.bufnr, {
					bufname = self.state.bufname,
					winid = self.state.winid,
					preview = opts.preview,
				})
			end,

			teardown = function(_)
				if is_image_preview then
					delete_image()
				end
			end,
		})
	end, {})

	local buffer_previewer_maker = function(filepath, bufnr, opts)
		-- NOTE: Clear image when preview other file
		if is_image_preview and last_file_path ~= filepath then
			delete_image()
		end

		last_file_path = filepath

		if is_supported_image(filepath) then
			create_image(filepath, opts.winid, bufnr)
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end

	return { buffer_previewer_maker = buffer_previewer_maker, file_previewer = file_previewer.new }
end

local image_preview = telescope_image_preview()

local action_state = require("telescope.actions.state")
-- Custom function to handle file opening with feh for images
local function open_files(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	local file_path = selection.path or selection[1] -- Get the file path
	local extension = vim.fn.fnamemodify(file_path, ":e"):lower() -- Get file extension

	-- List of image extensions to open with feh
	local image_extensions = { "png", "jpg", "jpeg", "gif", "webp", "avif" }

	if vim.tbl_contains(image_extensions, extension) then
		-- Open image with feh
		vim.fn.system(string.format("feh -F --draw-filename %s &", vim.fn.shellescape(file_path)))
	else
		-- Fallback to default open behavior
		actions.file_edit(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		file_previewer = image_preview.file_previewer,
		buffer_previewer_maker = image_preview.buffer_previewer_maker,
		sorting_strategy = "ascending", -- ascending, descending
		mappings = {
			n = {
				-- Close Telescope Window
				["<esc>"] = actions.close,
				["q"] = actions.close,
				-- Open File
				-- ["l"] = actions.select_default,
				["l"] = open_files,
				-- Open File In a New Tab
				["t"] = actions.file_tab,
				-- Open File In a Vertical/Horizontal Split
				["sv"] = actions.file_vsplit,
				["ss"] = actions.file_split,
				-- Delete Buffer (;r)
				["<c-d>"] = actions.delete_buffer,
				-- Delete Mark (;m)
				["dd"] = actions.delete_mark,
				-- Preview Scrolling
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
				["<C-l>"] = actions.preview_scrolling_right,
				["<C-h>"] = actions.preview_scrolling_left,
			},
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.4,
			},
		},
	},
	extensions = {
		file_browser = {
			hidden = true,
			sorting_strategy = "ascending", -- ascending, descending
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			initial_mode = "normal",
			mappings = {
				["n"] = {
					["h"] = fb_actions.goto_parent_dir, -- Go To Parent Directory
				},
			},
		},
	},
})

telescope.load_extension("file_browser")
-- Key Mappings
local M = require("utils")
-- File Browser
M.map("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = true,
		initial_mode = "normal",
	})
end)
-- Marks
M.map("n", ";m", function()
	builtin.marks({
		initial_mode = "normal",
	})
end)
-- Find Files
M.map("n", ";f", function()
	builtin.find_files({
		hidden = true,
	})
end)
-- Live Grep
M.map("n", ";r", function()
	builtin.live_grep()
end)
-- Help Tags
M.map("n", ";t", function()
	builtin.help_tags()
end)
-- Errors
M.map("n", ";e", function()
	builtin.diagnostics({
		initial_mode = "normal",
	})
end)
-- Buffers
M.map("n", ";;", function()
	builtin.buffers({
		initial_mode = "normal",
	})
end)
