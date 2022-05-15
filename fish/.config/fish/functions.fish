# Vim bindings
# function my_vi_bindings
#   ## Without --no-erase fish_vi_key_bindings will default to
#   ## resetting all bindings.
#   ## The argument specifies the initial mode (insert, "default" or visual).
#   fish_vi_key_bindings
#   set fish_cursor_default block
#   set fish_cursor_insert line
#   bind -M insert -m default jj backward-char force-repaint
# end

# function my_default_bindings
#   fish_default_key_bindings
#   set -g fish_cursor_default underscore
# end

#set -g fish_key_bindings my_vi_bindings

#function fish_user_key_bindings
    ## Execute this once per mode that emacs bindings should be used in
    #fish_default_key_bindings -M insert

    ## Then execute the vi-bindings so they take precedence when there's a conflict.
    ## Without --no-erase fish_vi_key_bindings will default to
    ## resetting all bindings.
    ## The argument specifies the initial mode (insert, "default" or visual).
    #fish_vi_key_bindings --no-erase insert
#end
