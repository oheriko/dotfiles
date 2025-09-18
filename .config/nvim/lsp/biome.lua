return {
  name = "biome",
  cmd = { vim.fn.getcwd() .. "/node_modules/.bin/biome", "lsp-proxy" },
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
}
