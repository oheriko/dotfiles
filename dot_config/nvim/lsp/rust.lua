return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  on_attach = function(client) client.server_capabilities.semanticTokensProvider = nil end,
}
