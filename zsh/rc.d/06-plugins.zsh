##
# Plugins
#

# Add the plugins you want to use here.
# For more info on each plugin, visit its repo at github.com/<plugin>
# -a sets the variable's type to array.
local -a plugins=(
    zsh-users/zsh-autosuggestions       # Inline suggestions
    zsh-users/zsh-syntax-highlighting   # Command-line syntax highlighting
    marlonrichert/zsh-edit              # Better keyboard shortcuts
    marlonrichert/zsh-hist              # Edit history from the command line.
    marlonrichert/zcolors               # Colors for completions and Git
    # marlonrichert/zsh-autocomplete    # Real-time type-ahead completion
    Aloxaf/fzf-tab                      # completion through fzf
    skywind3000/z.lua                   # A new cd command that helps you navigate faster by learning your habits
    jeffreytse/zsh-vi-mode              # vi mode for zsh
)

# The Zsh Autocomplete plugin sends *a lot* of characters to your terminal.
# This is fine locally on modern machines, but if you're working through a slow
# ssh connection, you might want to add a slight delay before the
# autocompletion kicks in:
#   zstyle ':autocomplete:*' min-delay 0.5  # seconds
#
# If your connection is VERY slow, then you might want to disable
# autocompletion completely and use only tab completion instead:
#   zstyle ':autocomplete:*' async no


# Speed up the first startup by cloning all plugins in parallel.
# This won't clone plugins that we already have.
znap clone $plugins

# Load each plugin, one at a time.
local p=
for p in $plugins; do
  znap source $p
done

znap source ohmyzsh/ohmyzsh lib/clipboard
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/copypath
znap source ohmyzsh/ohmyzsh plugins/copybuffer
# znap source ohmyzsh/ohmyzsh plugins/copyfile

# `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
# caching and compilation of <command>'s output, making it ~10 times faster.
znap eval zcolors zcolors   # Extra init code needed for zcolors.
