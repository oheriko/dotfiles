local blink = require("blink.cmp")

blink.setup({
  keymap = {
    preset = "none",
    ["<c-n>"] = { "select_next", "fallback" },
    ["<c-p>"] = { "select_prev", "fallback" },
    ["<c-y>"] = { "accept", "fallback" },
    ["<c-d>"] = { "show_documentation", "hide_documentation" },
    ["<a-y>"] = require("minuet").make_blink_map(),
    -- ["<A-y>"] = { function() require("minuet").make_blink_map() end },
  },
  sources = {
    default = { "lsp", "buffer", "path", "snippets" },
    -- providers = {
    --   minuet = {
    --     name = "minuet",
    --     module = "minuet.blink",
    --     async = true,
    --     -- Should match minuet.config.request_timeout * 1000,
    --     -- since minuet.config.request_timeout is in seconds
    --     timeout_ms = 3000,
    --     score_offset = 50, -- Gives minuet higher priority among suggestions
    --   },
    -- },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    trigger = { prefetch_on_insert = false },
  },
})
