-- lua/plugins/avante/config.lua
-- Avante configuration settings

local env = require("config.env")

return {
  mode = "legacy",
  input = {
    provider = "native",
  },
  selector = {
    provider = "fzf_lua",
    provider_opts = {},
  },
  provider = "claude",
  providers = {
    ollama = {
      endpoint = env.ollama_endpoint,
      model = "gpt-oss:20b",
      extra_request_body = {
        options = {
          temperature = 0.1,
          num_ctx = 16384,
        },
      },
    },
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-5-20250929",
      api_key = env.anthropic_api_key,
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
  },

  -- System prompt with MCP Hub integration
  system_prompt = function()
    local hub_ok, hub = pcall(require, "mcphub")
    if not hub_ok then
      return ""
    end
    local instance = hub.get_hub_instance()
    return instance and instance:get_active_servers_prompt() or ""
  end,

  -- MCP tools integration
  custom_tools = function()
    local ok, mcp = pcall(require, "mcphub.extensions.avante")
    if not ok then
      return {}
    end
    return {
      mcp.mcp_tool(),
    }
  end,

  -- Disable Avante's built-in tools that conflict with MCP Hub
  disabled_tools = {
    "list_files",
    "search_files",
    "read_file",
    "create_file",
    "rename_file",
    "delete_file",
    "create_dir",
    "rename_dir",
    "delete_dir",
    "bash",
  },

  -- Window configuration
  windows = {
    position = "right",
    wrap = true,
    width = 30,
    sidebar_header = {
      align = "center",
      rounded = true,
    },
  },

  -- Behavior settings
  behaviour = {
    auto_suggestions = false, -- Prevent conflicts
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
}
