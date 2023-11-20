vim.opt.termguicolors = true

-- Catpuccin Palette:
local frappe = {
    "#414559",
    "#51576d",
    "#626880",
    "#737994",
    "#838ba7",
    "#949cbb",
    "#a5adce",
    "#b5bfe2",
    "#c6d0f5",
    "#babbf1",
    "#8caaee",
    "#85c1dc",
    "#99d1db",
    "#81c8be",
    "#a6d189",
    "#e5c890",
    "#ef9f76",
    "#ea999c",
    "#e78284",
    "#ca9ee6",
    "#f4b8e4",
    "#eebebe",
    "#f2d5cf",
}

-- Function to iterate over the palette table
-- and then toggle the highlight group.
local function hl()
    for i, v in ipairs(frappe) do
        vim.cmd("highlight IndentBlanklineIndent" .. i .. " guifg=" .. v .. " gui=nocombine")
    end
end

-- Function to output a table of "IndentBlanklineIndent" suffixed
-- with the index of the color in the palette.
local function hl_table()
    local hl_list = {}
    for i, _ in ipairs(frappe) do
        table.insert(hl_list, "IndentBlanklineIndent" .. i)
    end
    return hl_list
end

-- Call the function to set the highlights
hl()

-- Setup the plugin
require("indent_blankline").setup {
    char = "┊",
    show_trailing_blankline_indent = false,
    char_highlight_list = hl_table(),
}
