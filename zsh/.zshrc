# init brew
if command -v brew >/dev/null 2>&1; then
  brew_prefix=$(brew --prefix)
  if [ -d "$brew_prefix/share/zsh/site-functions" ]; then
    fpath=($brew_prefix/share/zsh/site-functions $fpath)
  fi
fi

# load completions
autoload -U compinit && compinit

# history settings
HISTSIZE="1000000"
SAVEHIST="1000000"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history
setopt share_history

# Prompt settings
DISABLE_AUTO_TITLE=false
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

ssh_indicator() {
  if [[ -n "$SSH_CONNECTION" || -n "$SSH_CLIENT" ]]; then
    echo "%B%F{yellow}[SSH] %f%b"
  fi
}

PROMPT='$(ssh_indicator)%B%F{243}%n %bon %B%m%f%b %B%F{197}%2~%f%b %B%F{39}$vcs_info_msg_0_%f%b> '

if [[ -n "$FLAKE_SHELL" ]]; then
  PROMPT="%B%F{green}[flake shell]%f%b $PROMPT"
fi

# aliases
alias -- grep='grep --color'
alias -- ip='ip --color'
alias -- la='ls -lah --color'
alias -- ls='ls --color'
alias -- vim=nvim
alias -- gcachestat='sudo CCACHE_DIR="/var/cache/ccache" ccache -sv'

# tmux aliases.
alias t='tmux new-session -A -s "$(basename $PWD)-$(echo -n $PWD | shasum -a 256 | cut -c1-4)"'
alias tl="tmux list-sessions -F '#{?session_attached,(attached),          } #{session_name}: #{session_windows} #{?#{==:#{session_windows},1},window,windows} #{session_path} (created #{t:session_created})' 2>/dev/null || echo no sessions."
alias 'to'='tmux attach-session -t'

# Sesssion variables 
export EDITOR=nvim
export VISUAL=nvim
export PATH="/Users/devin/Developer/clones/googlesource/depot_tools:$PATH"

eval "$(direnv hook zsh)"
