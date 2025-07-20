return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      astro = { "biome-check", "biome", "prettierd", "prettier" },
      css = { "biome-check", "biome" },
      go = { "gofmt" },
      lua = { "stylua" },
      javascript = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
      json = { "biome-check", "biome" },
      jsonc = { "biome-check", "biome" },
      nix = { "nixfmt" },
      python = { "ruff_fix", "ruff_format" },
      rust = { "rustfmt" },
      typescript = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = { timeout_ms = 500 },
    lsp_format = "fallback",
  },
}
