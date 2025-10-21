autoload -U compinit && compinit
# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="1000000"
SAVEHIST="1000000"

HISTFILE="/home/devin/.zsh_history"
#mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK

# Enabled history options
enabled_opts=(
  APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
)
for opt in "${enabled_opts[@]}"; do
  setopt "$opt"
done
unset opt enabled_opts

# Disabled history options
disabled_opts=(
  EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS
  HIST_SAVE_NO_DUPS
)
for opt in "${disabled_opts[@]}"; do
  unsetopt "$opt"
done
unset opt disabled_opts

DISABLE_AUTO_TITLE=false
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%B%F{243}%n %bon %B%m%f%b %B%F{197}%2~%f%b %B%F{39}$vcs_info_msg_0_%f%b> '
eval "$(~/.local/bin/mise activate)"

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

alias -- grep='grep --color'
alias -- ip='ip --color'
alias -- la='ls -lah --color'
alias -- ls='ls --color'
alias -- vim=nvim
