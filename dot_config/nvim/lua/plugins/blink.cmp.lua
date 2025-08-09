return {
  "saghen/blink.cmp",
  -- dependencies = {
  --   "milanglacier/minuet-ai.nvim",
  -- },
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- Manually invoke minuet completion.
      -- ["<A-y>"] = require("minuet").make_blink_map(),
    },
    sources = {
      -- Enable minuet for autocomplete
      -- "minuet"

      default = {
        "lsp",
        "path",
        "buffer",
        "snippets",
      },
      -- For manual completion only, remove 'minuet' from default
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
    -- Recommended to avoid unnecessary request
    completion = { trigger = { prefetch_on_insert = false } },
  },
  -- opts_extend = { "sources.default" },
}
