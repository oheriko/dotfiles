-- lua/config/env.lua
-- Centralized environment variable management

local M = {}

-- Helper to safely get environment variable as string
local function get_env(var, default)
  local value = vim.fn.getenv(var)
  if value == vim.NIL or value == "" then
    return default
  end
  return tostring(value)
end

-- Cache environment variables on first load
M.anthropic_api_key = get_env("ANTHROPIC_API_KEY", "")
M.ollama_endpoint = get_env("OLLAMA_ENDPOINT", "http://localhost:11434")

-- Helper to get current working directory
M.cwd = function() return vim.uv.cwd() or vim.fn.getcwd() end

-- Helper to get node_modules binary path
M.node_bin = function(binary) return M.cwd() .. "/node_modules/.bin/" .. binary end

-- Helper to check if environment variable is set
M.has_env = function(var)
  local value = vim.fn.getenv(var)
  return value ~= vim.NIL and value ~= ""
end

return M
