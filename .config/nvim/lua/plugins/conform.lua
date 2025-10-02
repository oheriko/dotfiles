-- lua/plugins/conform.lua
-- Conform formatting configuration

local utils = require("config.utils")

-- Get Conform plugin
local conform = utils.safe_require("conform")
if not conform then
  return
end

-- Setup Conform with formatters
conform.setup({
  formatters_by_ft = {
    -- Web
    astro = { "biome", "prettierd", "prettier" },
    css = { "rustywind", lsp_format = "fallback" },
    html = { "prettierd", "prettier" },
    javascript = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    javascriptreact = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    typescript = { "biome", "biome-organize-imports", "prettierd", "prettier" },
    typescriptreact = { "biome", "biome-organize-imports", "prettierd", "prettier" },

    -- Data
    json = { "biome", "biome-organize-imports" },
    jsonc = { "biome", "biome-organize-imports" },
    yaml = { "yamlfmt" },

    -- Systems
    go = { "gofmt" },
    rust = { "rustfmt" },
    python = { "ruff_fix", "ruff_format" },
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    -- Other
    just = { "just" },
    nix = { "nixfmt" },
  },

  -- Format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
