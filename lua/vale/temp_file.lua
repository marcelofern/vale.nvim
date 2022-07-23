local visual_mode = require "vale.visual_mode"

--[[

  Vale has support for only a few file types. This is a problem if you are
  writing code in a `.py` file or `.cpp` file and want to sanitise your comment
  or string using Vale.

  In order to work around it, this plugin copies the buffer (or the visual
  selection) into a new temporary file (see .get_name()). This temporary file
  is tagged as a `.md` file, so that the Vale command works on it.

--]]

local temp_file = {}

function temp_file.create(range_start, range_end)
  return vim.cmd(table.concat({
    "silent ",
    "exec '",
    range_start,
    ",",
    range_end,
    " w! ",
    temp_file.get_name(),
    "'",
  }, ""))
end

function temp_file.remove()
  os.execute(table.concat({
      "rm -f",
      temp_file.get_name(),
  }, " "))
end

function temp_file.get_name()
  return vim.fn.getcwd() .. "/.vale_results.md"
end

return temp_file
