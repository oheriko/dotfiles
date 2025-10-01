-- lua/plugins/blink/keymaps.lua
-- Blink.cmp keymap configuration

local map = require("config.utils").map

-- Completion keymaps (returned for blink setup)
local completion_keymaps = {
  preset = "default",

  -- Show/hide completion
  ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  ["<C-e>"] = { "hide", "fallback" },

  -- Accept completion
  ["<CR>"] = { "accept", "fallback" },
  ["<C-y>"] = { "select_and_accept", "fallback" },

  -- Navigate completion menu
  ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
  ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-p>"] = { "select_prev", "fallback" },
  ["<C-n>"] = { "select_next", "fallback" },

  -- Scroll documentation
  ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  ["<C-f>"] = { "scroll_documentation_down", "fallback" },
}

-- Utility keymaps (global)
local function setup_utility_keymaps()
  -- Toggle ghost text on/off
  map("n", "<leader>tg", function()
    local config = require("blink.cmp.config")
    config.completion.ghost_text.enabled = not config.completion.ghost_text.enabled
    local status = config.completion.ghost_text.enabled and "enabled" or "disabled"
    vim.notify("Ghost text " .. status, vim.log.levels.INFO)
  end, "Toggle completion ghost text")

  -- Toggle documentation auto-show
  map("n", "<leader>td", function()
    local config = require("blink.cmp.config")
    config.completion.documentation.auto_show = not config.completion.documentation.auto_show
    local status = config.completion.documentation.auto_show and "enabled" or "disabled"
    vim.notify("Documentation auto-show " .. status, vim.log.levels.INFO)
  end, "Toggle documentation auto-show")

  -- Force reload blink.cmp
  map("n", "<leader>br", function()
    vim.cmd("Lazy reload blink.cmp")
    vim.notify("Reloaded blink.cmp", vim.log.levels.INFO)
  end, "Reload blink.cmp")
end

return {
  completion_keymaps = completion_keymaps,
  setup_utility_keymaps = setup_utility_keymaps,
}
