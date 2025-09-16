return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    "ravitemer/mcphub.nvim",
    "franco-ruggeri/codecompanion-spinner.nvim",
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Code Companion Chat", mode = { "n", "v" } } },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions", mode = { "n", "v" } } },
    {
      "<leader>cp",
      "<cmd>CodeCompanionChat Add<CR>",
      desc = "Add code to a chat buffer",
      mode = { "v" },
    },
  },
  init = function() vim.cmd([[cab cc CodeCompanion]]) end,
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = "gemini",
          model = "gemini-2.5-pro",
        },
        opts = { completion_provider = "blink" },
      },
      inline = {
        adapter = {
          name = "gemini",
          model = "gemini-2.5-pro",
        },
        opts = { completion_provider = "blink" },
      },
    },
    -- display = {
    --   chat = { show_settings = true },
    -- },
    extensions = {
      history = {
        enabled = true,
        opts = {},
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_slash_commands = true,
          make_tools = true,
          make_vars = true,
          show_result_in_chat = true,
          show_server_tools_in_chat = true,
        },
      },
      spinner = {},
    },
  },
}
