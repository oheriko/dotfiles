return {
  name = "tailwindcss",
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "astro", "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = {
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    "package.json",
  },
}
