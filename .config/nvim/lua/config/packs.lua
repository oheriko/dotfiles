vim.pack.add({
  {
    name = "devicons",
    src = "https://github.com/nvim-tree/nvim-web-devicons",
    version = "master",
  },
  {
    name = "plenary",
    src = "https://github.com/nvim-lua/plenary.nvim",
    version = "master",
  },
  {
    name = "nui",
    src = "https://github.com/MunifTanjim/nui.nvim",
    version = "main",
  },
  {
    name = "tokyonight",
    src = "https://github.com/folke/tokyonight.nvim",
    version = "main",
  },
  {
    name = "treesitter",
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
    name = "lualine",
    src = "https://github.com/nvim-lualine/lualine.nvim",
    version = "master",
  },
  {
    name = "fidget",
    src = "https://github.com/j-hui/fidget.nvim",
    version = "main",
  },
  {
    name = "trouble",
    src = "https://github.com/folke/trouble.nvim",
    version = "main",
  },
  {
    name = "rendermarkdown",
    src = "https://github.com/meanderingprogrammer/render-markdown.nvim",
    version = "main",
  },
  {
    name = "fzf",
    src = "https://github.com/ibhagwan/fzf-lua",
    version = "main",
  },
  {
    name = "yazi",
    src = "https://github.com/mikavilpas/yazi.nvim",
    version = "main",
  },
  {
    name = "conform",
    src = "https://github.com/stevearc/conform.nvim",
    version = "master",
  },
  {
    name = "img-clip.nvim",
    src = "https://github.com/HakonHarnes/img-clip.nvim",
    version = "main",
  },
  {
    name = "mcphub.nvim",
    src = "https://github.com/ravitemer/mcphub.nvim",
    version = "main",
  },
  {
    name = "avante",
    src = "https://github.com/yetone/avante.nvim",
    version = "main",
    hooks = {
      post_checkout = function(plugin)
        vim.fn.system({
          "sh",
          "-c",
          string.format("cd %s && %s", plugin.dir, "make"),
        })
      end,
    },
  },

  {
    name = "codecompanion.nvim",
    src = "https://github.com/olimorris/codecompanion.nvim",
    version = "main",
  },
  {
    name = "minuet",
    src = "https://github.com/milanglacier/minuet-ai.nvim",
    version = "main",
  },
})
