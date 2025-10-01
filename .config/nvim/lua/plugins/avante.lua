local function ensure_avante_built()
  local avante_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/avante"
  local build_dir = avante_path .. "/build"
  if vim.fn.isdirectory(build_dir) == 0 then
    vim.notify("Building avante.nvim...", vim.log.levels.INFO)
    local build_cmd = vim.fn.has("win32") == 1
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource true"
      or "make BUILD_FROM_SOURCE=true"
    vim.fn.system(string.format("cd %s && %s", avante_path, build_cmd))
    if vim.v.shell_error == 0 then
      vim.notify("avante.nvim built successfully!", vim.log.levels.INFO)
    else
      vim.notify("Failed to build avante.nvim. Please run 'make' manually.", vim.log.levels.ERROR)
    end
  end
end

ensure_avante_built()

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
      model = "claude-sonnet-4-5-20250929",
      api_key = vim.fn.getenv("ANTHROPIC_API_KEY"),
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
  },

  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ""
  end,
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  -- Disable Avante's built-in tools that conflict with MCP Hub's neovim server
  disabled_tools = {
    "list_files",
    "search_files",
    "read_file",
    "create_file",
    "rename_file",
    "delete_file",
    "create_dir",
    "rename_dir",
    "delete_dir",
    "bash",
  },

  -- Fix window management issues
  windows = {
    position = "right",
    wrap = true,
    width = 30,
    sidebar_header = {
      align = "center",
      rounded = true,
    },
  },

  -- Prevent window split errors
  behaviour = {
    auto_suggestions = false, -- Disable auto-suggestions to prevent conflicts
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
})

-- Fix: Prevent Avante from opening windows during window close operations
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    -- Don't do anything if we're in the middle of closing windows
    if vim.v.exiting ~= vim.NIL then
      return
    end
  end,
})

-- Alternative fix: Debounce Avante sidebar updates
local avante_timer = nil
local function safe_avante_refresh()
  if avante_timer then
    vim.fn.timer_stop(avante_timer)
  end
  avante_timer = vim.fn.timer_start(100, function()
    pcall(function()
      local sidebar = require("avante").get()
      if sidebar and sidebar.is_open and sidebar.is_open() then
        pcall(function() sidebar:refresh() end)
      end
    end)
  end)
end

-- 🔥 KILLER AVANTE KEYMAPS 🔥
local map = vim.keymap.set

-- Core AI interactions
map("n", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Avante: Ask AI" })
map("v", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Avante: Ask AI about selection" })
map("n", "<leader>ac", "<cmd>AvanteChat<cr>", { desc = "Avante: Open chat" })
map("n", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "Avante: Edit selection" })
map("v", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "Avante: Edit selection" })

-- Sidebar management
map("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Avante: Toggle sidebar" })
map("n", "<leader>af", "<cmd>AvanteFocus<cr>", { desc = "Avante: Focus sidebar" })
map("n", "<leader>ar", safe_avante_refresh, { desc = "Avante: Refresh (safe)" })

-- File management
map("n", "<leader>a+", function()
  local sidebar = require("avante").get()
  if not sidebar or not sidebar:is_open() then
    require("avante.api").ask()
    sidebar = require("avante").get()
  end
  local filepath = vim.api.nvim_buf_get_name(0)
  local relative = require("avante.utils").relative_path(filepath)
  sidebar.file_selector:add_selected_file(relative)
  vim.notify("Added " .. relative .. " to Avante", vim.log.levels.INFO)
end, { desc = "Avante: Add current file" })

map("n", "<leader>a-", function()
  local sidebar = require("avante").get()
  if sidebar and sidebar:is_open() then
    local filepath = vim.api.nvim_buf_get_name(0)
    local relative = require("avante.utils").relative_path(filepath)
    sidebar.file_selector:remove_selected_file(relative)
    vim.notify("Removed " .. relative .. " from Avante", vim.log.levels.INFO)
  end
end, { desc = "Avante: Remove current file" })

map("n", "<leader>aA", function()
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
  vim.notify("Added " .. count .. " buffers to Avante", vim.log.levels.INFO)
end, { desc = "Avante: Add all buffers" })

-- History and sessions
map("n", "<leader>ah", "<cmd>AvanteHistory<cr>", { desc = "Avante: Chat history" })
map("n", "<leader>an", "<cmd>AvanteChatNew<cr>", { desc = "Avante: New chat" })
map("n", "<leader>ax", "<cmd>AvanteClear<cr>", { desc = "Avante: Clear chat" })

-- Provider switching
map("n", "<leader>ap", "<cmd>AvanteSwitchProvider<cr>", { desc = "Avante: Switch provider" })
map("n", "<leader>am", "<cmd>AvanteModels<cr>", { desc = "Avante: Show models" })

-- Quick provider toggles
map("n", "<leader>apc", function()
  require("avante.config").override({ provider = "claude" })
  vim.notify("Switched to Claude", vim.log.levels.INFO)
end, { desc = "Avante: Use Claude" })

map("n", "<leader>apo", function()
  require("avante.config").override({ provider = "ollama" })
  vim.notify("Switched to Ollama", vim.log.levels.INFO)
end, { desc = "Avante: Use Ollama" })

-- Utilities
map("n", "<leader>as", "<cmd>AvanteStop<cr>", { desc = "Avante: Stop generation" })
map("n", "<leader>aR", "<cmd>AvanteShowRepoMap<cr>", { desc = "Avante: Show repo map" })
map("n", "<leader>ab", "<cmd>AvanteBuild<cr>", { desc = "Avante: Rebuild plugin" })
