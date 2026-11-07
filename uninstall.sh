#!/data/data/com.termux/files/usr/bin/bash

set -e

BASHRC="$HOME/.bashrc"
START="# >>> TERMUX PRO MAX START >>>"
END="# <<< TERMUX PRO MAX END <<<"

echo "Removing TERMUX PRO MAX startup configuration..."

if [ -f "$BASHRC" ]; then
    TEMP_FILE="$(mktemp)"

    awk -v start="$START" -v end="$END" '
        $0 == start { skip=1; next }
        $0 == end   { skip=0; next }
        !skip       { print }
    ' "$BASHRC" > "$TEMP_FILE"

    cat "$TEMP_FILE" > "$BASHRC"
    rm -f "$TEMP_FILE"
fi

rm -rf "$HOME/.termux-pro"

echo "TERMUX PRO MAX removed."
echo "Your original .bashrc backup, if created, is preserved."