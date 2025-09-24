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
  provider = "ollama",
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
  },
})
