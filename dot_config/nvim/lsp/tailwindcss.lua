return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "astro", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}
