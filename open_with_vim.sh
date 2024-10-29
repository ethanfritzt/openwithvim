#!/bin/bash
# Save this as ~/.local/share/nautilus/scripts/Open with Vim

# Get terminal emulator (prefer gnome-terminal if available)
if command -v gnome-terminal &> /dev/null; then
    TERM_EMU="gnome-terminal --"
elif command -v xterm &> /dev/null; then
    TERM_EMU="xterm -e"
else
    notify-send "Error" "No suitable terminal emulator found"
    exit 1
fi

# Handle each selected file
for file in "$@"; do
    # Convert file URI to path if needed
    if [[ "$file" == file://* ]]; then
        file="${file#file://}"
    fi
    
    # URL decode the path
    file=$(printf '%b' "${file//%/\\x}")
    
    # Launch vim in terminal
    $TERM_EMU vim "$file"
done