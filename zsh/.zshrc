export PATH=$PATH:/home/jdranpariya/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/jdranpariya/.mujoco/mujoco210/bin
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/home/jdranpariya/.nvm/versions/node/v20.7.0


alias ls="exa -l --icons"
alias la="exa -la --icons"
alias vim="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jdranpariya/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jdranpariya/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jdranpariya/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jdranpariya/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
export CONDA_CHANGEPS1=false
# <<< conda initialize <<<

eval "$(starship init zsh)"
