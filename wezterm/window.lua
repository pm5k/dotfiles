local wezterm = require 'wezterm'


-- Enable this in order to maximize the window on startup
-- local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
--   local tab, pane, window = mux.spawn_window{}
--   window:gui_window():maximize()
-- end)

return {
    -- hide_tab_bar_if_only_one_tab	= true,
    window_padding = {
      left = 0, right = 0,
      top = 0, bottom = 0,
    }
}