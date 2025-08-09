return {
  "folke/trouble.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("trouble.sources.fzf").actions
    -- local trouble = require("trouble")
    -- local symbols = trouble.statusline({
    --   mode = "lsp_document_symbols",
    --   groups = {},
    --   title = false,
    --   filter = { range = true },
    --   format = "{kind_icon}{symbol.name:Normal}",
    --   -- The following line is needed to fix the background color
    --   -- Set it to the lualine section you want to use
    --   hl_group = "lualine_c_normal",
    -- })
    --
    -- table.insert(opts.sections.lualine_c, {
    --   symbols.get,
    --   cond = symbols.has,
    -- })
    --
    config.defaults.actions.files["ctrl-t"] = actions.open
  end,
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
