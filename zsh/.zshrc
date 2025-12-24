# Prompt
PROMPT_INSERT='%F{blue}%B%~%b%f %F{green}❯%f '
PROMPT_NORMAL='%F{blue}%B%~%b%f %F{red}❯%f '

PROMPT=$PROMPT_INSERT  # initial prompt

# Vim-mode aware prompt
_prompt_vi_mode() {
  if [[ $KEYMAP == vicmd ]]; then
    PROMPT=$PROMPT_NORMAL   # NORMAL mode: red
  else
    PROMPT=$PROMPT_INSERT   # INSERT mode: green
  fi
  zle reset-prompt
}

zle -N zle-keymap-select _prompt_vi_mode # select correct prompt when changing modes
zle -N zle-line-init _prompt_vi_mode # select prompt when initialized

export KEYTIMEOUT=1 # disable cursor blink on normal mode

# History
HISTFILE=~/.zsh_history      # history file location
HISTSIZE=100000              # max number of history lines kept in memory
SAVEHIST=100000              # max number of history lines saved to $HISTFILE
setopt hist_ignore_dups      # ignore duplicate consecutive entries
setopt hist_ignore_space     # ignore commands that start with a space
setopt hist_reduce_blanks    # remove superfluous blanks before saving to history
setopt share_history         # share history between sessions (merge on the fly)
setopt inc_append_history    # immediately add command to $HISTFILE when executed
setopt append_history        # append to history file instead of overwriting it

# General options
setopt auto_cd               # allow `dir` instead of `cd dir`
setopt extended_glob         # enable advanced pattern (globs) features
setopt interactive_comments  # allow comments in interactive shell lines
unsetopt beep                # disable terminal bell

# Keybindings
bindkey -v                               # Vim mode for line editing
bindkey -M vicmd 'H' beginning-of-line   # H to beginning of line in command mode
bindkey -M vicmd 'L' end-of-line         # L to end of line in command mode
bindkey "\e[A" history-beginning-search-backward  # Up arrow: search backward in history by current prefix
bindkey "\e[B" history-beginning-search-forward   # Down arrow: search forward in history by current prefix

# Completion
autoload -Uz compinit    # load completion system
compinit                 # initialize completion system
zmodload zsh/complist    # enhanced completion interface

zstyle ':completion:*' menu select        # use a menu interface for completions (navigate with arrows)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'  # case-insensitive + flexible separators

# Terminal title
precmd() {
  print -Pn '\e]2;%n@%m: %~\a'            # set terminal title to user@host: path
}

# Aliases
alias v='nvim'
alias o='xdg-open'
alias yt-get-wav='yt-dlp -x --audio-format wav --audio-quality 0'

## Yazi file manager
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

## Safety aliases
alias rm='rm -i'          # confirm before removing files
alias cp='cp -i'          # confirm before overwriting on copy
alias mv='mv -i'          # confirm before overwriting on move

## Color
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'

# Plugins
## fzf integration
# - Ctrl+T : fuzzy file finder
# - Ctrl+R : fuzzy history search
# - Alt+C  : fuzzy cd into directories
eval "$(fzf --zsh)"

## Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# opencode
export PATH=/home/junk/.opencode/bin:$PATH
