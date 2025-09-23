local minuet = require("minuet")

minuet.setup({
  cmp = {
    enable_auto_complete = false,
  },
  blink = {
    enable_auto_complete = false,
  },
  lsp = {
    enabled_ft = {
      "go",
      "lua",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "python",
      "rust",
    },
    enabled_auto_trigger_ft = {
      "go",
      "lua",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "python",
      "rust",
    },
    -- warn_on_blink_or_cmp = true,
    -- adjust_indentation = true,
  },
  virtualtext = {
    auto_trigger_ft = {
      "go",
      "lua",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "python",
      "rust",
    },
    keymap = {
      accept = "<A-A>",
      accept_line = "<A-a>",
      accept_n_lines = "<A-z>",
      prev = "<A-[>",
      next = "<A-]>",
      dismiss = "<A-e>",
    },
  },
  provider = "openai_fim_compatible",
  n_completions = 1,
  context_window = 512,
  provider_options = {
    openai_fim_compatible = {
      api_key = "TERM",
      name = "Ollama",
      end_point = "http://localhost:11434/v1/completions",
      model = "codegemma:7b-code",
      -- optional = {
      --   max_tokens = 56,
      --   top_p = 0.9,
      -- },
    },
  },
})
