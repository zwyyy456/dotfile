function vi_fish_keybindings
    fish_default_key_bindings -M insert

    fish_vi_key_bindings --no-erase insert
    set -g fish_bind_mode insert
    bind --mode insert --sets-mode default jk repaint
end
