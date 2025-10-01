-- lua/plugins/yazi.lua
-- Yazi file manager integration

local utils = require("config.utils")
local map = utils.map

-- Get Yazi plugin
local yazi = utils.safe_require("yazi")
if not yazi then
  return
end

-- Setup Yazi
yazi.setup({
  open_for_directories = true,
  keymaps = {
    show_help = "<f1>",
  },
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

map({ "n", "v" }, "<leader>-", "<cmd>Yazi<cr>", "Yazi: Open at current file")
map({ "n", "v" }, "<leader>cw", "<cmd>Yazi cwd<cr>", "Yazi: Open at cwd")
