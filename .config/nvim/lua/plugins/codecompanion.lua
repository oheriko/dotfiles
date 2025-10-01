-- lua/plugins/codecompanion.lua
-- CodeCompanion configuration

local utils = require("config.utils")
local env = require("config.env")
local map = utils.map

-- Get CodeCompanion plugin
local codecompanion = utils.safe_require("codecompanion")
if not codecompanion then
  return
end

-- Setup CodeCompanion
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
          callback = function()
            local ok, mcp = pcall(require, "mcphub.extensions.codecompanion")
            if not ok then
              return nil
            end
            return mcp
          end,
          description = "Access MCP servers (fetch, git, filesystem, etc.)",
          opts = {
            requires_approval = false,
          },
        },
      },
      opts = {
        completion_provider = "blink", -- Use blink.cmp for @ and / completions
      },
    },
    inline = {
      adapter = "anthropic",
    },
    agent = {
      adapter = "anthropic",
      tools = {
        ["mcp"] = {
          callback = function()
            local ok, mcp = pcall(require, "mcphub.extensions.codecompanion")
            if not ok then
              return nil
            end
            return mcp
          end,
          description = "Access MCP servers",
        },
      },
    },
  },

  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -- MCP Tools
        make_tools = true,
        show_server_tools_in_chat = true,
        add_mcp_prefix_to_tool_names = false,
        show_result_in_chat = true,

        -- MCP Resources
        make_vars = true,

        -- MCP Prompts
        make_slash_commands = true,
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

-- ============================================================================
-- KEYMAPS
-- ============================================================================

map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", "CodeCompanion: Actions")
map({ "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", "CodeCompanion: Toggle chat")
map("v", "<leader>c+", "<cmd>CodeCompanionChat Add<cr>", "CodeCompanion: Add to chat")
map({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", "CodeCompanion: Inline")

-- Command abbreviation
vim.cmd([[cab cc CodeCompanion]])
