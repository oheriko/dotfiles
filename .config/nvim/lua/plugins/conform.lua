local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    astro = { "biome", "prettierd", "prettier" },
    css = { "rustywind", lsp_format = "fallback" },
    go = { "gofmt" },
    lua = { "stylua" },
    javascript = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    javascriptreact = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    json = { "biome", "biome-organize-imports" },
    jsonc = { "biome", "biome-organize-imports" },
    just = { "just" },
    nix = { "nixfmt" },
    python = { "ruff_fix", "ruff_format" },
    rust = { "rustfmt" },
    typescript = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    typescriptreact = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    yaml = { "yamlfmt" },
  },
  format_on_save = { timeout_ms = 500 },
})
