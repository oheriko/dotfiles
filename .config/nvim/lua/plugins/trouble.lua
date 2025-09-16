-- Simple Trouble.nvim setup
require("trouble").setup({
  -- Keep it minimal - use defaults for most options
})

-- Basic keymaps
local opts = { noremap = true, silent = true }

-- Main trouble toggle
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)

-- Buffer diagnostics only
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)

-- Quickfix and location list
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", opts)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", opts)

-- Navigate between trouble items
vim.keymap.set("n", "]t", function() require("trouble").next() end, opts)
vim.keymap.set("n", "[t", function() require("trouble").prev() end, opts)
