local utils = require("config.utils")

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    focusable = true,
  },
})

local completion_kinds = vim.lsp.protocol.CompletionItemKind

for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

local servers = {
  "biome",
  "go",
  "just",
  "lua",
  "prisma",
  "python",
  "rust",
  "tailwindcss",
  "typescript",
  "yaml",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

utils.del_map("n", { "grn", "gra", "gri", "grr" })
