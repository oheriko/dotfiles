-- lua/plugins/trouble.lua
-- Trouble diagnostics configuration

local utils = require("config.utils")
local map = utils.map

-- Get Trouble plugin
local trouble = utils.safe_require("trouble")
if not trouble then
  return
end

-- Setup Trouble with defaults
trouble.setup({})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Main trouble toggle
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Trouble: Toggle diagnostics")

-- Buffer diagnostics only
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Trouble: Buffer diagnostics")

-- Quickfix and location list
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", "Trouble: Quickfix list")
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", "Trouble: Location list")

-- Navigate between trouble items
map("n", "]t", function()
  trouble.next()
end, "Trouble: Next item")

map("n", "[t", function()
  trouble.prev()
end, "Trouble: Previous item")
