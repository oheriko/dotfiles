local markdown = require("render-markdown")

markdown.setup({
  completions = { lsp = { enabled = true } },
  file_types = { "markdown", "Avante" },
})
