local diagnostic = require("tiny-inline-diagnostic")

diagnostic.setup({
  preset = "powerline",
  options = {
    multilines = {
      enabled = true,
    },
    show_source = {
      enabled = true,
      if_many = false,
    },
  },
})

vim.diagnostic.config({ virtual_text = false })
