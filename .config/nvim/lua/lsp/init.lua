-- lua/lsp/init.lua
-- Centralized LSP configuration factory

local env = require("config.env")

-- LSP configuration factory
local function create_config(opts)
  return vim.tbl_deep_extend("force", {
    name = opts.name,
    cmd = opts.cmd,
    filetypes = opts.filetypes,
    root_markers = opts.root_markers or {},
    settings = opts.settings or {},
    init_options = opts.init_options or {},
    flags = opts.flags or {},
    on_attach = opts.on_attach,
  }, opts.extra or {})
end

-- All LSP configurations
local configs = {
  astro = create_config({
    name = "astro",
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_markers = { "package.json" },
    init_options = {
      typescript = {
        tsdk = env.cwd() .. "/node_modules/typescript/lib",
      },
    },
  }),

  biome = create_config({
    name = "biome",
    cmd = { env.node_bin("biome"), "lsp-proxy" },
    filetypes = {
      "astro",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
    root_markers = { "biome.json", "biome.jsonc", "package.json" },
  }),

  go = create_config({
    name = "go",
    cmd = { "gopls" },
    filetypes = { "go", "gomod" },
    root_markers = { "go.mod" },
  }),

  just = create_config({
    name = "just",
    cmd = { "just-lsp" },
    filetypes = { "just" },
    root_markers = { "justfile" },
    flags = {
      debounce_text_changes = 150,
    },
  }),

  lua = create_config({
    name = "lua",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }),

  prisma = create_config({
    name = "prisma",
    cmd = { env.node_bin("prisma-language-server") },
    filetypes = { "prisma" },
    root_markers = { "package.json" },
  }),

  python = create_config({
    name = "python",
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml" },
  }),

  rust = create_config({
    name = "rust",
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml" },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = {
          command = "clippy",
        },
        cargo = {
          buildScripts = { enable = true },
        },
        procMacro = {
          enable = true,
        },
        completion = {
          addCallParentheses = false,
        },
      },
    },
  }),

  tailwindcss = create_config({
    name = "tailwindcss",
    cmd = { env.node_bin("tailwindcss-language-server"), "--stdio" },
    filetypes = { "astro", "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = {
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
    },
  }),

  typescript = create_config({
    name = "typescript",
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json" },
  }),

  yaml = create_config({
    name = "yaml",
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { ".git" },
    settings = {
      yaml = {
        format = {
          enable = false,
        },
      },
    },
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }),
}

-- Return individual configs for backward compatibility
-- This allows the old lsp/*.lua files to still work
for name, config in pairs(configs) do
  configs[name] = config
end

return configs
