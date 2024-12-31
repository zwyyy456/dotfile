if status is-interactive
    # Commands to run in interactive sessions can go here
    for file in $__fish_config_dir/{0,1}*-*.fish
        . $file
    end
end
