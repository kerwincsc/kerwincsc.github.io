TMUX 配置
======================================================================

::

   # Send prefix
   unbind-key C-b
   set -g prefix C-a
   bind C-a send-prefix
   # Set allow-rename to off to prevent auto-rename
   set-option -g allow-rename off
   # make the index of windows start at 1
   set -g base-index 1
   # make the index of pane start at 1
   set -g pane-base-index 1
   
   set -g @plugin 'tmux-plugins/tpm'
   set -g @plugin 'tmux-plugins/tmux-sensible'
   set -g @plugin 'tmux-plugins/tmux-resurrect'
   
   run -b '~/.tmux/plugins/tpm/tpm'
