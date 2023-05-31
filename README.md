# PM5K's dotfiles

## Description

My collection of configuration files.
Includes things like:

- neovim
- tmux
- starship
- zshrc

## Prerequisites

- All those apps installed

(Autoscript coming soon TM)

## Caveats

### Windows

1. A lot of stuff requires mingw, cmake, make and installs via choco

### Linux

1. `.zshrc` being inside of `~/.config` means that it needs to be sourced via `.zshenv` using `ZDOTDIR=~/.config`.
