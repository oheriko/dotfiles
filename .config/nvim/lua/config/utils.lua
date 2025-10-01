-- lua/config/utils.lua
-- Shared utility functions

local M = {}

-- Safe require with error handling
M.safe_require = function(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format("Failed to load module: %s\n%s", module, result), vim.log.levels.WARN)
    return nil
  end
  return result
end

-- Keymap helper with sane defaults
M.map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Delete default keymaps
M.del_map = function(mode, keys)
  for _, key in ipairs(keys) do
    pcall(vim.keymap.del, mode, key)
  end
end

-- Augroup helper with namespacing
M.augroup = function(name)
  return vim.api.nvim_create_augroup("MyConfig_" .. name, { clear = true })
end

-- Check if plugin is available
M.has_plugin = function(plugin)
  local ok = pcall(require, plugin)
  return ok
end

-- Notification helper
M.notify = function(msg, level, opts)
  opts = opts or {}
  opts.title = opts.title or "Neovim"
  vim.notify(msg, level or vim.log.levels.INFO, opts)
end

return M
