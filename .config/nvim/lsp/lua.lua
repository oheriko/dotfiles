return {
  name = "lua",
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
