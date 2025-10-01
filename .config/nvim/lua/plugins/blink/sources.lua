-- lua/plugins/blink/sources.lua
-- Blink.cmp source configuration

-- Filetypes where AI completion is enabled
local ai_completion_fts = {
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
}

return {
  default = { "lsp", "path", "snippets", "buffer", "minuet" },

  -- Special completion for specific buffer types
  per_filetype = {
    codecompanion = { "codecompanion", "buffer" },
    markdown = { "buffer", "path", "snippets", "minuet" },
    gitcommit = { "buffer", "minuet" },
  },

  providers = {
    -- LSP completions (highest priority)
    lsp = {
      name = "LSP",
      module = "blink.cmp.sources.lsp",
      enabled = true,
      score_offset = 90,
    },

    -- File path completions
    path = {
      name = "Path",
      module = "blink.cmp.sources.path",
      score_offset = 3,
      opts = {
        trailing_slash = false,
        label_trailing_slash = true,
        get_cwd = function(context)
          return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
        end,
        show_hidden_files_by_default = true,
      },
    },

    -- Snippet completions
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

    -- Buffer word completions
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
        return vim.tbl_contains(ai_completion_fts, ft)
      end,
    },
  },
}
