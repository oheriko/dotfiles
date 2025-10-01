-- lua/plugins/fzf.lua
-- FZF-lua configuration

local utils = require("config.utils")
local map = utils.map

-- Get FZF plugin
local fzf = utils.safe_require("fzf-lua")
if not fzf then
  return
end

-- Setup FZF
fzf.setup()

-- ============================================================================
-- FILE FINDING
-- ============================================================================

map("n", "<leader>ff", function()
  fzf.files({ cwd = "~" })
end, "Find files (home)")
map("n", "<leader>fd", fzf.files, "Find files (cwd)")
map("n", "<leader>fg", fzf.git_files, "Find git files")
map("n", "<leader>fo", fzf.oldfiles, "Find recent files")
map("n", "<leader>fb", fzf.buffers, "Find buffers")
map("n", "<leader>fr", fzf.resume, "Resume last search")

-- ============================================================================
-- TEXT SEARCH
-- ============================================================================

map("n", "<leader>rg", fzf.live_grep, "Live grep")
map("n", "<leader>rG", fzf.grep, "Grep prompt")
map("n", "<leader>rw", fzf.grep_cword, "Grep word under cursor")
map("n", "<leader>rW", fzf.grep_cWORD, "Grep WORD under cursor")
map("v", "<leader>rg", fzf.grep_visual, "Grep visual selection")

-- ============================================================================
-- GIT
-- ============================================================================

map("n", "<leader>gs", fzf.git_status, "Git status")
map("n", "<leader>gc", fzf.git_commits, "Git commits")
map("n", "<leader>gC", fzf.git_bcommits, "Git buffer commits")
map("n", "<leader>gb", fzf.git_branches, "Git branches")

-- ============================================================================
-- LSP
-- ============================================================================

map("n", "<leader>lr", fzf.lsp_references, "LSP references")
map("n", "<leader>ld", fzf.lsp_definitions, "LSP definitions")
map("n", "<leader>lD", fzf.lsp_declarations, "LSP declarations")
map("n", "<leader>li", fzf.lsp_implementations, "LSP implementations")
map("n", "<leader>lt", fzf.lsp_typedefs, "LSP type definitions")
map("n", "<leader>ls", fzf.lsp_document_symbols, "LSP document symbols")
map("n", "<leader>lS", fzf.lsp_workspace_symbols, "LSP workspace symbols")
map("n", "<leader>la", fzf.lsp_code_actions, "LSP code actions")
map("n", "<leader>le", fzf.diagnostics_document, "Document diagnostics")
map("n", "<leader>lE", fzf.diagnostics_workspace, "Workspace diagnostics")

-- ============================================================================
-- MISC
-- ============================================================================

map("n", "<leader>fh", fzf.help_tags, "Help tags")
map("n", "<leader>fm", fzf.man_pages, "Man pages")
map("n", "<leader>fk", fzf.keymaps, "Key mappings")
map("n", "<leader>fc", fzf.commands, "Commands")
map("n", "<leader>fC", fzf.command_history, "Command history")
map("n", "<leader>f:", fzf.search_history, "Search history")
map("n", "<leader>fq", fzf.quickfix, "Quickfix list")
map("n", "<leader>fl", fzf.loclist, "Location list")
map("n", "<leader>fj", fzf.jumps, "Jumps")
map("n", "<leader>ft", fzf.tabs, "Tabs")

-- ============================================================================
-- UI SELECT INTEGRATION
-- ============================================================================

if fzf.ui_select then
  vim.ui.select = fzf.ui_select
end

-- ============================================================================
-- CUSTOM COMMANDS
-- ============================================================================

vim.api.nvim_create_user_command("Files", fzf.files, {})
vim.api.nvim_create_user_command("Rg", fzf.live_grep, {})
vim.api.nvim_create_user_command("Buffers", fzf.buffers, {})
