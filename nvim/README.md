# My shitty neovim config

- It needs more work.
- It was based on kickstart and then diverged.. a lot.
- It's constantly in flux.

## Layout

Trying to keep to a consistent layout where:

1. Any plugin that is installed and managed by Lazy should go into `lua/pm5k/configs`.
2. Custom lua configs sit under `lua/pm5k` including Lazy itself.
3. `after/plugin` loads all the config for the remainder.
4. `unused` is for future stuff, and as a graveyard for stuff I can't bring myself to YAGNI.

## Misc

- Feel free to yoink
- Don't come and yell at me about styling/formatting
- What is a vimscript?