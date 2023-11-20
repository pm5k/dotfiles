local wilder = require("wilder")


wilder.setup({
  modes = { ":", "/", "s" },
})

wilder.set_option("use_python_remote_plugin", 0)

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  )
})

-- Governs `:` popup menu..
local cmd_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = "rounded",
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = wilder.lua_fzy_highlighter(),
    highlights = {
      accent = wilder.make_hl("WilderAccent", "Pmenu", {{a = 1}, {a = 1}, {foreground = "#f4468f"}}),
    },
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
        icons = {["+"] = "", a = "", h = ""},
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  })
)

-- Governs `/` popup menu..
local search_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = "rounded",
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = wilder.lua_fzy_highlighter(),
    highlights = {
      accent = wilder.make_hl("WilderAccent", "Pmenu", {{a = 1}, {a = 1}, {foreground = "#f4468f"}}),
    },
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
        icons = {["+"] = "", a = "", h = ""},
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  })
)

wilder.set_option("renderer", wilder.renderer_mux({
  [":"] = cmd_renderer,
  ["/"] = search_renderer,
}))
