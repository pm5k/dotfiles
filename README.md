# PM5K's dotfiles

## Description

My collection of configuration files.
Includes things like:

- neovim
- tmux
- starship
- zshrc
- wezterm (Windows mainly..)

## Prerequisites

- All those apps installed

(Autoscript coming soon TM)

## Caveats

### Windows

1. Download and install Scoop
2. Use scoop to install Zig
3. Install ripgrep
4. Install

`(nightly neovim from here..)`

5. `scoop bucket add versions`
6. `scoop install neovim-nightly`

`(..to here)`

Or..

`scoop install neovim`

Also clone this repo into your user folder preferably under `.config` and then symlink `nvim` into %LOCALAPPDATA% so neovim can pick up the configs.
An example of this could be:
```powershell
New-Item -ItemType SymbolicLink -Path "C:\Users\<YOU>\AppData\Local\nvim" -Target "C:\Users\<YOU>\.config\nvim"
```



### Linux

1. `.zshrc` being inside of `~/.config` means that it needs to be sourced via `.zshenv` using `ZDOTDIR=~/.config`.

## TODO

- Separate stuff inside kickstart into separate configs
- Add more shit to configure..
