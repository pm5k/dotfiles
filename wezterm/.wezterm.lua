local wezterm = require 'wezterm'
local conftable = require 'helpers'.conftable

local config = {
    automatically_reload_config     = true,
    window_close_confirmation       = "NeverPrompt",
    check_for_updates               = true,
    front_end                       = "WebGpu",
    webgpu_power_preference         = "HighPerformance",
    max_fps                         = 165,
    use_fancy_tab_bar               = true,
    disable_default_key_bindings    = true,
    hyperlink_rules                 = wezterm.default_hyperlink_rules(),
    keys = {
        {
            key = "V",
            mods = "CTRL",
            action = wezterm.action.PasteFrom 'Clipboard',
        },
        {
            key = "V",
            mods = "CTRL",
            action = wezterm.action.PasteFrom 'PrimarySelection',
        },
    }
}

local full_config = conftable.merge_all(
    config,
    require("font"),
    require("colors"),
    require("window"),
    require("launch"),
    require("input"),
    {}
)

return full_config
