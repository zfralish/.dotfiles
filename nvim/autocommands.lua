-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function update_title()
  local cwd = vim.fn.getcwd()
  local project_name = vim.fn.fnamemodify(cwd, ":t")
  local parent_dir = vim.fn.fnamemodify(cwd, ":h:t")

  -- Debug print
  print("Current working directory: " .. cwd)
  print("Project name: " .. project_name)
  print("Parent directory: " .. parent_dir)

  -- If the current directory is the home directory, use "~"
  if cwd == vim.fn.expand("~") then
    project_name = "~"
  -- If project_name is not informative (like "src"), include parent directory
  elseif #project_name <= 3 then
    project_name = parent_dir .. "/" .. project_name
  end

  local title = project_name .. " - nvim"
  print("Setting title to: " .. title)

  vim.fn.system('echo -ne "\\033]0;' .. title .. '\\007"')
end

-- Add these to your existing autocommands
return {
  {
    "DirChanged",
    pattern = "*",
    callback = function()
      print("DirChanged event triggered")
      update_title()
    end,
  },
  {
    "VimEnter",
    callback = function()
      print("VimEnter event triggered")
      update_title()
    end,
  },
  {
    "BufEnter",
    pattern = "*",
    callback = function()
      print("BufEnter event triggered")
      update_title()
    end,
  },
}
