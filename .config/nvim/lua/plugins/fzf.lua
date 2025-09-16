local fzf = require("fzf-lua")

fzf.setup()

local keymap = vim.keymap.set

keymap("n", "<leader>ff", function() fzf.files({ cwd = "~" }) end, { desc = "Find files" })
keymap("n", "<leader>fd", fzf.files, { desc = "Find files in current directory" })
keymap("n", "<leader>fg", fzf.git_files, { desc = "Find git files" })
keymap("n", "<leader>fo", fzf.oldfiles, { desc = "Find recent files" })
keymap("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
keymap("n", "<leader>fr", fzf.resume, { desc = "Resume last search" })

keymap("n", "<leader>rg", fzf.live_grep, { desc = "Live grep" })
keymap("n", "<leader>rG", fzf.grep, { desc = "Grep prompt" })
keymap("n", "<leader>rw", fzf.grep_cword, { desc = "Grep word under cursor" })
keymap("n", "<leader>rW", fzf.grep_cWORD, { desc = "Grep WORD under cursor" })
keymap("v", "<leader>rg", fzf.grep_visual, { desc = "Grep visual selection" })

keymap("n", "<leader>gs", fzf.git_status, { desc = "Git status" })
keymap("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
keymap("n", "<leader>gC", fzf.git_bcommits, { desc = "Git buffer commits" })
keymap("n", "<leader>gb", fzf.git_branches, { desc = "Git branches" })

keymap("n", "<leader>lr", fzf.lsp_references, { desc = "LSP references" })
keymap("n", "<leader>ld", fzf.lsp_definitions, { desc = "LSP definitions" })
keymap("n", "<leader>lD", fzf.lsp_declarations, { desc = "LSP declarations" })
keymap("n", "<leader>li", fzf.lsp_implementations, { desc = "LSP implementations" })
keymap("n", "<leader>lt", fzf.lsp_typedefs, { desc = "LSP type definitions" })
keymap("n", "<leader>ls", fzf.lsp_document_symbols, { desc = "LSP document symbols" })
keymap("n", "<leader>lS", fzf.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
keymap("n", "<leader>la", fzf.lsp_code_actions, { desc = "LSP code actions" })
keymap("n", "<leader>le", fzf.diagnostics_document, { desc = "Document diagnostics" })
keymap("n", "<leader>lE", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })

keymap("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
keymap("n", "<leader>fm", fzf.man_pages, { desc = "Man pages" })
keymap("n", "<leader>fk", fzf.keymaps, { desc = "Key mappings" })
keymap("n", "<leader>fc", fzf.commands, { desc = "Commands" })
keymap("n", "<leader>fC", fzf.command_history, { desc = "Command history" })
keymap("n", "<leader>f:", fzf.search_history, { desc = "Search history" })
keymap("n", "<leader>fq", fzf.quickfix, { desc = "Quickfix list" })
keymap("n", "<leader>fl", fzf.loclist, { desc = "Location list" })
keymap("n", "<leader>fj", fzf.jumps, { desc = "Jumps" })
keymap("n", "<leader>ft", fzf.tabs, { desc = "Tabs" })

if fzf.ui_select then
  vim.ui.select = fzf.ui_select
end

vim.api.nvim_create_user_command("Files", fzf.files, {})
vim.api.nvim_create_user_command("Rg", fzf.live_grep, {})
vim.api.nvim_create_user_command("Buffers", fzf.buffers, {})
