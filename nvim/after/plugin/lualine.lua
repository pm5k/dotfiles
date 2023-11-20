-- Custom methods
local function word_count()
  return "W: " .. 
    tostring(vim.fn.wordcount().words) ..
    " C: " .. 
    tostring(vim.fn.wordcount().chars)
end

-- Custom mode
local function mode(mode_str)
  local mode_map = {
    ["NORMAL"] = "N",
    ["O-PENDING"] = "N?",
    ["INSERT"] = "I",
    ["VISUAL"] = "V",
    ["V-BLOCK"] = "VB",
    ["V-LINE"] = "VL",
    ["V-REPLACE"] = "VR",
    ["REPLACE"] = "R",
    ["COMMAND"] = "!",
    ["SHELL"] = "SH",
    ["TERMINAL"] = "T",
    ["EX"] = "X",
    ["S-BLOCK"] = "SB",
    ["S-LINE"] = "SL",
    ["SELECT"] = "S",
    ["CONFIRM"] = "Y?",
    ["MORE"] = "M",
  }
  return "" .. (mode_map[mode_str] or mode_str) .. ""
end

-- Custom "spaces"
local top = {
  lualine_a = {
    { "mode", fmt = mode }
  },
  lualine_b = {
    {
      "filename",
      path = 3,
      symbols = {
        modified = "[modified]", -- Text to show when the file is modified.
        readonly = "[readonly]", -- Text to show when the file is non-modifiable or readonly.
        unnamed = "[unnamed]", -- Text to show for unnamed buffers.
        newfile = "[new file]", -- Text to show for newly created file before first write
      }
    }
  },
  lualine_y = {
    "encoding",
    {
      "fileformat",
      symbols = {
        unix = " Unix",
        dos = " DOS",
        mac = " Mac",
      }
    },
    {
      "filetype",
      colored = true,
    }
  },
  lualine_z = {
    {"datetime", style = "%a %d/%M/%Y %H:%M:%S"}
  }
}

local bottom = {
  lualine_a = {
    { "mode", fmt = mode },
    "branch",
  },
  lualine_b = {
    {
      'diff',
      colored = true,
      diff_color = {
        added    = {fg="#98c379"},
        modified = {fg="#e5c07b"},
        removed  = {fg="#e06c75"},
      },
      symbols = {added = '+', modified = '~', removed = '-'},
    }
  },
  lualine_c = {
    {
      "diagnostics",
      sources = {"nvim_lsp", "nvim_diagnostic", "coc" },
      sections = { "error", "warn", "info", "hint" },

      diagnostics_color = {
        error = "DiagnosticError", -- Changes diagnostics" error color.
        warn  = "DiagnosticWarn",  -- Changes diagnostics" warn color.
        info  = "DiagnosticInfo",  -- Changes diagnostics" info color.
        hint  = "DiagnosticHint",  -- Changes diagnostics" hint color.
      },
      symbols = {error = " ", warn = " ", info = " ", hint = "󰱹 "},
      colored = true, -- Displays diagnostics status in color if set to true.
      update_in_insert = true, -- Update diagnostics in insert mode.
      always_visible = false, -- Show diagnostics even if there are none.
    }
  },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {
    word_count,
    "progress",
    "location"
  },
}

-- Lualine stuff
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = bottom,
  inactive_sections = bottom,
  tabline = {},
  winbar = top,
  inactive_winbar = top,
  extensions = {}
}
