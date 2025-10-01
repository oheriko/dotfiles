-- lua/plugins/init.lua
-- Plugin configuration loader

local utils = require("config.utils")

-- ============================================================================
-- THEME & UI
-- ============================================================================

require("plugins.simple") -- tokyonight, fidget, lualine, render-markdown, img-clip

-- ============================================================================
-- TREESITTER & SYNTAX
-- ============================================================================

require("plugins.treesitter")

-- ============================================================================
-- FILE NAVIGATION
-- ============================================================================

require("plugins.fzf")
require("plugins.yazi")

-- ============================================================================
-- FORMATTING & DIAGNOSTICS
-- ============================================================================

require("plugins.conform")
require("plugins.trouble")

-- ============================================================================
-- COMPLETION
-- ============================================================================

-- Note: Blink is loaded before AI plugins so they can integrate with it
require("plugins.blink")

-- ============================================================================
-- AI ASSISTANTS
-- ============================================================================

-- MCP Hub must be loaded first as other AI tools depend on it
require("plugins.mcphub")

-- AI completion and chat
require("plugins.minuet")
require("plugins.codecompanion")
require("plugins.avante")
