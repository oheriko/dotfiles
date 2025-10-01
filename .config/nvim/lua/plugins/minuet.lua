-- lua/plugins/minuet.lua
-- Minuet AI completion configuration

local utils = require("config.utils")
local map = utils.map
local notify = utils.notify

-- Get Minuet plugin
local minuet = utils.safe_require("minuet")
if not minuet then
  return
end

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

-- Get Ollama endpoint from env or use default
local function get_ollama_endpoint()
  local endpoint = vim.fn.getenv("OLLAMA_ENDPOINT")
  if endpoint == vim.NIL or endpoint == "" then
    return "http://localhost:11434"
  end
  return tostring(endpoint)
end

-- Setup Minuet
minuet.setup({
  provider = "gemini",

  provider_options = {
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
    openai_fim_compatible = {
      api_key = "TERM",
      name = "Ollama",
      end_point = get_ollama_endpoint() .. "/v1/completions",
      model = "qwen2.5-coder:7b",
      optional = {
        max_tokens = 256,
        top_p = 0.9,
        temperature = 0.2,
        stop = { "\n\n" },
      },
    },
  },

  virtualtext = {
    auto_trigger_ft = completion_fts,
    keymap = {
      accept = "<A-l>",
      accept_line = "<A-a>",
      accept_n_lines = "<A-z>",
      prev = "<A-[>",
      next = "<A-]>",
      dismiss = "<A-e>",
    },
  },

  n_completions = 3,
  debounce = 400,
  throttle = 1000,
})

-- ============================================================================
-- PROVIDER SWITCHING
-- ============================================================================

map("n", "<leader>mg", function()
  require("minuet.config").config.provider = "gemini"
  notify("Minuet: Switched to Gemini")
end, "Minuet: Use Gemini")

map("n", "<leader>mo", function()
  require("minuet.config").config.provider = "openai_fim_compatible"
  notify("Minuet: Switched to Ollama")
end, "Minuet: Use Ollama")
