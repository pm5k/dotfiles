local wezterm = require "wezterm"

return {
    default_domain = "WSL:Arch", --
    default_prog = { "wsl" },
    default_cwd = "~",
    launch_menu = {
        {
            label = "Windows Power Shell 7",
            args = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" },
            domain = { DomainName = "local" },
        },
        {
            label = "Vlad Diffusion",
            args = {
                "D:\\vlad_diffusion\\webui-user.bat"
            },
            cwd = "D:\\vlad_diffusion",
            domain = { DomainName = "local" },
        },
        {
            label = "Vlad Diffusion - Upgrade",
            args = {
                "D:\\vlad_diffusion\\webui-upgrade.bat"
            },
            cwd = "D:\\vlad_diffusion",
            domain = { DomainName = "local" },
        },
    },
}
