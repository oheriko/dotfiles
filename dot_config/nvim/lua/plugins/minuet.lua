return {
  "milanglacier/minuet-ai.nvim",
  enabled = true,
  event = "BufReadPre",
  opts = {
    provider = "gemini",
    notify = "error",
    n_completions = 1,
    add_single_line_entry = false,
    -- lsp = {
    --   enabled_ft = { "toml", "lua", "json", "jsonc", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    --   -- Enables automatic completion triggering using `vim.lsp.completion.enable`
    --   enabled_auto_trigger_ft = {
    --     "toml",
    --     "lua",
    --     "json",
    --     "jsonc",
    --     "javascript",
    --     "javascriptreact",
    --     "typescript",
    --     "typescriptreact",
    --   },
    -- },
    virtualtext = {
      auto_trigger_ft = {
        "cpp",
        "rust",
        "go",
        "python",
        "toml",
        "lua",
        "json",
        "jsonc",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
      keymap = {
        -- accept whole completion
        accept = "<Tab>",
        -- accept one line
        accept_line = "<A-a>",
        -- accept n lines (prompts for number)
        accept_n_lines = "<A-z>",
        -- Cycle to prev completion item, or manually invoke completion
        prev = "<A-[>",
        -- Cycle to next completion item, or manually invoke completion
        next = "<A-]>",
        dismiss = "<A-e>",
      },
    },
    provider_options = {
      gemini = {
        model = "gemini-2.5-flash",
        stream = true,
        optional = {
          generationConfig = {
            maxOutputTokens = 256,
            -- When using `gemini-2.5-flash`, it is recommended to entirely
            -- disable thinking for faster completion retrieval.
            thinkingConfig = {
              thinkingBudget = 0,
            },
          },
          safetySettings = {
            {
              -- HARM_CATEGORY_HATE_SPEECH,
              -- HARM_CATEGORY_HARASSMENT
              -- HARM_CATEGORY_SEXUALLY_EXPLICIT
              category = "HARM_CATEGORY_DANGEROUS_CONTENT",
              -- BLOCK_NONE
              threshold = "BLOCK_ONLY_HIGH",
            },
          },
        },
      },
    },
  },
}
