-- Comprehensive testing commands for Neovim notifications and output
-- Add these to your init.lua or a separate test.lua file

-- =============================================================================
-- BASIC NOTIFICATION TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestNotify', function(opts)
  local levels = {
    trace = vim.log.levels.TRACE,
    debug = vim.log.levels.DEBUG,
    info = vim.log.levels.INFO,
    warn = vim.log.levels.WARN,
    error = vim.log.levels.ERROR,
  }
  
  local level = opts.args ~= "" and levels[opts.args:lower()] or vim.log.levels.INFO
  local level_name = opts.args ~= "" and opts.args:upper() or "INFO"
  
  vim.notify("Test " .. level_name .. " notification", level, {
    title = "Test " .. level_name
  })
end, {
  desc = "Test vim.notify with different levels",
  nargs = "?",
  complete = function() return {"trace", "debug", "info", "warn", "error"} end
})

vim.api.nvim_create_user_command('TestNotifyAll', function()
  local tests = {
    {vim.log.levels.TRACE, "TRACE", "Trace level message"},
    {vim.log.levels.DEBUG, "DEBUG", "Debug level message"},
    {vim.log.levels.INFO, "INFO", "Info level message"},
    {vim.log.levels.WARN, "WARN", "Warning level message"},
    {vim.log.levels.ERROR, "ERROR", "Error level message"},
  }
  
  for i, test in ipairs(tests) do
    vim.defer_fn(function()
      vim.notify(test[3], test[1], {title = "Test " .. test[2]})
    end, (i - 1) * 500)
  end
end, { desc = "Test all notification levels in sequence" })

vim.api.nvim_create_user_command('TestPrint', function()
  print("This is a print statement")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  
  vim.defer_fn(function()
    print("Multiple", "arguments", "in", "print")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end, 500)
  
  vim.defer_fn(function()
    print("Print with number:", 42)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end, 1000)
  
  vim.defer_fn(function()
    print("Print with table:", vim.inspect({a = 1, b = 2}))
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end, 1500)
end, { desc = "Test print statements (go to :messages)" })

-- =============================================================================
-- VIM ERROR TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestVimErrors', function()
  local errors = {
    {cmd = "nonexistentcommand", desc = "Non-existent command"},
    {cmd = "tabclose 999", desc = "Non-existent tab"},
    {cmd = "set nonexistentoption=value", desc = "Invalid option"},
    {cmd = "syntax invalid_syntax_rule", desc = "Invalid syntax rule"},
    {cmd = "source /nonexistent/config.vim", desc = "Source non-existent file"},
    {cmd = "colorscheme nonexistent_theme", desc = "Non-existent colorscheme"},
    {cmd = "highlight NonExistentGroup", desc = "Non-existent highlight group"},
    {cmd = "autocmd NonExistentEvent * echo 'test'", desc = "Non-existent autocmd event"},
  }
  
  for i, error_test in ipairs(errors) do
    vim.defer_fn(function()
      local success, err = pcall(vim.cmd, error_test.cmd)
      if not success then
        -- Clean up the error message and send to notifications
        local clean_err = err:gsub("^Vim%(.*%):", ""):gsub("^E%d+: ", "")
        vim.notify(error_test.desc .. ": " .. clean_err, vim.log.levels.ERROR, {
          title = "Vim Error Test"
        })
      else
        vim.notify("Expected error but command succeeded: " .. error_test.cmd, vim.log.levels.WARN, {
          title = "Vim Error Test"
        })
      end
    end, (i - 1) * 300)
  end
end, { desc = "Test various Vim command errors" })

vim.api.nvim_create_user_command('TestVimError', function(opts)
  local cmd = opts.args ~= "" and opts.args or "nonexistentcommand"
  
  local success, err = pcall(vim.cmd, cmd)
  if not success then
    -- Clean up the error message and send to notifications
    local clean_err = err:gsub("^Vim%(.*%):", ""):gsub("^E%d+: ", "")
    vim.notify("Command error: " .. clean_err, vim.log.levels.ERROR, {
      title = "Vim Error Test"
    })
  else
    vim.notify("Command succeeded (no error): " .. cmd, vim.log.levels.INFO, {
      title = "Vim Error Test"
    })
  end
end, {
  desc = "Test specific Vim command error",
  nargs = "?",
  complete = function()
    return {
      "nonexistentcommand",
      "tabclose 999", 
      "set invalid=option",
      "colorscheme nonexistent_theme",
      "highlight NonExistentGroup"
    }
  end
})

-- =============================================================================
-- LUA ERROR TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestLuaErrors', function()
  local tests = {
    function() error("Test error() function") end,
    function() assert(false, "Test assertion failure") end,
    function() vim.api.nvim_nonexistent_function() end,
    function() local x = nil; print(x.field) end,
    function() local arr = {}; print(arr[1].field) end,
    function() local t = {1,2,3}; print(t[10].something) end,
    function() local notfunc = "string"; notfunc() end,
  }
  
  for i, test in ipairs(tests) do
    vim.defer_fn(function()
      pcall(test)
    end, (i - 1) * 300)
  end
end, { desc = "Test various Lua errors" })

vim.api.nvim_create_user_command('TestLuaError', function(opts)
  local error_types = {
    error = function() error("Manual error") end,
    assert = function() assert(false, "Assertion failed") end,
    api = function() vim.api.nvim_nonexistent_function() end,
    nil_field = function() local x = nil; print(x.field) end,
    call_string = function() local s = "string"; s() end,
  }
  
  local error_type = opts.args ~= "" and opts.args or "error"
  local test_func = error_types[error_type]
  
  if test_func then
    pcall(test_func)
  else
    vim.notify("Unknown error type: " .. error_type, vim.log.levels.WARN)
  end
end, {
  desc = "Test specific Lua error type",
  nargs = "?",
  complete = function()
    return {"error", "assert", "api", "nil_field", "call_string"}
  end
})

-- =============================================================================
-- LSP TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestLspErrors', function()
  -- Test LSP when no server is attached
  pcall(vim.lsp.buf.definition)
  pcall(vim.lsp.buf.hover)
  pcall(vim.lsp.buf.references)
  
  -- Invalid LSP request
  pcall(function()
    vim.lsp.buf_request(0, "textDocument/invalidMethod", {})
  end)
  
  vim.notify("LSP error tests completed", vim.log.levels.INFO, {title = "LSP Test"})
end, { desc = "Test LSP errors and messages" })

vim.api.nvim_create_user_command('TestLspRestart', function()
  vim.cmd("LspRestart")
  vim.notify("LSP restart triggered", vim.log.levels.INFO, {title = "LSP Test"})
end, { desc = "Test LSP restart messages" })

vim.api.nvim_create_user_command('TestLspInfo', function()
  vim.cmd("LspInfo")
  vim.notify("LSP info displayed", vim.log.levels.INFO, {title = "LSP Test"})
end, { desc = "Show LSP information" })



-- =============================================================================
-- FILE SYSTEM TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestFileErrors', function()
  local tests = {
    {cmd = "cd /proc/sys/kernel/nonexistent", desc = "Directory doesn't exist"},
    {cmd = "source /nonexistent/vimrc", desc = "Source non-existent file"},
    {cmd = "runtime nonexistent/plugin.vim", desc = "Runtime file doesn't exist"},
    {cmd = "helptags /nonexistent/directory", desc = "Generate help tags for non-existent dir"},
    {cmd = "redir > /root/forbidden.txt", desc = "Redirect to forbidden location"},
  }
  
  for i, test in ipairs(tests) do
    vim.defer_fn(function()
      local success, err = pcall(vim.cmd, test.cmd)
      if not success then
        local clean_err = err:gsub("^Vim%(.*%):", ""):gsub("^E%d+: ", "")
        vim.notify(test.desc .. ": " .. clean_err, vim.log.levels.ERROR, {
          title = "File Error Test"
        })
      else
        vim.notify("Expected error but command succeeded: " .. test.cmd, vim.log.levels.WARN, {
          title = "File Error Test"
        })
      end
    end, (i - 1) * 300)
  end
end, { desc = "Test file system related errors" })

-- =============================================================================
-- PLUGIN TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestPluginErrors', function()
  -- Try to use non-existent plugins
  pcall(function() vim.cmd("Telescope nonexistent_picker") end)
  pcall(function() require("nonexistent_plugin") end)
  
  vim.notify("Plugin error tests completed", vim.log.levels.INFO, {title = "Plugin Test"})
end, { desc = "Test plugin-related errors" })

-- =============================================================================
-- SNACKS-SPECIFIC TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestSnacks', function()
  if not pcall(require, "snacks") then
    vim.notify("Snacks.nvim not available", vim.log.levels.ERROR)
    return
  end
  
  local Snacks = require("snacks")
  
  Snacks.notifier.notify("Direct Snacks notification")
  vim.defer_fn(function()
    Snacks.notifier.notify("Snacks error test", vim.log.levels.ERROR)
  end, 500)
  vim.defer_fn(function()
    Snacks.notifier.notify("Snacks warning test", vim.log.levels.WARN)
  end, 1000)
end, { desc = "Test Snacks.nvim notifications directly" })

vim.api.nvim_create_user_command('TestSnacksHistory', function()
  if pcall(require, "snacks") then
    require("snacks").notifier.show_history()
  else
    vim.notify("Snacks.nvim not available", vim.log.levels.ERROR)
  end
end, { desc = "Show Snacks notification history" })

-- =============================================================================
-- COMPREHENSIVE TESTS
-- =============================================================================

vim.api.nvim_create_user_command('TestAll', function()
  vim.notify("Starting comprehensive test suite...", vim.log.levels.INFO, {title = "Test Suite"})
  
  -- Test notifications
  vim.defer_fn(function() vim.cmd("TestNotifyAll") end, 1000)
  
  -- Test print statements
  vim.defer_fn(function() vim.cmd("TestPrint") end, 4000)
  
  -- Test Vim errors
  vim.defer_fn(function() vim.cmd("TestVimErrors") end, 5000)
  
  -- Test Lua errors
  vim.defer_fn(function() vim.cmd("TestLuaErrors") end, 8000)
  
  -- Test Lazy.nvim interface
  vim.defer_fn(function() vim.cmd("TestLspErrors") end, 8000)
  
  -- Test file errors
  vim.defer_fn(function() vim.cmd("TestFileErrors") end, 9000)
  
  -- Test plugins
  vim.defer_fn(function() vim.cmd("TestPluginErrors") end, 11000)
  
  -- Test Snacks
  vim.defer_fn(function() vim.cmd("TestSnacks") end, 12000)
  
  vim.defer_fn(function()
    vim.notify("Test suite completed!", vim.log.levels.INFO, {title = "Test Suite"})
  end, 13000)
end, { desc = "Run all notification and error tests" })

-- =============================================================================
-- LOG MANAGEMENT
-- =============================================================================

vim.api.nvim_create_user_command('TestShowMessages', function()
  vim.cmd("messages")
end, { desc = "Show Vim messages" })

vim.api.nvim_create_user_command('TestClearMessages', function()
  vim.cmd("messages clear")
  vim.notify("Messages cleared", vim.log.levels.INFO)
end, { desc = "Clear Vim messages" })

-- =============================================================================
-- HELP COMMAND
-- =============================================================================

vim.api.nvim_create_user_command('TestHelp', function()
  local commands = {
    "TestNotify [level] - Test vim.notify with specific level",
    "TestNotifyAll - Test all notification levels",
    "TestPrint - Test print statements",
    "TestVimErrors - Test Vim command errors",
    "TestVimError [cmd] - Test specific Vim error",
    "TestLuaErrors - Test Lua runtime errors", 
    "TestLuaError [type] - Test specific Lua error",
    "TestLspErrors - Test LSP errors",
    "TestLspRestart - Test LSP restart",
    "TestLspInfo - Show LSP info",
    "TestFileErrors - Test file system errors",
    "TestPluginErrors - Test plugin errors",
    "TestSnacks - Test Snacks notifications",
    "TestSnacksHistory - Show Snacks history",
    "TestAll - Run comprehensive test suite",
    "TestShowMessages - Show :messages",
    "TestClearMessages - Clear :messages",
    "TestHelp - Show this help",
  }
  
  print("Available test commands:")
  for _, cmd in ipairs(commands) do
    print("  :" .. cmd)
  end
end, { desc = "Show help for all test commands" })
