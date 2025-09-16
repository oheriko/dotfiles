return {
  name = "rust",
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      cargo = {
        buildScripts = { enable = true },
      },
      procMacro = {
        enable = true,
      },
      completion = {
        addCallParentheses = false,
      },
    },
  },
}
