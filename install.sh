#!/data/data/com.termux/files/usr/bin/bash

set -e

APP_DIR="$HOME/.termux-pro"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
BASHRC="$HOME/.bashrc"
START="# >>> TERMUX PRO MAX START >>>"
END="# <<< TERMUX PRO MAX END <<<"

echo "Installing TERMUX PRO MAX..."

if [ ! -f "$SOURCE_DIR/termux-pro.sh" ]; then
    echo "Error: termux-pro.sh not found."
    exit 1
fi

mkdir -p "$APP_DIR"

# Keep a backup before changing .bashrc
if [ -f "$BASHRC" ]; then
    cp -n "$BASHRC" "$BASHRC.termux-pro-backup"
else
    touch "$BASHRC"
fi

# Copy the dashboard
cp "$SOURCE_DIR/termux-pro.sh" "$APP_DIR/termux-pro.sh"
chmod 700 "$APP_DIR/termux-pro.sh"

# Add startup block only once
if ! grep -Fq "$START" "$BASHRC"; then
    {
        echo
        echo "$START"
        echo 'case $- in'
        echo '  *i*) bash "$HOME/.termux-pro/termux-pro.sh" ;;'
        echo 'esac'
        echo "$END"
    } >> "$BASHRC"
fi

echo
echo "Installation complete!"
echo "Restart Termux or run: source ~/.bashrc"