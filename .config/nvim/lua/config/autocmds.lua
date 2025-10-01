local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local filetype = augroup("FileTypes", { clear = true })
local format = augroup("Format", { clear = true })
local highlight = augroup("Highlight", { clear = true })
local lsp = augroup("Lsp", { clear = true })

autocmd("FileType", {
  group = filetype,
  desc = "Disable auto-comment on new lines",
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
})

autocmd("BufEnter", {
  group = format,
  callback = function() vim.opt.formatoptions = "cqrnj" end,
})

autocmd("BufWritePre", {
  group = format,
  desc = "Remove trailing whitespace on save",
  callback = function()
    local cursor_pos = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", cursor_pos)
  end,
})

autocmd({ "BufWritePre" }, {
  group = format,
  desc = "Allow Neovim to create new directories",
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd("TextYankPost", {
  group = highlight,
  desc = "Highlight when yanking text",
  callback = function() vim.hl.on_yank({ timeout = 100 }) end,
})

autocmd("LspAttach", {
  group = lsp,
  desc = "LSP events",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if not client then
      return
    end

    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { client_id = client.id })
    end

    local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map("n", "gk", vim.lsp.buf.hover, "LSP Hover")
    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("n", "gr", vim.lsp.buf.references, "Symbol References")
    map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
    map("n", "ga", vim.lsp.buf.code_action, "Code Action")
    map("n", "gn", vim.lsp.buf.rename, "Rename Symbol")
    map("n", "gh", vim.lsp.buf.signature_help, "Signature Help")
    map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help (Insert)")
    map(
      "n",
      "gl",
      function()
        vim.diagnostic.open_float({
          border = "rounded",
          source = true,
          scope = "cursor",
          focusable = true,
        })
      end,
      "Open Diagnostic Float"
    )
    map("n", "gf", function() vim.lsp.buf.format({ async = true }) end, "Format Buffer")
    map("v", "gf", function() vim.lsp.buf.format({ async = true }) end, "Format Selection")
    map("n", "gS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    map("n", "gs", vim.lsp.buf.document_symbol, "Document Symbols")
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map(
      "n",
      "[e",
      function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
      "Previous Error"
    )
    map(
      "n",
      "]e",
      function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
      "Next Error"
    )
    map("n", "[D", function() vim.diagnostic.jump({ count = -math.huge, float = true }) end, "First Diagnostic")
    map("n", "]D", function() vim.diagnostic.jump({ count = math.huge, float = true }) end, "Last Diagnostic")
  end,
})

-- Enable treesitter for these filetypes
autocmd("FileType", {
  pattern = {
    "astro",
    "c",
    "css",
    "dockerfile",
    "git",
    "html",
    "javascript",
    "javascriptreact",
    "go",
    "lua",
    "markdown",
    "nix",
    "rust",
    "toml",
    "typescript",
    "typescriptreact",
    "yaml",
    "zig",
  },
  callback = function() vim.treesitter.start() end,
})
