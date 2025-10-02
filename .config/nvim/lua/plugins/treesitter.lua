-- lua/plugins/treesitter.lua
-- Treesitter configuration

local utils = require("config.utils")

-- Get Treesitter plugin
local treesitter = utils.safe_require("nvim-treesitter")
if not treesitter then
  return
end

-- Setup Treesitter
treesitter.setup({})

-- Install parsers
-- Note: Treesitter is manually enabled per filetype in config/autocmds.lua
local parsers = {
  -- Web & Markup
  "astro",
  "css",
  "html",
  "html_tags",
  "javascript",
  "jsx",
  "markdown",
  "markdown_inline",
  "svelte",
  "tsx",
  "typescript",
  "vue",

  -- Systems
  "bash",
  "c",
  "cpp",
  "go",
  "gomod",
  "lua",
  "luadoc",
  "python",
  "rust",
  "zig",

  -- Config & Data
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "json",
  "just",
  "nix",
  "toml",
  "yaml",

  -- Other
  "caddy",
  "comment",
  "diff",
  "editorconfig",
  "graphql",
  "hcl",
  "jq",
  "jsdoc",
  "make",
  "prisma",
  "solidity",
  "sql",
  "ssh_config",
  "tmux",
  "vim",
  "vimdoc",
}

treesitter.install(parsers)
