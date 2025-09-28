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
  provider = "gemini",
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
    gemini = {
      model = "gemini-2.5-flash-lite",
      stream = true,
      -- api_key = "GEMINI_API_KEY",
      -- end_point = "https://generativelanguage.googleapis.com/v1beta/models",
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
