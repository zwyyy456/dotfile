#!/bin/zsh

##
# Prompt theme
#

# Reduce startup time by making the left side of the primary prompt visible
# *immediately.*
print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}
znap prompt sindresorhus/pure

# `znap prompt` can autoload our prompt function, because in 04-env.zsh, we
# added its parent dir to our $fpath.
