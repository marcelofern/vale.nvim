local visual_mode = {}

function visual_mode.get_selection_range()
  local _, vstart, _, _ = unpack(vim.fn.getpos("v"))
  local _, vend, _, _ = unpack(vim.fn.getpos("."))
  if vstart < vend then
    return vstart, vend
  else
    return vend, vstart
  end
end

function visual_mode.get_selection_as_string()
  local vstart, vend = visual_mode.get_selection_range()
  local vlines = vim.fn.getline(vstart, vend)
  local result = ""

  for i, line in pairs(vlines) do
    if i == 1 then
      result = line
    else
      result = result .. "\n" .. line
    end
  end

  return result
end

return visual_mode
