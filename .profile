echo "Loading .profile"
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export HOMEBREW_NO_ANALYTICS=1

export PATH=/usr/local/Cellar/openssl/1.0.2n/bin:$PATH
export PATH=/Users/dmitry/Library/Python/2.7/bin:$PATH
export PATH=/usr/local/bin:$PATH

  if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
eval "$(aliases init --global)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
