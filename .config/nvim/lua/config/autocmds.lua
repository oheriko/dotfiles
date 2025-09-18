local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local code_companion = augroup("CodeCompanionFidgetHooks", { clear = true })
local filetype = augroup("FileTypes", { clear = true })
local format = augroup("Format", { clear = true })
local highlight = augroup("Highlight", { clear = true })
local lsp = augroup("Lsp", { clear = true })

local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

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
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
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
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map("n", "gk", vim.lsp.buf.hover, "LSP Hover")
    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("n", "gr", vim.lsp.buf.references, "Symbol References")
    map("n", "ga", vim.lsp.buf.code_action, "Code Action")
    map("n", "gn", vim.lsp.buf.rename, "Rename Symbol")
    map("n", "gh", vim.lsp.buf.signature_help, "Signature Help")
    map("n", "gl", vim.diagnostic.open_float, "Open Diagnostic Float")
    map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
    map("n", "gf", function() vim.lsp.buf.format({ async = true }) end, "Format Buffer")
    map("v", "gf", function() vim.lsp.buf.format({ async = true }) end, "Format Selection")
    map("n", "gS", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    map("n", "gs", vim.lsp.buf.document_symbol, "Document Symbols")
    map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
    map(
      "n",
      "[e",
      function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      "Previous Error"
    )
    map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next Error")
    map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help (Insert)")
    map("n", "gvl", function()
      local config = vim.diagnostic.config()
      vim.diagnostic.config({ virtual_lines = not config.virtual_lines })
    end, "Toggle Virtual Lines")
  end,
})

autocmd({ "User" }, {
  pattern = "CodeCompanion*",
  group = code_companion,
  callback = function(request)
    if request.match == "CodeCompanionChatSubmitted" then
      return
    end

    local msg

    msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")

    vim.notify(msg, 1, {
      timeout = 1000,
      keep = function()
        return not vim
          .iter({ "Finished", "Opened", "Hidden", "Closed", "Cleared", "Created" })
          :fold(false, function(acc, cond) return acc or vim.endswith(request.match, cond) end)
      end,
      id = "code_companion_status",
      title = "Code Companion Status",
      opts = function(notif)
        notif.icon = ""
        if vim.endswith(request.match, "Started") then
          ---@diagnostic disable-next-line: undefined-field
          notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        elseif vim.endswith(request.match, "Finished") then
          notif.icon = " "
        end
      end,
    })
  end,
})

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
