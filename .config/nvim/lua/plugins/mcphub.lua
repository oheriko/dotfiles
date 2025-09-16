return {
  "ravitemer/mcphub.nvim",
  build = "bundled_build.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    use_bundled_binary = true,
    workspace = {
      enabled = true,
      look_for = { ".mcp/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
    },
  },
}
