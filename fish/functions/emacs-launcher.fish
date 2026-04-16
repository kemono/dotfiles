# Function to launch Emacs with automatic mode selection and maximization
function emacs-launcher
    # Capture all arguments passed to the function (e.g., filenames)
    set -l args $argv

    # Check if DISPLAY environment variable is set
    if set -q DISPLAY
        # GUI launch (X11 or WSLg)
        emacsclient -c -F '((fullscreen . maximized))' -a "" $args
    else
        # CLI launch (within terminal)
        emacsclient -nw -a "" $args
    end
end
