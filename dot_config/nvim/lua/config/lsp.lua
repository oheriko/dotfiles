vim.lsp.config("*", {
  -- capabilities = {
  --   textDocument = {
  --     semanticTokens = {
  --       multilineTokenSupport = true,
  --     },
  --   },
  -- },
  root_markers = { ".git" },
})

vim.lsp.enable({
  "astro",
  "go",
  "luals",
  "ruff",
  "rust-analyzer",
  "tailwindcss",
  "tsserver",
  "ty",
})
