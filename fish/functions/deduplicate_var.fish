function deduplicate_var --description 'Remove duplicates from a colon-separated variable'
    set -l var_name $argv[1]
    set -l values (string split ':' $$var_name)
    set -l unique_values

    for value in $values
        if not contains $value $unique_values
            set -a unique_values $value
        end
    end

    set -gx $var_name (string join ':' $unique_values)
end
