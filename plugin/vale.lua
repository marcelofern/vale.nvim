if 1 ~= vim.fn.has("nvim-0.7.0") then
  vim.api.nvim_err_writeln("Vale.nvim requires at least nvim-0.7.0.")
  return
end

if vim.g.loaded_vale == 1 then
  return
end
vim.g.loaded_vale = 1

local vale_init = function(opts)
  require("vale").run(opts.line1, opts.line2, opts.range)
end

vim.api.nvim_create_user_command("Vale", vale_init, {
  -- No arguments allowed for this command.
  nargs=0,
  -- Can be used in visual mode too.
  range=true,
})
