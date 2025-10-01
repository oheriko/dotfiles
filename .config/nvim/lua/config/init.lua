-- lua/config/init.lua
-- Main configuration entry point

-- Enable Lua module loader for faster startup
vim.loader.enable()

-- Load configuration modules in order
require("config.globals")
require("config.options")
require("config.packs")
require("config.autocmds")
require("config.lsp")
require("config.keymaps") -- Now just a reference doc, actual maps are in plugins
