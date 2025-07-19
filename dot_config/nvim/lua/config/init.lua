vim.g.mapleader = " "
vim.g.augment_workspace_folders = { vim.uv.cwd() }
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cmdheight = 0
vim.opt.guicursor = "n-v-c-i:block-blinkwait1000-blinkon500-blinkoff500"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 999
vim.opt.backupcopy = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.listchars:append({
  tab = "❘-",
  trail = "￮",
  extends = "▶",
  precedes = "◀",
  nbsp = "⏑",
})
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500

vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = "Disable highlight" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 60 }) end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = "*",
  callback = function() vim.opt.formatoptions = "cqrnj" end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", {}),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("json_conceal", {}),
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})

vim.lsp.enable({
  "astro",
  "go",
  "luals",
  "ruff",
  "rust-analyzer",
  "tsserver",
  "ty",
})

vim.diagnostic.config({
  virtual_lines = {
    only_current_line = false,
    highlight_whole_line = true,
    prefix = "▎",
    spacing = 4,
  },
})
vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- local opts = { noremap = true, silent = true }

    -- local bufmap = function(mode, lhs, rhs, desc)
    --   local opts = { buffer = args.buf, desc = desc }
    --   vim.keymap.set(mode, lhs, rhs, opts)
    -- end
    --
    -- bufmap("i", "<c-leader>", "<C-x><C-o>", "Open Cmp/Definition")
    -- bufmap("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration")
    -- bufmap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition")
    -- bufmap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover")
    -- bufmap("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action")
    -- bufmap("v", "<leader>la", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Range Code Action")
    -- bufmap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation")
    -- bufmap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help")
    -- bufmap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
    -- bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", "References")
    -- bufmap("n", "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Diagnostic")
    -- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
    -- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
    -- "grr" is mapped in Normal mode to vim.lsp.buf.references()
    -- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
    -- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
    -- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
    vim.keymap.set("n", "gk", vim.lsp.buf.hover, { desc = "LSP Hover" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
    vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Symbol References" })
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
    -- vim.keymap.set("n", "[d", vim.diagnostic.prev, { desc = "Go to Next Diagnostic" })
    -- vim.keymap.set("n", "]d", vim.diagnostic.next, { desc = "Go to Previous Diagnostic" })
    -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic to local list" })
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method('textDocument/implementation') then
--       -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--         and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })
