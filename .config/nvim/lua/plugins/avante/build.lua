-- lua/plugins/avante/build.lua
-- Avante build verification and setup

local notify = require("config.utils").notify

-- Build marker file to avoid repeated checks
local build_marker = vim.fn.stdpath("data") .. "/.avante_built"

-- Check if Avante has been built
local function is_built()
  return vim.fn.filereadable(build_marker) == 1
end

-- Mark Avante as built
local function mark_built()
  local f = io.open(build_marker, "w")
  if f then
    f:write(tostring(os.time()))
    f:close()
  end
end

-- Build Avante
local function build_avante()
  local avante_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/avante"
  local build_dir = avante_path .. "/build"

  -- Check if build directory exists
  if vim.fn.isdirectory(build_dir) == 1 then
    mark_built()
    return true
  end

  notify("Building avante.nvim...", vim.log.levels.INFO)

  -- Determine build command based on OS
  local build_cmd = vim.fn.has("win32") == 1
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource true"
    or "make BUILD_FROM_SOURCE=true"

  -- Execute build
  local result = vim.fn.system(string.format("cd %s && %s", avante_path, build_cmd))

  if vim.v.shell_error == 0 then
    notify("avante.nvim built successfully!", vim.log.levels.INFO)
    mark_built()
    return true
  else
    notify(
      "Failed to build avante.nvim. Please run 'make' manually in " .. avante_path,
      vim.log.levels.ERROR
    )
    return false
  end
end

-- Ensure Avante is built (only check once per session)
local function ensure_built()
  if is_built() then
    return true
  end
  return build_avante()
end

return {
  ensure_built = ensure_built,
}
