export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(starship init zsh)"


alias ls="exa -l --icons"
alias la="exa -la --icons"
