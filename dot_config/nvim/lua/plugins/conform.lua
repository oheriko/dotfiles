return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      astro = { "biome", "prettierd", "prettier" },
      css = { "rustywind", lsp_format = "fallback" },
      go = { "gofmt" },
      lua = { "stylua" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      nix = { "nixfmt" },
      python = { "ruff_fix", "ruff_format" },
      rust = { "rustfmt" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
    },
    format_on_save = { timeout_ms = 500 },
  },
}
