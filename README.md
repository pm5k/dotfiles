# PM5K's Dotfiles Configuration

## 📁 Directory Structure

```
.config/
├── .zshrc
├── .gitignore
├── zsh-modules/          # Modular ZSH configuration
│   ├── exports.zsh       # Environment variables
│   ├── functions.zsh     # Helper functions
│   ├── plugins.zsh       # Oh My ZSH plugins
│   ├── aliases.zsh       # Command aliases
│   └── node.zsh          # Node.js/NVM configuration
├── nvim/
├── tmux/
│   ├── tmux.conf
│   └── plugins/          # TPM plugins
├── starship/
│   └── starship.toml
├── posting/              # Posting API client
│   └── config.yaml
└── wezterm/              # WezTerm terminal (config pending)
```

## 🚀 Core Components

### Shell Environment (ZSH)

- **Base**: ZSH + Oh My ZSH
- **Prompt**: Starship cross-shell prompt with Catppuccin Frappe theme

## 🛠️ Development Tools

### Terminal & Shell
- **Terminal Emulator**: WezTerm (configuration pending)
- **Shell**: ZSH with Oh My ZSH framework
- **Prompt**: Starship with Catppuccin Frappe theme
- **Multiplexer**: Tmux with custom configuration

### Command Line Tools
- **File Management**: 
  - `eza` - Modern replacement for ls with icons and git integration
- **Search**: 
  - `fzf` - Fuzzy finder for history and files
- **API Testing**: 
  - `posting` - TUI HTTP client

## 📦 Installation

### Prerequisites (Linux)

1. **Core Shell**:
   ```bash
   # Install ZSH
   yay -S zsh
   
   # Set ZDOTDIR in ~/.zshenv to use .config directory
   echo 'ZDOTDIR=~/.config' >> ~/.zshenv
   
   # Install Oh My ZSH
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   
   # Install ZSH plugins
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
   git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
   ```

2. **Essential Tools**:
   ```bash
   # Eza (modern ls)
   yay -S eza
   
   # Starship prompt
   yay -S starship
   
   # FZF
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   
   # Ripgrep (for searching)
   sudo pacman -S ripgrep
   ```

3. **Development Tools**:
   ```bash
   # Neovim
   # Install from package manager or build from source
   
   # Tmux
   sudo pacman -S tmux
   
   # TPM (Tmux Plugin Manager)
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```

4. **Language Runtimes**:
   ```bash
   # Node.js (via NVM - will be installed by zsh-nvm plugin)
   nvm install node
   
   # Bun
   curl -fsSL https://bun.sh/install | bash
   ```

## 🔧 Configuration Notes

### PATH Management
The configuration uses a `add_to_path` function that:
- Checks if directory exists before adding
- Prevents duplicate PATH entries
- Supports prepending or appending to PATH

## 📚 Resources

- [Oh My ZSH](https://ohmyz.sh/)
- [Starship Prompt](https://starship.rs/)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)
- [Eza](https://github.com/eza-community/eza)

