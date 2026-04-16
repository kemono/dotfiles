# Function to launch Emacs with automatic mode selection based on environment
function emacs-launcher
    # Check if DISPLAY environment variable is set
    # If set: launch GUI mode (X11 or WSLg)
    # If not set: launch CLI mode (-nw)
    if set -q DISPLAY
        # GUI launch (X11 or WSLg)
        emacsclient -c -a ""
    else
        # CLI launch (within terminal)
        emacsclient -nw -a ""
    end
end
