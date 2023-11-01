PATH=$PATH:"$HOME/.local/bin"

HISTDIR="$XDG_STATE_HOME/zsh"
HISTFILE="$HISTDIR/history"
HISTSIZE=1000
SAVEHIST=1000

ZCOMP_CACHE_DIR="$XDG_CACHE_HOME/zsh/zcompcache"

bindkey -v

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

zstyle ':completion:*' use-cache on

zstyle ':completion:*' cache-path "$ZCOMP_CACHE_DIR" # Custom cache path

zstyle ':completion:*' menu select # Add completion selection menu

setopt autocd # Automatically cd to typed dir

autoload -Uz compinit promptinit
compinit -d "$ZCOMP_CACHE_DIR/zcompdump-$ZSH_VERSION"
promptinit

source "$XDG_CONFIG_HOME/shell/aliases"

# Function for displaying git prompt
git_prompt(){
    local branch="$(git symbolic-ref HEAD 2>/dev/null | cut -d '/' -f 3)"
    local branch_truncated="${branch:0:30}"

    # IF branch length is gt 30 then truncate branch
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    # IF branch length is non zero echo the branch output
    [ -n "${branch}"  ] && echo " (${branch})"
}

setopt PROMPT_SUBST
PROMPT='[%F{80}%n%f%F{159}@%f%F{75}%m%f %F{189}%~%f] %#%F{93}$(git_prompt)%f '

# Source syntax highlight
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Source node version manager
source $XDG_CONFIG_HOME/nvm/nvm.sh
