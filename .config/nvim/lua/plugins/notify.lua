local notify = require("notify")

notify.setup({
  -- Animation style
  -- stages = "slide", -- or "fade", "static"

  -- Timeout
  timeout = 2000, -- 2 seconds, then auto-dismiss

  -- Positioning
  top_down = false, -- Bottom up from bottom-right corner

  focusable = false,

  -- Size
  max_width = 50, -- Keep it narrow
  max_height = 3, -- Keep it short
  minimum_width = 20,

  -- Appearance
  render = "compact",
  window = { config = { border = false } },

  -- Icons
  icons = {
    ERROR = "✗",
    WARN = "⚠",
    INFO = "ℹ",
    DEBUG = "⚙",
    TRACE = "→",
  },

  -- Level
  level = "INFO", -- Only show INFO and above (no DEBUG/TRACE spam)
})

vim.notify = notify
