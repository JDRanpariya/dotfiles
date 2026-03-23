# My Dotfiles

## Supported OS
- Linux (Ubuntu, Arch, Fedora, etc.)
- macOS (with some limitations)

## Applications and Tools

### Shell
- Zsh (with custom configuration)

### Terminal
- Ghostty (modern, fast terminal emulator)

### Editor
- Neovim (with Lua-based configuration)

### Window Management
- Aerospace (tiling window manager for macOS)
- sxhkd (Simple X Hotkey Daemon for Linux/X11)

### Shell Prompt
- Starship (cross-shell prompt)

### Utilities
- direnv (environment variable management)
- password-store (pass) (password management)
- tmux (terminal multiplexer)
- wall (wallpaper management)

### Configuration
- bash (Bash shell configurations)
- X11 (X11 resources and settings)
- bin (custom scripts and executables)
- direnv (direnv configuration)
- nvim (Neovim configuration)
- ghostty (Ghostty terminal configuration)
- starship (Starship prompt configuration)
- sxhkd (sxhkd keybindings)
- tmux (tmux configuration)
- wall (wallpaper scripts)
- zsh (Zsh shell configuration)

## Installation
These dotfiles are designed to be managed with GNU Stow. To install:

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Install using Stow (example for neovim and zsh)
stow nvim zsh

# Or install all
stow *
```

## Notes
- Some configurations are specific to certain operating systems
- Review each component's README or documentation for specific setup instructions
- Backup your existing configurations before installing
