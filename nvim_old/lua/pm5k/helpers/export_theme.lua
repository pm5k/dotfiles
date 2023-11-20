local M = {}

local formats = {}
formats.background = "vim.o.background = %q"
formats.theme = "vim.g.colors_name = %q"
formats.terminal = "vim.g.terminal_color_%s = %q"
formats.group = "HI(0, %q, %s)"

local function get_colors(group_name)
  local group = vim.api.nvim_get_hl(0, { name = group_name })
  group[true] = nil
  group[false] = nil
  if group.fg then
    group.fg = string.format("#%06X", group.fg)
  end
  if group.bg then
    group.bg = string.format("#%06X", group.bg)
  end
  if group.sp then
    group.sp = string.format("#%06X", group.sp)
  end
  return group
end

function M.dump(metadata, options)
  metadata = vim.F.if_nil(metadata, {})
  options = vim.F.if_nil(options, {})
  options.exclude = vim.F.if_nil(options.exclude, {})
  options.exclude_defaults = vim.F.if_nil(options.exclude_defaults, true)
  options.merge = vim.F.if_nil(options.merge, {})
  metadata.background = vim.F.if_nil(metadata.background, vim.o.background)
  metadata.theme = vim.F.if_nil(metadata.theme, vim.g.colors_name)

  local group_names = vim.fn.getcompletion("", "highlight", false)
  local groups = {}
  for _, group_name in ipairs(group_names) do
    local low = group_name:lower()
    if low:match("^default") or low:match("default$") then
      if not options.exclude_defaults then
        groups[group_name] = get_colors(group_name)
      end
    else
      groups[group_name] = get_colors(group_name)
    end

    if vim.tbl_contains(vim.tbl_keys(options.merge), group_name) then
      groups[group_name] = options.merge[group_name]
    end
  end

  local terminal = {}
  local base = 0
  while base < 16 do
    terminal[base] = vim.g["terminal_color_" .. base]
    base = base + 1
  end
  return { groups = groups, metadata = metadata, terminal = terminal }
end

function M.encode(metadata, options)
  options = vim.F.if_nil(options, {})
  metadata = vim.F.if_nil(metadata, {})
  local theme = M.dump(metadata, options)
  local builder = {}
  if options.clean then
    table.insert(builder, 'vim.cmd.syntax("clear")')
    table.insert(builder, 'vim.cmd.highlight("clear")')
  end
  table.insert(builder, string.format(formats.theme, theme.metadata.theme))
  table.insert(builder, string.format(formats.background, theme.metadata.background))
  table.insert(builder, "local HI = vim.api.nvim_set_hl")
  if options.padded then
    table.insert(builder, "")
  end
  for base, color in pairs(theme.terminal) do
    table.insert(builder, string.format(formats.terminal, base, color))
  end
  if options.padded then
    table.insert(builder, "")
  end
  for group_name, colors in pairs(theme.groups) do
    table.insert(builder, string.format(formats.group, group_name, vim.inspect(colors, { newline = "" })))
  end

  return table.concat(builder, "\n"), theme.metadata
end

function M.write(path, ...)
  local theme, metadata = M.encode(...)
  path = vim.F.if_nil(path, vim.fn.stdpath("config") .. "/colors/" .. metadata.theme .. ".lua")
  local directory = vim.fn.fnamemodify(path, ":p:h")
  if vim.fn.isdirectory(directory) == 0 then
    vim.fn.mkdir(directory, "p")
  end
  local handle = io.open(path, "w")
  if handle then
    handle:write(theme)
    handle:close()
  end
end

return M
