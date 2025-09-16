local luasnip = require("luasnip")

luasnip.setup()

vim.api.nvim_create_user_command(
  "LuaSnipBuild",
  function() vim.system({ "make", "install_jsregexp" }, { cwd = vim.fn.stdpath("data") .. "/pack/core/opt/LuaSnip" }) end,
  {}
)
