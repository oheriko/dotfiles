-- lua/plugins/avante/init.lua
-- Main Avante configuration entry point

local utils = require("config.utils")
local build = require("plugins.avante.build")
local config = require("plugins.avante.config")
local keymaps = require("plugins.avante.keymaps")

-- Ensure Avante is built before setup
build.ensure_built()

-- Get Avante plugin
local avante = utils.safe_require("avante")
if not avante then
  return
end

-- Setup Avante with config
avante.setup(config)

-- Setup keymaps
keymaps.setup()

-- ============================================================================
-- WINDOW MANAGEMENT FIXES
-- ============================================================================

-- Fix: Prevent Avante from opening windows during window close operations
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  desc = "Prevent Avante window conflicts",
  callback = function()
    -- Don't do anything if we're in the middle of closing windows
    if vim.v.exiting ~= vim.NIL then
      return
    end
  end,
})
