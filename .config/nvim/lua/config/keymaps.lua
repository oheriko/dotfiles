-- lua/config/keymaps.lua
-- Centralized keymap configuration

local map = require("config.utils").map

-- ============================================================================
-- CORE EDITOR
-- ============================================================================

-- Clear search highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', "Copy to system clipboard")
map({ "n", "v" }, "<leader>p", '"+p', "Paste from system clipboard")

-- Better scrolling (center cursor)
map("n", "<C-d>", "<C-d>zz", "Half page down and center")
map("n", "<C-u>", "<C-u>zz", "Half page up and center")
map("n", "n", "nzzzv", "Next search result and center")
map("n", "N", "Nzzzv", "Previous search result and center")

-- ============================================================================
-- LSP (set in autocmd, listed here for reference)
-- ============================================================================
-- These are set in config/autocmds.lua on LspAttach:
-- gD - Go to Declaration
-- gd - Go to Definition
-- gk - LSP Hover
-- gi - Go to Implementation
-- gr - Symbol References
-- gt - Go to Type Definition
-- ga - Code Action
-- gn - Rename Symbol
-- gh - Signature Help
-- <C-h> - Signature Help (Insert)
-- gl - Open Diagnostic Float
-- gf - Format Buffer
-- gS - Workspace Symbols
-- gs - Document Symbols
-- [d/]d - Previous/Next Diagnostic
-- [e/]e - Previous/Next Error
-- [D/]D - First/Last Diagnostic

-- ============================================================================
-- PLUGIN KEYMAPS
-- ============================================================================
-- These are organized by plugin for clarity.
-- Actual implementations are in their respective plugin config files.

--[[
FZF-lua:
  <leader>ff - Find files (home)
  <leader>fd - Find files (cwd)
  <leader>fg - Find git files
  <leader>fo - Find recent files
  <leader>fb - Find buffers
  <leader>fr - Resume last search
  <leader>rg - Live grep
  <leader>rG - Grep prompt
  <leader>rw - Grep word under cursor
  <leader>gs - Git status
  <leader>gc - Git commits
  <leader>lr - LSP references
  <leader>ld - LSP definitions

Yazi:
  <leader>- - Open yazi at current file
  <leader>cw - Open yazi at cwd

Trouble:
  <leader>xx - Toggle diagnostics
  <leader>xb - Buffer diagnostics
  <leader>xq - Quickfix list
  <leader>xl - Location list
  ]t/[t - Next/Previous trouble item

MCP Hub:
  <leader>mh - Open MCP Hub
  <leader>mr - Restart MCP server
  <leader>ml - View MCP logs
  <leader>mi - Install MCP deps
  <leader>ms - MCP server actions

Avante:
  <leader>aa - Ask AI
  <leader>ac - Open chat
  <leader>ae - Edit selection
  <leader>at - Toggle sidebar
  <leader>af - Focus sidebar
  <leader>a+ - Add current file
  <leader>a- - Remove current file
  <leader>aA - Add all buffers
  <leader>ah - Chat history
  <leader>an - New chat
  <leader>ax - Clear chat
  <leader>ap - Switch provider
  <leader>apc - Use Claude
  <leader>apo - Use Ollama
  <leader>as - Stop generation

CodeCompanion:
  <leader>ca - Actions
  <leader>ct - Toggle chat
  <leader>c+ - Add to chat
  <leader>ci - Inline completion

Minuet:
  <A-l> - Accept completion
  <A-a> - Accept line
  <A-z> - Accept n lines
  <A-[> - Previous suggestion
  <A-]> - Next suggestion
  <A-e> - Dismiss suggestion
  <leader>mg - Switch to Gemini
  <leader>mo - Switch to Ollama

Blink.cmp:
  <C-space> - Show/hide completion
  <C-e> - Hide completion
  <CR> - Accept completion
  <Tab> - Next completion / snippet forward
  <S-Tab> - Previous completion / snippet backward
  <C-b> - Scroll docs up
  <C-f> - Scroll docs down
  <leader>tg - Toggle ghost text
  <leader>td - Toggle doc auto-show
  <leader>br - Reload blink.cmp

Image Clip:
  <leader>p - Paste image from clipboard
]]--
