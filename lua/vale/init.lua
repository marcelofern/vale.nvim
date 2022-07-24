local vale = {}

function vale.setup(opts)
  if opts == nil then
    return
  end

  local valid_keys = {bin=true, vale_config_path=true}
  for k, v in pairs(opts) do
    if valid_keys[k] == nil then
      error_msg = "Vale.nvim: '" .. k .. "' is not a valid config key."
      vim.api.nvim_err_writeln(error_msg)
    end
  end

  if opts.bin then
    require("vale.config").set_bin(opts.bin)
  end
  if opts.vale_config_path then
    require("vale.config").set_vale_config_path(opts.vale_config_path)
  end
end

function vale.run(range_start, range_end, range)
  local is_visual = true
  if range == 0 then
    is_visual = false
    range_start = 1
    range_end = vim.fn.line("$")
  end
  require("vale.quickfix_window").create(range_start, range_end, is_visual)
end

return vale
