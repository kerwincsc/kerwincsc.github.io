TMUX 配置
======================================================================

.. code-block:: tmux

   # Send prefix
   unbind-key C-b
   set -g prefix C-a
   bind C-a send-prefix
   # Set allow-rename to off to prevent auto-rename
   set-option -g allow-rename off
   set -g base-index 1
   set -g pane-base-index 1
   
   set -g @plugin 'tmux-plugins/tpm'
   set -g @plugin 'tmux-plugins/tmux-sensible'
   set -g @plugin 'tmux-plugins/tmux-resurrect'
   
   run -b '~/.tmux/plugins/tpm/tpm'
