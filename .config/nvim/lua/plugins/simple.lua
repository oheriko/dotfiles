-- lua/plugins/simple.lua
-- Simple plugin configurations (one-liners and basic setups)

local utils = require("config.utils")

-- ============================================================================
-- TOKYONIGHT THEME
-- ============================================================================

local tokyonight = utils.safe_require("tokyonight")
if tokyonight then
  tokyonight.setup({
    style = "night",
    transparent = false,
    terminal_colors = true,
  })
  vim.cmd([[colorscheme tokyonight-night]])
end

-- ============================================================================
-- FIDGET (LSP Progress)
-- ============================================================================

local fidget = utils.safe_require("fidget")
if fidget then
  fidget.setup({})
end

-- ============================================================================
-- LUALINE (Statusline)
-- ============================================================================

local lualine = utils.safe_require("lualine")
if lualine then
  lualine.setup()
end

-- ============================================================================
-- RENDER MARKDOWN
-- ============================================================================

local markdown = utils.safe_require("render-markdown")
if markdown then
  markdown.setup({
    completions = { lsp = { enabled = true } },
    file_types = { "markdown", "Avante" },
  })
end

-- ============================================================================
-- IMG-CLIP
-- ============================================================================

local imgclip = utils.safe_require("img-clip")
if imgclip then
  imgclip.setup({
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
  })

  vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", {
    desc = "Paste image from system clipboard",
  })
end
