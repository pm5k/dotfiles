local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size  = false,
    allow_square_glyphs_to_overflow_width       = "WhenFollowedBySpace",
    font                                        = wezterm.font 'FiraCode Nerd Font',
    font_size                                   = 13,
}
