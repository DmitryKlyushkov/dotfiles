set -gx TERM xterm-kitty
set -gx EDITOR nvim
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx RIPGREP_CONFIG_PATH ~/.config/.ripgreprc
set -gx BROWSER vivaldi-snapshot

# Fish Greeting
set -g fish_greeting ""

# Fish Aliases
alias ll "eza -lgaaBb"
alias cc "clear"
alias bb "cd .."
command -qv nvim && alias vim nvim

# Custom functions
# Open this neovim session (os session_name)
function os
    nvim -S ~/.config/nvim/sessions/$argv[1].vim
end
# Delete this neovim session (ds session_name)
function ds
  rm ~/.config/nvim/sessions/$argv[1].vim
end
# Echo all neovim sessions
function es
  ll ~/.config/nvim/sessions/
end

# Custom Keybindings
function fish_user_key_bindings
  # Vim-like accept suggestion
  bind \cl forward-char
  # Scroll up/down
  bind \ck up-or-search 
  bind \cj down-or-search 
  # Delete a line
  bind \ew backward-kill-line
end
