# Prompt
set -g tide_prompt_pad_items true

# Left Prompt
set -g tide_left_prompt_items pwd git newline character 
set -g tide_left_prompt_prefix "╭─"
set -g tide_left_prompt_separator_diff_color \ue0b0
set -g tide_left_prompt_suffix \ue0b0
# PWD Settings
set -g tide_pwd_bg_color 859900
set -g tide_pwd_color_dirs 073642
set -g tide_pwd_color_anchors 073642
# Git Settings
set -g tide_git_bg_color b58900
set -g tide_git_bg_color_unstable b58900
set -g tide_git_color_branch 073642
set -g tide_git_icon \ue725 
set -g tide_git_color_conflicted 073642
set -g tide_git_color_dirty 073642
set -g tide_git_color_operation 073642
set -g tide_git_color_staged 073642
set -g tide_git_color_stash 073642
set -g tide_git_color_untracked 073642
set -g tide_git_color_upstream 073642

set -g tide_character_icon "╰─>"
set -g tide_character_color 859900

# Right Prompt
set -g tide_right_prompt_items time
set -g tide_right_prompt_prefix \ue0b6
set -g tide_right_prompt_suffix \ue0b4
# Time Settings
set -g tide_time_bg_color 2aa198
set -g tide_time_color 002b36
set -g tide_time_format "%H:%M:%S"
