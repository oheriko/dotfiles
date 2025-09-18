-- local progress_notifications = {}
--
-- -- Custom completion icons
local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

-- Apply icons to completion kinds
local completion_kinds = vim.lsp.protocol.CompletionItemKind

for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

-- Delete default LSP keybinds
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
  pcall(vim.keymap.del, "n", bind)
end

vim.api.nvim_create_user_command("LspLog", function() vim.cmd.vsplit(vim.lsp.log.get_filename()) end, {
  desc = "Open LSP log in vertical split",
})

vim.api.nvim_create_user_command("LspInfo", function() vim.cmd("checkhealth vim.lsp") end, {
  desc = "Show LSP client information",
})

-- vim.api.nvim_create_autocmd("LspProgress", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     local value = args.data.params.value
--
--     if not client or type(value) ~= "table" then
--       return
--     end
--
--     local message = value.message or ""
--     local title = value.title or ""
--     local percentage = value.percentage or 0
--     local token = args.data.params.token
--
--     -- Create a unique key for this progress sequence
--     local progress_key = string.format("%s-%s", client.name, token or title)
--
--     if value.kind == "begin" then
--       progress_notifications[progress_key] = vim.notify(string.format("%s: %s", title, message), vim.log.levels.INFO, {
--         title = string.format("%s Loading", client.name),
--         icon = "󰔟",
--         timeout = 30000, -- 30 second timeout as fallback
--       })
--     elseif value.kind == "report" then
--       local percent_str = percentage > 0 and string.format(" (%d%%)", percentage) or ""
--       local existing_notification = progress_notifications[progress_key]
--
--       -- Only attempt replacement if we have a valid existing notification
--       local notify_opts = {
--         title = string.format("%s Loading", client.name),
--         icon = "󰦖",
--       }
--
--       if existing_notification then
--         notify_opts.replace = existing_notification
--       end
--
--       progress_notifications[progress_key] =
--         vim.notify(string.format("%s: %s%s", title, message, percent_str), vim.log.levels.INFO, notify_opts)
--     elseif value.kind == "end" then
--       local existing_notification = progress_notifications[progress_key]
--
--       local notify_opts = {
--         title = string.format("%s Ready", client.name),
--         icon = "󰄬",
--         timeout = 2000, -- Auto-dismiss after 2s
--       }
--
--       if existing_notification then
--         notify_opts.replace = existing_notification
--       end
--
--       vim.notify(string.format("%s complete", title), vim.log.levels.INFO, notify_opts)
--
--       -- Clean up the stored notification
--       progress_notifications[progress_key] = nil
--     end
--   end,
-- })

-- Diagnostic configuration with custom signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  virtual_lines = {
    current_line = true,
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  -- float = {
  --   focusable = false,
  --   style = "minimal",
  --   border = "single",
  --   source = "if_many",
  --   header = "",
  --   prefix = "",
  --   suffix = "",
  -- },
})

-- LSP Attach autocmd with keymaps and completion
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     local bufnr = args.buf
--
--     if not client then
--       return
--     end
--
--     -- Keymap helper
--     local function map(mode, lhs, rhs, desc)
--       vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
--     end
--
--     -- === NAVIGATION & INSPECTION ===
--     map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
--     map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
--     map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
--     map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
--     map("n", "gr", vim.lsp.buf.references, "Find References")
--     map("n", "K", vim.lsp.buf.hover, "Show Hover Documentation")
--     map("n", "gK", vim.lsp.buf.signature_help, "Show Signature Help")
--     map("i", "<C-k>", vim.lsp.buf.signature_help, "Show Signature Help (Insert)")
--
--     -- === CODE ACTIONS & REFACTORING ===
--     map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
--     map("v", "<leader>ca", vim.lsp.buf.code_action, "Code Actions (Visual)")
--     map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
--     map("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Format Document")
--     map("v", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Format Selection")
--
--     -- === WORKSPACE MANAGEMENT ===
--     map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
--     map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
--     map(
--       "n",
--       "<leader>wl",
--       function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
--       "List Workspace Folders"
--     )
--
--     -- === SYMBOL & DOCUMENT NAVIGATION ===
--     map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
--     map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
--
--     -- === ADVANCED FEATURES ===
--     map("n", "<leader>cl", vim.lsp.codelens.run, "Run Code Lens")
--     map("n", "<leader>th", function() vim.lsp.typehierarchy("subtypes") end, "Type Hierarchy (Subtypes)")
--     map("n", "<leader>TH", function() vim.lsp.typehierarchy("supertypes") end, "Type Hierarchy (Supertypes)")
--     map("n", "<leader>ch", function() vim.lsp.buf.call_hierarchy("incoming") end, "Call Hierarchy (Incoming)")
--     map("n", "<leader>CH", function() vim.lsp.buf.call_hierarchy("outgoing") end, "Call Hierarchy (Outgoing)")
--
--     -- === DIAGNOSTICS ===
--     map("n", "<leader>e", vim.diagnostic.open_float, "Show Line Diagnostics")
--     map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")
--     map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
--     map(
--       "n",
--       "[D",
--       function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
--       "Previous Error"
--     )
--     map(
--       "n",
--       "]D",
--       function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true }) end,
--       "Next Error"
--     )
--     map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics to Location List")
--     map("n", "<leader>dq", vim.diagnostic.setqflist, "Diagnostics to Quickfix")
--     map("n", "<leader>dv", function()
--       local current_config = vim.diagnostic.config() or {}
--       local virtual_lines_enabled = current_config.virtual_lines or false
--
--       if virtual_lines_enabled then
--         vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
--         -- vim.notify("Virtual lines hidden", vim.log.levels.INFO, {
--         --   title = "Diagnostics",
--         --   icon = "󰌶",
--         -- })
--       else
--         vim.diagnostic.config({ virtual_lines = true, virtual_text = true })
--         -- vim.notify("Virtual lines shown", vim.log.levels.INFO, {
--         --   title = "Diagnostics",
--         --   icon = "󰌷",
--         -- })
--       end
--     end, "Toggle Virtual Lines")
--     map("n", "<leader>dy", function()
--       local diagnostics = vim.diagnostic.get(bufnr)
--       if #diagnostics == 0 then
--         vim.notify("No diagnostics in current buffer", vim.log.levels.INFO, { title = "Copy Diagnostics" })
--         return
--       end
--
--       local lines = {}
--       for _, diagnostic in ipairs(diagnostics) do
--         local severity = vim.diagnostic.severity[diagnostic.severity] or "UNKNOWN"
--         local line =
--           string.format("[%s:%d] %s: %s", severity, diagnostic.lnum + 1, diagnostic.source or "LSP", diagnostic.message)
--         table.insert(lines, line)
--       end
--
--       local text = table.concat(lines, "\n")
--       vim.fn.setreg("+", text)
--       vim.notify(
--         string.format("Copied %d diagnostic%s to clipboard", #diagnostics, #diagnostics == 1 and "" or "s"),
--         vim.log.levels.INFO,
--         { title = "Copy Diagnostics", icon = "󰅇" }
--       )
--     end, "Copy All Diagnostics to Clipboard")
--
--     -- === SYSTEM CLIPBOARD ===
--     map({ "n", "v" }, "<leader>y", '"+y', "Copy to System Clipboard")
--     map("n", "<leader>Y", '"+Y', "Copy Line to System Clipboard")
--     map({ "n", "v" }, "<leader>p", '"+p', "Paste from System Clipboard")
--     map({ "n", "v" }, "<leader>P", '"+P', "Paste Before from System Clipboard")
--
--     -- === INLAY HINTS ===
--     -- if vim.lsp.inlay_hint then
--     --   map(
--     --     "n",
--     --     "<leader>ih",
--     --     function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }) end,
--     --     "Toggle Inlay Hints"
--     --   )
--     -- end
--
--     -- Print confirmation
--     -- vim.notify(
--     --   string.format("LSP attached: %s (client_id: %d, buffer: %d)", client.name, client.id, bufnr),
--     --   vim.log.levels.INFO,
--     --   { title = "LSP", icon = "󰒋" }
--     -- )
--   end,
-- })

-- vim.lsp.enable("biome")
-- vim.lsp.enable("go")
-- vim.lsp.enable("just")
-- vim.lsp.enable("lua")
-- vim.lsp.enable("prisma")
-- vim.lsp.enable("python")
-- vim.lsp.enable("rust")
-- vim.lsp.enable("tailwindcss")
-- vim.lsp.enable("typescript")
-- vim.lsp.enable("yaml")
