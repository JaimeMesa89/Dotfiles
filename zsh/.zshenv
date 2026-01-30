# Default programs
export EDITOR="nvim"
export BROWSER="firefox"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# XDG base directories (keep $HOME clean)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Add Paths
export PATH="$HOME/.local/bin:$PATH"

# Add scripts to PATH
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"

# History files outside $HOME
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"

# source /opt/esp/esp-idf/export.sh > /dev/null 2>&1
idf.py() {
  unset -f idf.py
  source /opt/esp/esp-idf/export.sh > /dev/null 2>&1
  command idf.py "$@"
}
