local mc = require("multicursor-nvim")
local M = require("utils")

mc.setup()

-- Add a cursor and jump to the next word under cursor.
M.map({ "n", "v" }, "<c-n>", function() mc.addCursor("*") end)

-- Jump to the next word under cursor but do not add a cursor.
M.map({ "n", "v" }, "<c-s>", function() mc.skipCursor("*") end)

-- Add and remove cursors with control + left click.
M.map("n", "<c-leftmouse>", mc.handleMouse)

-- Add a cursor
M.map({ "n", "v" }, "<c-1>", function()
  if mc.cursorsEnabled() then
    -- Stop other cursors from moving.
    -- This allows you to reposition the main cursor.
    mc.disableCursors()
  else
    mc.addCursor()
  end
end)

-- Delete the main cursor.
M.map({ "n", "v" }, "<c-2>", mc.deleteCursor)

-- Clear cursors
M.map("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    -- Default <esc> handler.
  end
end)

-- Split visual selections by regex.
M.map("v", "S", mc.splitCursors)
-- match new cursors within visual selections by regex.
M.map("v", "M", mc.matchCursors)
-- Customize how cursors look.
vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })

-- Add cursors above/below the main cursor.
-- M.map({ "n", "v" }, "<up>", function() mc.addCursor("k") end)
-- M.map({ "n", "v" }, "<down>", function() mc.addCursor("j") end)
--
-- Rotate the main cursor.
-- M.map({ "n", "v" }, "<left>", mc.nextCursor)
-- M.map({ "n", "v" }, "<right>", mc.prevCursor)
--
-- Align cursor columns.
-- M.map("n", "<leader>a", mc.alignCursors)
--
-- Append/insert for each line of visual selections.
-- M.map("v", "I", mc.insertVisual)
-- M.map("v", "A", mc.appendVisual)
--
-- Rotate visual selection contents.
-- M.map("v", "<leader>t", function() mc.transposeCursors(1) end)
-- M.map("v", "<leader>T", function() mc.transposeCursors(-1) end)
