-- Yoinked from https://github.com/bew/dotfiles/blob/main/gui/wezterm/lib/mystdlib.lua
local conftable = {}

--- Merge all the given tables into a single one and return it.
function conftable.merge_all(...)
  local ret = {}
  for _, tbl in ipairs({...}) do
    for k, v in pairs(tbl) do
      ret[k] = v
    end
  end
  return ret
end

return {
    conftable = conftable,
}