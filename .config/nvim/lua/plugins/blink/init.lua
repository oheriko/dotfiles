-- lua/plugins/blink/init.lua
-- Main blink.cmp configuration entry point

local utils = require("config.utils")

-- Load configuration modules
local sources = require("plugins.blink.sources")
local appearance = require("plugins.blink.appearance")
local keymaps = require("plugins.blink.keymaps")

-- Get blink.cmp plugin
local blink = utils.safe_require("blink.cmp")
if not blink then
  return
end

-- Setup blink.cmp with modular config
blink.setup({
  -- Appearance settings
  -- appearance = {
  --   use_nvim_cmp_as_default = appearance.use_nvim_cmp_as_default,
  --   nerd_font_variant = appearance.nerd_font_variant,
  -- },

  -- Source configuration
  sources = sources,

  -- Signature help configuration
  signature = appearance.signature,

  -- Completion configuration
  completion = appearance.completion,

  -- Fuzzy matching configuration
  fuzzy = {
    implementation = "lua",
    -- Use frecency and proximity for better sorting
    frecency = {
      enabled = true,
    },
    use_proximity = true,
    sorts = { "score", "sort_text" },
  },

  -- Keymaps
  keymap = keymaps.completion_keymaps,

  -- Cmdline completion
  cmdline = {
    enabled = true,
    keymap = {
      preset = "default",
    },
  },
})

-- Setup utility keymaps
keymaps.setup_utility_keymaps()

-- ============================================================================
-- AVANTE INTEGRATION
-- ============================================================================
-- Disable blink.cmp in Avante input buffers to prevent conflicts
vim.api.nvim_create_autocmd("FileType", {
  pattern = "AvanteInput",
  callback = function()
    require("blink.cmp").setup({
      enabled = function() return vim.bo.buftype ~= "prompt" end,
    })
  end,
})
