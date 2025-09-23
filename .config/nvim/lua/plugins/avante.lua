local avante = require("avante")

avante.setup({
  input = {
    provider = "native",
  },
  selector = {
    provider = "fzf",
    provider_opts = {},
  },
  provider = "ollama",
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "gpt-oss:120b",
    },
  },
})
