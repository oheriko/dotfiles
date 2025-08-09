vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 60 }) end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("format_options", { clear = true }),
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "javascript", "typescript", "tsx", "typescriptreact", "zig" },
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group = vim.api.nvim_create_augroup("json_conceal", {}),
--   pattern = { "json", "jsonc", "json5" },
--   callback = function() vim.opt_local.conceallevel = 0 end,
-- })

local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanion*",
  group = group,
  callback = function(request)
    if request.match == "CodeCompanionChatSubmitted" then
      return
    end

    local msg

    msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")

    vim.notify(msg, "info", {
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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    -- vim.diagnostic.config({
    --   virtual_lines = {
    --     only_current_line = false,
    --     highlight_whole_line = true,
    --     prefix = "▎",
    --     spacing = 4,
    --   },
    -- })
    --
    vim.diagnostic.config({ virtual_text = false })

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
  end,
})
