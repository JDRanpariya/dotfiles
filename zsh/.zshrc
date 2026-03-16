export PATH=$PATH:/home/jdranpariya/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/jdranpariya/.mujoco/mujoco210/bin
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/home/jdranpariya/.nvm/versions/node/v20.7.0

# Include local bin in path
PATH=$PATH:~/.local/bin

# Eza
alias ls="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias vim="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jdranpariya/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jdranpariya/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jdranpariya/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jdranpariya/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"

bindkey jk vi-cmd-mode
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/jdranpariya/.bun/_bun" ] && source "/Users/jdranpariya/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export TEXINPUTS=".:/Users/jdranpariya/sTeX//:$TEXINPUTS"
