local avante = require("avante")

avante.setup({
  mode = "legacy",
  input = {
    provider = "native",
  },
  selector = {
    provider = "fzf_lua",
    provider_opts = {},
  },
  provider = "claude",
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "gpt-oss:20b",
      extra_request_body = {
        options = {
          temperature = 0.1,
          num_ctx = 16384,
        },
      },
    },
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-20250514",
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
  },
})
