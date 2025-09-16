return {
  name = "astro",
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json" },
  init_options = {
    typescript = {
      -- Should be function?
      tsdk = vim.uv.cwd() .. "/node_modules/typescript/lib",
    },
  },
}
