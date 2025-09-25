local imgclip = require("img-clip")

imgclip.setup({
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = {
      insert_mode = true,
    },
  },
})

vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from system clipboard" })
