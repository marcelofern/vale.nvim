local config = require "vale.config"
local temp_file = require "vale.temp_file"

local cmd = {}

function cmd.build_from_file(file_path)
  return table.concat({
    config.get_bin(),
    "--output=line",
    "--config=" .. config.get_vale_config_path(),
    file_path
  }, " ")
end

function cmd.build_from_current_buffer()
  return cmd.build_from_file(vim.api.nvim_buf_get_name(0))
end

function cmd.build_from_temp_file()
  return cmd.build_from_file(temp_file.get_name())
end

return cmd
