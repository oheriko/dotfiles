return {
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "codecompanion" },
    opts = {
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspace = {
        enabled = true,
        look_for = { ".mcp/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "ravitemer/codecompanion-history.nvim",
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Code Companion Chat" } },
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions" } },
    },
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
      display = {
        chat = { show_settings = true },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {},
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- Create tools like @server and @server__tool from MCP servers
            make_tools = true,
            show_server_tools_in_chat = true,
            show_result_in_chat = true,
            -- Create #variables from MCP resources
            make_vars = true,
            -- Create /slash commands from MCP prompts
            make_slash_commands = true,
          },
        },
      },
    },
    -- Expand 'cc' into 'CodeCompanion' in the command line
    -- vim.cmd([[cabbrev cc CodeCompanion]])
  },
}
