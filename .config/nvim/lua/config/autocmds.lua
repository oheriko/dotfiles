-- lua/config/autocmds.lua
-- Autocommands configuration

local autocmd = vim.api.nvim_create_autocmd
local augroup = require("config.utils").augroup
local map = require("config.utils").map

-- ============================================================================
-- FILETYPE SETTINGS
-- ============================================================================

local filetype = augroup("FileTypes")

autocmd("FileType", {
  group = filetype,
  desc = "Disable auto-comment on new lines",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- ============================================================================
-- FORMATTING
-- ============================================================================

local format = augroup("Format")

autocmd("BufEnter", {
  group = format,
  desc = "Set format options",
  callback = function()
    vim.opt.formatoptions = "cqrnj"
  end,
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

autocmd("BufWritePre", {
  group = format,
  desc = "Create parent directories if they don't exist",
  callback = function(ev)
    -- Skip for special protocols (http://, etc)
    if ev.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ============================================================================
-- VISUAL FEEDBACK
-- ============================================================================

local highlight = augroup("Highlight")

autocmd("TextYankPost", {
  group = highlight,
  desc = "Highlight yanked text briefly",
  callback = function()
    vim.hl.on_yank({ timeout = 100 })
  end,
})

-- ============================================================================
-- LSP
-- ============================================================================

local lsp = augroup("Lsp")

autocmd("LspAttach", {
  group = lsp,
  desc = "Configure LSP keymaps and features on attach",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if not client then
      return
    end

    -- Enable inline completion if supported
    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { client_id = client.id })
    end

    -- Buffer-local keymap helper
    local function lsp_map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    lsp_map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    lsp_map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    lsp_map("n", "gk", vim.lsp.buf.hover, "LSP Hover")
    lsp_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    lsp_map("n", "gr", vim.lsp.buf.references, "Symbol References")
    lsp_map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")

    -- Actions
    lsp_map("n", "ga", vim.lsp.buf.code_action, "Code Action")
    lsp_map("n", "gn", vim.lsp.buf.rename, "Rename Symbol")

    -- Information
    lsp_map("n", "gh", vim.lsp.buf.signature_help, "Signature Help")
    lsp_map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help (Insert)")
    lsp_map("n", "gl", function()
      vim.diagnostic.open_float({
        border = "rounded",
        source = true,
        scope = "cursor",
        focusable = true,
      })
    end, "Open Diagnostic Float")

    -- Formatting
    lsp_map("n", "gf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Buffer")
    lsp_map("v", "gf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Selection")

    -- Symbols
    lsp_map("n", "gS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    lsp_map("n", "gs", vim.lsp.buf.document_symbol, "Document Symbols")

    -- Diagnostics navigation
    lsp_map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Previous Diagnostic")
    lsp_map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next Diagnostic")
    lsp_map("n", "[e", function()
      vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
    end, "Previous Error")
    lsp_map("n", "]e", function()
      vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
    end, "Next Error")
    lsp_map("n", "[D", function()
      vim.diagnostic.jump({ count = -math.huge, float = true })
    end, "First Diagnostic")
    lsp_map("n", "]D", function()
      vim.diagnostic.jump({ count = math.huge, float = true })
    end, "Last Diagnostic")
  end,
})

-- ============================================================================
-- TREESITTER
-- ============================================================================

local treesitter_filetypes = {
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
}

autocmd("FileType", {
  pattern = treesitter_filetypes,
  desc = "Enable treesitter for supported filetypes",
  callback = function()
    vim.treesitter.start()
  end,
})
