function fcopy -d "Copy file or stdin to clipboard"
    if test (count $argv) -gt 0
        if not test -f $argv[1]
            echo "Error: File '$argv[1]' not found."
            return 1
        end
        fish_clipboard_copy < $argv[1]
        echo "Copied '$argv[1]' to clipboard."
    else
        fish_clipboard_copy
        echo "Copied stdin to clipboard."
    end
end
