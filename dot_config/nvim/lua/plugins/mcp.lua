return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua",
    version = "6.*",
    opts = {
      use_bundled_binary = true,
      config = vim.fn.expand("~/.config/mcphub/servers.json"),
      workspace = {
        look_for = { ".mcp/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
      },
      on_ready = function() vim.notify("MCP Hub is online!") end,
      log = {
        level = vim.log.levels.WARN,
        to_file = true,
      },
      extensions = {
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          make_vars = true, -- make chat #variables from MCP server resources
          make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    version = "17.*",
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat toggle<cr>", desc = "Code Companion Chat" },
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
    },
    opts = {
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.5-pro-preview-03-25",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemini",
          tools = {
            ["mcp"] = {
              callback = function() return require("mcphub.extensions.codecompanion") end,
              description = "Call tools and resources from the MCP Servers",
              opts = {
                requires_approval = true,
              },
            },
          },
        },
        inline = {
          adapter = "gemini",
          tools = {
            ["mcp"] = {
              callback = function() return require("mcphub.extensions.codecompanion") end,
              description = "Call tools and resources from the MCP Servers",
              opts = {
                requires_approval = true,
              },
            },
          },
        },
        cmd = {
          adapter = "gemini",
          tools = {
            ["mcp"] = {
              callback = function() return require("mcphub.extensions.codecompanion") end,
              description = "Call tools and resources from the MCP Servers",
              opts = {
                requires_approval = true,
              },
            },
          },
        },
      },
      display = {
        chat = {
          show_settings = true,
        },
      },
    },
  },
}
