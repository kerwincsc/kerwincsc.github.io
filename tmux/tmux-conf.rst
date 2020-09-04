[ITMUX] 配置
======================================================================

::

   # Send prefix
   unbind-key C-b
   #set -g prefix C-a
   set -g prefix F8
   bind C-a send-prefix

   # Set allow-rename to off to prevent auto-rename
   set-option -g allow-rename off
   # make the index of windows start at 1
   set -g base-index 1
   # make the index of pane start at 1
   set -g pane-base-index 1

   # tmux-prefix-highlight
   # It doesn't work! I don't know why!
   set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
   set -g @prefix_highlight_fg 'white' # default is 'colour231'
   set -g @prefix_highlight_bg 'blue'  # default is 'colour04'
   set -g @prefix_highlight_show_copy_mode 'on'
   set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold' # default is 'fg=default,bg=yellow'
   set -g @prefix_highlight_prefix_prompt 'Wait'
   set -g @prefix_highlight_copy_prompt 'Copy'
   
   set -g @plugin 'tmux-plugins/tpm'
   set -g @plugin 'tmux-plugins/tmux-sensible'
   set -g @plugin 'tmux-plugins/tmux-resurrect'
   
   run -b '~/.tmux/plugins/tpm/tpm'
