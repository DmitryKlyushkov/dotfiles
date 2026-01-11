# Prompt
set -g tide_prompt_pad_items true

# Left Prompt
set -g tide_left_prompt_items pwd git newline character 
set -g tide_left_prompt_prefix "╭─"
set -g tide_left_prompt_separator_diff_color \ue0b0
set -g tide_left_prompt_suffix \ue0b0
# PWD Settings
set -g tide_pwd_bg_color 78f09a
set -g tide_pwd_color_dirs 21222c
set -g tide_pwd_color_anchors 21222c
# Git Settings
set -g tide_git_bg_color f1fa8c
set -g tide_git_bg_color_unstable f1fa8c
set -g tide_git_color_branch 21222c
set -g tide_git_icon \ue725 
set -g tide_git_color_conflicted 21222c
set -g tide_git_color_dirty 21222c
set -g tide_git_color_operation 21222c
set -g tide_git_color_staged 21222c
set -g tide_git_color_stash 21222c
set -g tide_git_color_untracked 21222c
set -g tide_git_color_upstream 21222c
# Character Settings
set -g tide_character_icon "╰─➤"
set -U tide_character_vi_icon_insert  "╰─➤"
set -U tide_character_vi_icon_default "╰─➤"
set -U tide_character_vi_icon_replace "╰─➤"
set -g tide_character_color 78f09a

# Right Prompt
set -g tide_right_prompt_items time
set -g tide_right_prompt_prefix \ue0b6
set -g tide_right_prompt_suffix \ue0b4
# Time Settings
set -g tide_time_bg_color bd93f9
set -g tide_time_color 21222c
set -g tide_time_format "%H:%M:%S"

