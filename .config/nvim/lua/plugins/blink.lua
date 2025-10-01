-- Skip Rust build and use Lua implementation
-- The Lua implementation is fast enough and works out of the box
local blink = require("blink.cmp")

blink.setup({
  -- Appearance and behavior
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  -- Completion sources with Minuet integration
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "minuet" },
    -- CodeCompanion chat buffer gets special completion
    per_filetype = {
      codecompanion = { "codecompanion", "buffer" },
      -- Markdown gets more buffer completion
      markdown = { "buffer", "path", "snippets", "minuet" },
      -- Git commit messages
      gitcommit = { "buffer", "minuet" },
    },
    providers = {
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        enabled = true,
        score_offset = 90, -- Prioritize LSP completions
      },
      path = {
        name = "Path",
        module = "blink.cmp.sources.path",
        score_offset = 3,
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function(context) return vim.fn.expand(("#%d:p:h"):format(context.bufnr)) end,
          show_hidden_files_by_default = true,
        },
      },
      snippets = {
        name = "Snippets",
        module = "blink.cmp.sources.snippets",
        score_offset = 80,
        opts = {
          friendly_snippets = true,
          search_paths = { vim.fn.stdpath("config") .. "/snippets" },
          global_snippets = { "all" },
          extended_filetypes = {},
          ignored_filetypes = {},
        },
      },
      buffer = {
        name = "Buffer",
        module = "blink.cmp.sources.buffer",
        score_offset = 5,
        opts = {
          -- Get words from all visible buffers
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype ~= "nofile" then
                bufs[buf] = true
              end
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
      -- Minuet AI completion integration
      minuet = {
        name = "Minuet",
        module = "minuet.blink",
        score_offset = 8, -- Between buffer and path
        enabled = function()
          -- Only enable in specific filetypes
          local ft = vim.bo.filetype
          return vim.tbl_contains({
            "go",
            "lua",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "python",
            "rust",
            "sh",
            "bash",
            "c",
            "cpp",
            "java",
            "json",
            "yaml",
            "toml",
            "markdown",
          }, ft)
        end,
      },
    },
  },

  -- Signature help
  signature = {
    enabled = true,
    trigger = {
      blocked_trigger_characters = {},
      blocked_retrigger_characters = {},
      show_on_insert_on_trigger_character = true,
    },
    window = {
      min_width = 1,
      max_width = 100,
      max_height = 10,
      border = "rounded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      scrollbar = false,
      direction_priority = { "n", "s" },
    },
  },

  -- Completion window
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    trigger = {
      show_on_insert_on_trigger_character = true,
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    menu = {
      min_width = 15,
      max_height = 10,
      border = "rounded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 2,
      scrollbar = true,
      direction_priority = { "s", "n" },
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind", "source_name" },
        },
        components = {
          kind_icon = {
            text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
          source_name = {
            width = { max = 30 },
            text = function(ctx) return "[" .. ctx.source_name .. "]" end,
            highlight = "BlinkCmpSource",
          },
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx) return ctx.label .. ctx.label_detail end,
            highlight = function(ctx)
              local highlights = {
                { 0, #ctx.label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
              }
              if ctx.label_detail then
                table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" })
              end
              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
              end
              return highlights
            end,
          },
          kind = {
            width = { max = 10 },
            text = function(ctx) return ctx.kind end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      treesitter_highlighting = true,
      window = {
        min_width = 10,
        max_width = 80,
        max_height = 20,
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        scrollbar = true,
        direction_priority = {
          menu_north = { "e", "w", "n", "s" },
          menu_south = { "e", "w", "s", "n" },
        },
      },
    },
    ghost_text = {
      enabled = true,
    },
  },

  -- Fuzzy matching
  fuzzy = {
    use_typo_resistance = true,
    use_proximity = true,
    sorts = { "score", "sort_text" },
    -- Frecency for smarter sorting based on usage
    frecency = {
      enabled = true,
    },
    -- Explicitly use Lua implementation (no Rust/binary needed)
    implementation = "lua",
  },

  -- Keymaps
  keymap = {
    preset = "default",

    -- Show/hide completion
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },

    -- Accept completion
    ["<CR>"] = { "accept", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },

    -- Navigate completion menu
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    -- Scroll documentation
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    -- Navigate snippets
  },

  -- Cmdline completion
  cmdline = {
    enabled = true,
    keymap = {
      preset = "default",
    },
  },
})

-- ============================================================================
-- AVANTE INTEGRATION
-- ============================================================================
-- Make sure Avante suggestions don't interfere with blink.cmp
vim.api.nvim_create_autocmd("FileType", {
  pattern = "AvanteInput",
  callback = function()
    require("blink.cmp").setup({
      enabled = function() return vim.bo.buftype ~= "prompt" end,
    })
  end,
})

-- ============================================================================
-- KEYMAPS & UTILITIES
-- ============================================================================

-- Toggle ghost text on/off
vim.keymap.set("n", "<leader>tg", function()
  local config = require("blink.cmp.config")
  config.completion.ghost_text.enabled = not config.completion.ghost_text.enabled
  vim.notify("Ghost text " .. (config.completion.ghost_text.enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end, { desc = "Toggle completion ghost text" })

-- Toggle documentation auto-show
vim.keymap.set("n", "<leader>td", function()
  local config = require("blink.cmp.config")
  config.completion.documentation.auto_show = not config.completion.documentation.auto_show
  vim.notify(
    "Documentation auto-show " .. (config.completion.documentation.auto_show and "enabled" or "disabled"),
    vim.log.levels.INFO
  )
end, { desc = "Toggle documentation auto-show" })

-- Force reload blink.cmp
vim.keymap.set("n", "<leader>br", function()
  vim.cmd("Lazy reload blink.cmp")
  vim.notify("Reloaded blink.cmp", vim.log.levels.INFO)
end, { desc = "Reload blink.cmp" })
