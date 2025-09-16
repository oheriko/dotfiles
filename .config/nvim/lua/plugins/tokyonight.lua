local tokyonight = require("tokyonight")

tokyonight.setup({
  style = "night",
  transparent = false,
  terminal_colors = true,
})

vim.cmd[[colorscheme tokyonight-night]]

