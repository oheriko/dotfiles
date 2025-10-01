require("mcphub").setup({
  -- Point to the mcp-hub binary from Nix
  cmd = "mcp-hub", -- This will be in PATH from the devShell

  -- Config file location
  config = vim.fn.expand("~/.config/mcphub/servers.json"),

  -- Port for the MCP Hub server
  port = 37373,

  -- Workspace configuration
  workspace = {
    enabled = true,
    look_for = { ".mcphub/servers.json" },
    reload_on_dir_changed = true,
    port_range = { min = 40000, max = 41000 },
  },

  -- Rest of your config...
  shutdown_delay = 5 * 60 * 1000,
  mcp_request_timeout = 60000,
  auto_approve = false,
  auto_toggle_mcp_servers = true,
  log = {
    level = vim.log.levels.WARN,
    to_file = false,
  },
  ui = {
    window = {
      width = 0.8,
      height = 0.8,
      align = "center",
    },
    border = "rounded",
    title = " MCP Hub ",
  },
  extensions = {
    avante = {
      make_slash_commands = true,
    },
  },
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>mh", "<cmd>MCPHub<cr>", { desc = "MCP: Open Hub" })
map("n", "<leader>mr", "<cmd>MCPHubRestart<cr>", { desc = "MCP: Restart server" })
map("n", "<leader>ml", "<cmd>MCPHubLogs<cr>", { desc = "MCP: View logs" })
map("n", "<leader>mi", "<cmd>MCPHubInstallDeps<cr>", { desc = "MCP: Install deps" })
map("n", "<leader>ms", function()
  vim.ui.select({ "start", "stop", "restart", "enable", "disable" }, { prompt = "Server action:" }, function(choice)
    if choice then
      local cmd = "MCPHub" .. choice:gsub("^%l", string.upper)
      vim.cmd(cmd)
    end
  end)
end, { desc = "MCP: Server actions" })
