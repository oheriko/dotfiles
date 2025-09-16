local markdown = require("render-markdown")

markdown.setup({
  completions = { blink = { enabled = true } },
  file_types = { "markdown", "codecompanion" },
})
