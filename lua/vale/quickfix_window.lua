local config = require "vale.config"
local cmd = require "vale.cmd"

local quickfix_window = {}

local create_lines = function(range_start, range_end)
  local vale_cmd = cmd.build()
  local results = vim.fn.systemlist(vale_cmd)

  if results == nil or #results == 0 then
    return {}
  end

  if string.find(results[1], "[--config] Runtime error") then
    vim.api.nvim_err_writeln("Vale.nvim: Invalid configuration file")
    return
  end

  local lines = {}

  for i, line in pairs(results) do
    if range_start ~= 0 then
      line_pattern = line:match(":%d+:")
      line_num = tonumber(line_pattern:match("%d+"))
      if line_num >= range_start and line_num <= range_end then
        lines[#lines + 1] = line
      end
    end
  end
  return lines
end

function quickfix_window.create(range_start, range_end, is_visual)
  if vim.fn.getbufvar(vim.fn.bufnr('%'), "&buftype") == "quickfix" then
    vim.api.nvim_err_writeln("Vale: Can't run on the quickfix window itself!")
    return
  end

  -- save the file before continuing.
  vim.cmd("w!")

  local lines = create_lines(range_start, range_end)
  if lines == nil or #lines == 0 then
    if is_visual == true then
      vim.api.nvim_command('echomsg "Vale: no results for this selection."')
    else
      vim.api.nvim_command('echomsg "Vale: no results for this file."')
    end
    return
  end

  vim.fn.setqflist({}, " ", {lines = lines, title = "Vale Results"})
  vim.cmd("copen")
end

return quickfix_window
