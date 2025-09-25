return {
  name = "tailwindcss",
  -- cmd = { "tailwindcss-language-server", "--stdio" },
  cmd = { vim.fn.getcwd() .. "/node_modules/.bin/tailwindcss-language-server", "--stdio" },
  filetypes = { "astro", "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = {
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    -- "package.json",
  },
}
