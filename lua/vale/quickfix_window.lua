local config = require "vale.config"
local temp_file = require "vale.temp_file"
local cmd = require "vale.cmd"

local quickfix_window = {}

local create_lines_from_temp_file = function(range_start, range_end)
  temp_file.create(range_start, range_end)
  local vale_cmd = cmd.build_from_temp_file()
  local temp_list = vim.fn.systemlist(vale_cmd)
  local temp_file_name = temp_file.get_name()
  local current_file_name = vim.api.nvim_buf_get_name(0)

  if string.find(temp_list[1], "[--config] Runtime error") then
    vim.api.nvim_err_writeln("Vale.nvim: Invalid configuration file")
    return
  end

  local lines = {}

  for i, line in pairs(temp_list) do
    line = line:gsub(temp_file_name, current_file_name, 1)
    if range_start ~= 0 then
      old_pattern = line:match(":%d+:")
      old_line_num = old_pattern:match("%d+")
      new_line_num = old_line_num + range_start - 1
      new_pattern = ":" .. new_line_num .. ":"
      line = line:gsub(old_pattern, new_pattern, 1)
    end
    lines[#lines + 1], _ = line
  end

  temp_file.remove()
  return lines
end

function quickfix_window.create(range_start, range_end)
  if vim.fn.getbufvar(vim.fn.bufnr('%'), "&buftype") == "quickfix" then
    vim.api.nvim_err_writeln("Vale: Can't run on the quickfix window itself!")
    return
  end

  local temp_file_name = temp_file.get_name()
  local current_file_name = vim.api.nvim_buf_get_name(0)

  local lines = create_lines_from_temp_file(range_start, range_end)
  vim.fn.setqflist({}, " ", {lines = lines, title = "Vale Results"})
  vim.cmd("copen")
end

return quickfix_window
