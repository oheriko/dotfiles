return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
}

-- vim.lsp.config("ty", {
--   filetypes = {"python"},
--   root_dir = function(fname)
--     return vim.lsp.util.root_pattern("pyproject.toml","uv.lock","setup.py")(fname)
--            or vim.loop.cwd()
--   end,
-- })
-- vim.lsp.enable("ty")
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client.name == "ty" then
--       -- e.g., buffer-local keymaps, diagnostic config:
--       vim.diagnostic.config({virtual_text = true}, {buffer = args.buf})
--       -- setup keymaps for goto-definition, hover, etc.
--     end
--   end,
-- })
--
