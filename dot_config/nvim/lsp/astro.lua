return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json" },
  init_options = {
    typescript = {
      tsdk = vim.uv.cwd() .. "/node_modules/typescript/lib",
    },
  },
}
