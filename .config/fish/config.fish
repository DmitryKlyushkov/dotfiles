set -gx TERM xterm-kitty
set -gx EDITOR nvim
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx RIPGREP_CONFIG_PATH ~/.config/.ripgreprc

# Fish Greeting
set -g fish_greeting ""

# Fish Aliases
alias ll "ls -la"
alias cc "clear"
command -qv nvim && alias vim nvim

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
