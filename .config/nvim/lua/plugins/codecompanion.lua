local codecompanion = require("codecompanion")

codecompanion.setup({
  adapters = {
    http = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "ANTHROPIC_API_KEY",
          },
          schema = {
            model = {
              default = "claude-sonnet-4-5-20250929",
            },
          },
        })
      end,
    },
  },
  strategies = {
    chat = {
      adapter = "anthropic",
      tools = {
        ["mcp"] = {
          callback = function() return require("mcphub.extensions.codecompanion") end,
          description = "Access MCP servers (fetch, git, filesystem, etc.)",
          opts = {
            requires_approval = false,
          },
        },
      },
    },
    inline = {
      adapter = "anthropic",
    },
    agent = {
      adapter = "anthropic",
      tools = {
        ["mcp"] = {
          callback = function() return require("mcphub.extensions.codecompanion") end,
          description = "Access MCP servers",
        },
      },
    },
  },
  -- NEW: Add extensions configuration
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server)
        show_server_tools_in_chat = true, -- Show individual tools in chat completion
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix
        show_result_in_chat = true, -- Show tool results directly in chat

        -- MCP Resources
        make_vars = true, -- Convert MCP resources to #variables

        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
  },
  display = {
    chat = {
      window = {
        layout = "vertical",
        width = 0.45,
        height = 0.8,
      },
    },
  },
})

-- Keymaps remain the same
local map = vim.keymap.set
map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion: Actions" })
map({ "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion: Toggle chat" })
map("v", "<leader>c+", "<cmd>CodeCompanionChat Add<cr>", { desc = "CodeCompanion: Add to chat" })
map({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline" })

vim.cmd([[cab cc CodeCompanion]])
