local vale = {}

function vale.setup(opts)
  if opts == nil then
    return
  end

  local valid_keys = {bin=true, vale_config_path=true}
  for k, v in ipairs(opts) do
    if valid_keys[k] == nil then
      error_msg = k .. " is not a valid key for vale.nvim"
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
  if range == 0 then
    -- not on visual mode, run Vale on the whole file.
    range_start = 1
    range_end = vim.fn.line("$")
  end
  require("vale.quickfix_window").create(range_start, range_end)
end

return vale
