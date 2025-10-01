# ~/.zshrc - Zsh Configuration

# ============================================================================
# Environment Variables
# ============================================================================
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export GIT_EDITOR=nvim
export STARSHIP_CONFIG=~/.config/starship/config.toml
export MISE_NIX_ALLOW_LOCAL_FLAKES=true
export OLLAMA_KEEP_ALIVE=1h
export PNPM_HOME="/home/erik/.local/share/pnpm"

# ============================================================================
# History Configuration
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt HIST_VERIFY            # Show command before executing from history
setopt INC_APPEND_HISTORY     # Write to history immediately

# ============================================================================
# Key Bindings
# ============================================================================
# History search with prefix matching
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^P' up-line-or-beginning-search      # Ctrl+P for prefix history search
bindkey '^N' down-line-or-beginning-search    # Ctrl+N for prefix history search
bindkey '^R' history-incremental-search-backward  # Ctrl+R for fuzzy history search

# ============================================================================
# Completion System
# ============================================================================
autoload -Uz compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Menu-style completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Better completion behavior
zstyle ':completion:*:cd:*' ignore-parents parent pwd  # Don't offer .. as completion for cd
zstyle ':completion:*' squeeze-slashes true            # Normalize slashes in paths

# ============================================================================
# Auto-suggestions
# ============================================================================
if [[ ! -d ~/.zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions
fi
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # Gray color for suggestions

# Accept autosuggestion with Ctrl+Y
bindkey '^Y' autosuggest-accept

# ============================================================================
# Vi mode configuration
# ============================================================================

bindkey -v
export KEYTIMEOUT=1

bindkey "^F" history-incremental-search-forward
bindkey "^R" history-incremental-search-backward
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

ZVM_CURSOR_STYLE_ENABLED=false

# ============================================================================
# FZF Configuration
# ============================================================================
FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_ALT_C_COMMAND=
FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=right:50%'

# ============================================================================
# Tool Initialization
# ============================================================================
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(direnv hook zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ============================================================================
# Aliases
# ============================================================================

alias cl='clear'

# Navigation
alias cd='z'

# File listing (eza)
alias l='eza -la --git'
alias ls='eza --icons'
alias lt='eza --tree --icons'
alias ll='eza -la --icons --git'
alias la='eza -la --icons'
alias lg='eza -la --icons --git --header'

# Git
alias lz='lazygit'

alias avante='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'

