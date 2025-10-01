-- lua/plugins/avante/keymaps.lua
-- Avante keymap configuration

local map = require("config.utils").map
local notify = require("config.utils").notify

-- Safe refresh function with debouncing
local avante_timer = nil
local function safe_avante_refresh()
  if avante_timer then
    vim.fn.timer_stop(avante_timer)
  end
  avante_timer = vim.fn.timer_start(100, function()
    pcall(function()
      local avante = require("avante")
      local sidebar = avante.get()
      if sidebar and sidebar.is_open and sidebar.is_open() then
        pcall(function()
          sidebar:refresh()
        end)
      end
    end)
  end)
end

-- Helper to add file to Avante
local function add_current_file()
  local sidebar = require("avante").get()
  if not sidebar or not sidebar:is_open() then
    require("avante.api").ask()
    sidebar = require("avante").get()
  end
  local filepath = vim.api.nvim_buf_get_name(0)
  local relative = require("avante.utils").relative_path(filepath)
  sidebar.file_selector:add_selected_file(relative)
  notify("Added " .. relative .. " to Avante")
end

-- Helper to remove file from Avante
local function remove_current_file()
  local sidebar = require("avante").get()
  if sidebar and sidebar:is_open() then
    local filepath = vim.api.nvim_buf_get_name(0)
    local relative = require("avante.utils").relative_path(filepath)
    sidebar.file_selector:remove_selected_file(relative)
    notify("Removed " .. relative .. " from Avante")
  end
end

-- Helper to add all buffers to Avante
local function add_all_buffers()
  local sidebar = require("avante").get()
  if not sidebar or not sidebar:is_open() then
    require("avante.api").ask()
    sidebar = require("avante").get()
  end
  local buffers = vim.api.nvim_list_bufs()
  local count = 0
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local filepath = vim.api.nvim_buf_get_name(buf)
      if filepath ~= "" then
        local relative = require("avante.utils").relative_path(filepath)
        sidebar.file_selector:add_selected_file(relative)
        count = count + 1
      end
    end
  end
  notify("Added " .. count .. " buffers to Avante")
end

-- Helper to switch provider
local function switch_provider(provider)
  require("avante.config").override({ provider = provider })
  notify("Switched to " .. provider:gsub("^%l", string.upper))
end

-- Setup all keymaps
local function setup_keymaps()
  -- Core AI interactions
  map("n", "<leader>aa", "<cmd>AvanteAsk<cr>", "Avante: Ask AI")
  map("v", "<leader>aa", "<cmd>AvanteAsk<cr>", "Avante: Ask AI about selection")
  map("n", "<leader>ac", "<cmd>AvanteChat<cr>", "Avante: Open chat")
  map("n", "<leader>ae", "<cmd>AvanteEdit<cr>", "Avante: Edit selection")
  map("v", "<leader>ae", "<cmd>AvanteEdit<cr>", "Avante: Edit selection")

  -- Sidebar management
  map("n", "<leader>at", "<cmd>AvanteToggle<cr>", "Avante: Toggle sidebar")
  map("n", "<leader>af", "<cmd>AvanteFocus<cr>", "Avante: Focus sidebar")
  map("n", "<leader>ar", safe_avante_refresh, "Avante: Refresh (safe)")

  -- File management
  map("n", "<leader>a+", add_current_file, "Avante: Add current file")
  map("n", "<leader>a-", remove_current_file, "Avante: Remove current file")
  map("n", "<leader>aA", add_all_buffers, "Avante: Add all buffers")

  -- History and sessions
  map("n", "<leader>ah", "<cmd>AvanteHistory<cr>", "Avante: Chat history")
  map("n", "<leader>an", "<cmd>AvanteChatNew<cr>", "Avante: New chat")
  map("n", "<leader>ax", "<cmd>AvanteClear<cr>", "Avante: Clear chat")

  -- Provider management
  map("n", "<leader>ap", "<cmd>AvanteSwitchProvider<cr>", "Avante: Switch provider")
  map("n", "<leader>am", "<cmd>AvanteModels<cr>", "Avante: Show models")
  map("n", "<leader>apc", function()
    switch_provider("claude")
  end, "Avante: Use Claude")
  map("n", "<leader>apo", function()
    switch_provider("ollama")
  end, "Avante: Use Ollama")

  -- Utilities
  map("n", "<leader>as", "<cmd>AvanteStop<cr>", "Avante: Stop generation")
  map("n", "<leader>aR", "<cmd>AvanteShowRepoMap<cr>", "Avante: Show repo map")
  map("n", "<leader>ab", "<cmd>AvanteBuild<cr>", "Avante: Rebuild plugin")
end

return {
  setup = setup_keymaps,
}
