local config = require "vale.config"

local cmd = {}

function cmd.build()
  return table.concat({
    config.get_bin(),
    "--output=line",
    "--config=" .. config.get_vale_config_path(),
    string.format('"%s"', vim.api.nvim_buf_get_name(0)),
  }, " ")
end

return cmd
