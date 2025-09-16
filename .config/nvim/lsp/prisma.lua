local prisma = vim.fn.getcwd() .. "/node_modules/.bin/prisma-language-server"

return {
  name = "prisma",
  cmd = { prisma },
  filetypes = { "prisma" },
  root_markers = { "package.json" },
}
