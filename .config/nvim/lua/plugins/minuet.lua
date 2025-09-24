local minuet = require("minuet")

local fts = {
  "go",
  "lua",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "python",
  "rust",
}

minuet.setup({
  provider = "openai_fim_compatible",
  provider_options = {
    openai_fim_compatible = {
      api_key = "TERM",
      name = "Ollama",
      end_point = "http://localhost:11434/v1/completions",
      model = "qwen2.5-coder:7b",
      optional = {
        max_tokens = 64,
        top_p = 0.9,
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = fts,
    keymap = {
      accept = "<A-A>",
      accept_line = "<A-a>",
      accept_n_lines = "<A-z>",
      prev = "<A-[>",
      next = "<A-]>",
      dismiss = "<A-e>",
    },
  },
})
