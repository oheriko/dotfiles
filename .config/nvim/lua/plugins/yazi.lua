--[[
Yazi file manager integration

Dependencies:
  - nvim-lua/plenary.nvim (required)
  - nvim-tree/nvim-web-devicons (optional, for icons)

Installation in init.lua:
  vim.pack.add({
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons'
  })

Usage:
  <leader>y - Open yazi
--]]

local yazi = require("yazi")

yazi.setup({
  open_for_directories = true,
  keymaps = {
    show_help = "<f1>",
  },
})

local keymap = vim.keymap.set

keymap({ "n", "v" }, "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
keymap({ "n", "v" }, "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
