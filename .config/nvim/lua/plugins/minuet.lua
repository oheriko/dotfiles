local minuet = require("minuet")

-- Filetypes where AI completion is enabled
local completion_fts = {
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
  "zsh",
  "c",
  "cpp",
  "java",
  "json",
  "yaml",
  "toml",
  "markdown",
}

minuet.setup({
  provider = "gemini",
  provider_options = {
    -- Gemini configuration (primary provider)
    gemini = {
      model = "gemini-2.5-flash-lite",
      stream = true,
      optional = {
        generationConfig = {
          maxOutputTokens = 256,
          -- Disable thinking for faster completions
          thinkingConfig = {
            thinkingBudget = 0,
          },
        },
        safetySettings = {
          {
            category = "HARM_CATEGORY_DANGEROUS_CONTENT",
            threshold = "BLOCK_ONLY_HIGH",
          },
        },
      },
    },
    -- Ollama configuration (local alternative)
    openai_fim_compatible = {
      api_key = "TERM",
      name = "Ollama",
      end_point = "http://localhost:11434/v1/completions",
      model = "qwen2.5-coder:7b",
      optional = {
        max_tokens = 256,
        top_p = 0.9,
        temperature = 0.2,
        stop = { "\n\n" },
      },
    },
  },
  -- Virtual text completion settings
  virtualtext = {
    auto_trigger_ft = completion_fts,
    keymap = {
      accept = "<A-l>", -- Accept full completion
      accept_line = "<A-a>", -- Accept single line
      accept_n_lines = "<A-z>", -- Accept N lines (prompts for number)
      prev = "<A-[>", -- Previous suggestion
      next = "<A-]>", -- Next suggestion
      dismiss = "<A-e>", -- Dismiss suggestion
    },
  },
  -- Completion behavior settings
  n_completions = 3, -- Generate 3 completions to cycle through
  debounce = 400, -- Wait 400ms after typing before requesting completion
  throttle = 1000, -- Only send request every 1000ms
})

-- Provider switching keymaps
vim.keymap.set("n", "<leader>mg", function()
  require("minuet.config").config.provider = "gemini"
  vim.notify("Minuet: Switched to Gemini", vim.log.levels.INFO)
end, { desc = "Minuet: Use Gemini" })

vim.keymap.set("n", "<leader>mo", function()
  require("minuet.config").config.provider = "openai_fim_compatible"
  vim.notify("Minuet: Switched to Ollama", vim.log.levels.INFO)
end, { desc = "Minuet: Use Ollama" })
