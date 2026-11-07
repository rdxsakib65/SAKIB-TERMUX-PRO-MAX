#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# SAKIB TERMUX PRO MAX
# ULTRA EDITION V2.0
# Creator: MODE BOY PNL SAKIB
# ==========================================

APP="$HOME/.termux-pro-max"
CONFIG="$APP/config"
mkdir -p "$APP"

RESET='\033[0m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
WHITE='\033[1;37m'

USERNAME="MODE BOY PNL SAKIB"
THEME="PURPLE"

[ -f "$CONFIG" ] && source "$CONFIG"

set_theme() {
    case "$THEME" in
        CYAN)
            TITLE='\033[1;36m'
            ;;
        GREEN)
            TITLE='\033[1;32m'
            ;;
        RED)
            TITLE='\033[1;31m'
            ;;
        YELLOW)
            TITLE='\033[1;33m'
            ;;
        *)
            TITLE='\033[1;35m'
            ;;
    esac
}

save_config() {
    cat > "$CONFIG" <<EOF
USERNAME='$USERNAME'
THEME='$THEME'
EOF
}

pause() {
    echo
    read -r -p "Press Enter to continue..."
}

line() {
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

root_status() {
    if [ "$(id -u 2>/dev/null)" = "0" ]; then
        printf "${GREEN}ROOTED${RESET}"
    elif command -v su >/dev/null 2>&1; then
        printf "${YELLOW}UNKNOWN (su detected)${RESET}"
    else
        printf "${RED}NON-ROOT / NOT DETECTED${RESET}"
    fi
}

get_device() {
    local brand model
    brand=$(getprop ro.product.manufacturer 2>/dev/null)
    model=$(getprop ro.product.model 2>/dev/null)

    echo "${brand:-Unknown} ${model:-Device}"
}

header() {
    clear
    set_theme

    line
    printf "${TITLE}"
    cat <<'EOF'
  ████████╗██████╗ ███╗   ███╗
     ██║   ██╔══██╗████╗ ████║
     ██║   ██████╔╝██╔████╔██║
     ██║   ██╔══██╗██║╚██╔╝██║
     ██║   ██║  ██║██║ ╚═╝ ██║
EOF
    printf "${RESET}"
    printf "${CYAN}       TERMUX PRO MAX${RESET}\n"
    printf "${GREEN}       ULTRA EDITION V2.0${RESET}\n"
    printf "${WHITE}       %s${RESET}\n" "$USERNAME"
    line
}

system_info() {
    header

    echo -e "${CYAN}       SYSTEM INFORMATION${RESET}"
    line

    echo "Device       : $(get_device)"
    echo "Android      : $(getprop ro.build.version.release 2>/dev/null || echo Unknown)"
    echo "Android SDK  : $(getprop ro.build.version.sdk 2>/dev/null || echo Unknown)"
    echo "Architecture : $(uname -m)"
    echo "Kernel       : $(uname -r)"
    echo "Username     : $(whoami)"
    echo "Hostname     : $(hostname)"
    echo "Shell        : ${SHELL:-Unknown}"
    echo "Root         : $(root_status)"

    echo
    echo "STORAGE:"
    df -h "$HOME" 2>/dev/null

    echo
    echo "RAM:"
    if [ -r /proc/meminfo ]; then
        awk '/MemTotal|MemAvailable/ {
            printf "%s: %.0f MB\n", $1, $2/1024
        }' /proc/meminfo
    fi

    pause
}

network_info() {
    while true; do
        header

        echo "NETWORK DIAGNOSTICS"
        line
        echo "[1] Network Interfaces"
        echo "[2] Internet Connection Test"
        echo "[3] DNS Test"
        echo "[0] Back"

        read -r -p "Select: " choice

        case "$choice" in
            1)
                if command -v ip >/dev/null 2>&1; then
                    ip -brief addr
                else
                    echo "Install iproute2 first."
                fi
                pause
                ;;
            2)
                if command -v ping >/dev/null 2>&1; then
                    ping -c 3 -W 3 1.1.1.1
                else
                    echo "Install iputils first."
                fi
                pause
                ;;
            3)
                if command -v ping >/dev/null 2>&1; then
                    ping -c 3 -W 3 google.com
                else
                    echo "Install iputils first."
                fi
                pause
                ;;
            0) return ;;
            *) echo "Invalid option."; sleep 1 ;;
        esac
    done
}

learning_menu() {
    header

    echo "CYBER SECURITY LEARNING"
    line
    echo "[1] Linux Basics"
    echo "[2] Networking Basics"
    echo "[3] Password Safety"
    echo "[4] Bash Scripting"
    echo "[5] Authorized Lab Practice"
    echo "[0] Back"

    read -r -p "Select: " choice

    case "$choice" in
        1)
            echo "Learn Linux commands:"
            echo "pwd, ls, cd, mkdir, cp, mv, cat"
            ;;
        2)
            echo "Learn IP, DNS, TCP, UDP and HTTP."
            ;;
        3)
            echo "Use unique passwords and a password manager."
            echo "Enable two-factor authentication."
            ;;
        4)
            echo "Learn variables, loops, functions and conditions."
            ;;
        5)
            echo "Practice only in your own authorized lab."
            ;;
        0) return ;;
        *) echo "Invalid option." ;;
    esac

    pause
}

programming_menu() {
    while true; do
        header

        echo "PROGRAMMING WORKSPACE"
        line
        echo "[1] Python Version"
        echo "[2] Node.js Version"
        echo "[3] Bash Version"
        echo "[4] Open Home Directory"
        echo "[5] Install Python"
        echo "[6] Install Node.js"
        echo "[0] Back"

        read -r -p "Select: " choice

        case "$choice" in
            1)
                python --version 2>&1 || echo "Python not installed."
                pause
                ;;
            2)
                node --version 2>&1 || echo "Node.js not installed."
                pause
                ;;
            3)
                bash --version | head -n 1
                pause
                ;;
            4)
                cd "$HOME" || return
                ls -lah
                pause
                ;;
            5)
                read -r -p "Install Python? (yes/no): " answer
                if [ "$answer" = "yes" ]; then
                    pkg install python -y
                fi
                pause
                ;;
            6)
                read -r -p "Install Node.js? (yes/no): " answer
                if [ "$answer" = "yes" ]; then
                    pkg install nodejs -y
                fi
                pause
                ;;
            0) return ;;
            *) echo "Invalid option."; sleep 1 ;;
        esac
    done
}

file_manager() {
    local path
    path="$HOME"

    while true; do
        header

        echo "FILE MANAGER"
        line
        echo "Current directory: $path"
        echo
        ls -lah "$path" 2>/dev/null || echo "Cannot read directory."

        echo
        echo "[1] Open another directory"
        echo "[2] View a text file"
        echo "[3] Return to Home"
        echo "[0] Back"

        read -r -p "Select: " choice

        case "$choice" in
            1)
                read -r -p "Directory path: " newpath
                if [ -d "$newpath" ] && [ -r "$newpath" ]; then
                    path=$(realpath "$newpath" 2>/dev/null || echo "$newpath")
                else
                    echo "Directory not found or not readable."
                    pause
                fi
                ;;
            2)
                read -r -p "File path: " filepath
                if [ -f "$filepath" ] && [ -r "$filepath" ]; then
                    echo
                    head -n 80 "$filepath"
                else
                    echo "File not found or not readable."
                fi
                pause
                ;;
            3)
                path="$HOME"
                ;;
            0) return ;;
            *) echo "Invalid option."; sleep 1 ;;
        esac
    done
}

settings_menu() {
    while true; do
        header

        echo "SETTINGS"
        line
        echo "[1] Change Theme"
        echo "[2] Change Username"
        echo "[3] Show Current Settings"
        echo "[0] Back"

        read -r -p "Select: " choice

        case "$choice" in
            1)
                echo "PURPLE / CYAN / GREEN / RED / YELLOW"
                read -r -p "Theme: " newtheme
                newtheme=$(echo "$newtheme" | tr '[:lower:]' '[:upper:]')

                case "$newtheme" in
                    PURPLE|CYAN|GREEN|RED|YELLOW)
                        THEME="$newtheme"
                        save_config
                        echo "Theme saved."
                        ;;
                    *)
                        echo "Invalid theme."
                        ;;
                esac
                pause
                ;;
            2)
                read -r -p "New username: " newname
                if [ -n "$newname" ]; then
                    USERNAME="$newname"
                    save_config
                    echo "Username saved."
                else
                    echo "Username cannot be empty."
                fi
                pause
                ;;
            3)
                echo "Username: $USERNAME"
                echo "Theme: $THEME"
                pause
                ;;
            0) return ;;
            *) echo "Invalid option."; sleep 1 ;;
        esac
    done
}

main_menu() {
    while true; do
        header

        echo "Date   : $(date '+%d %b %Y')"
        echo "Time   : $(date '+%I:%M:%S %p')"
        echo "Device : Android $(getprop ro.build.version.release 2>/dev/null || echo Unknown)"
        echo -n "Root   : "
        root_status
        echo

        line
        echo -e "${GREEN}[01]${RESET} SYSTEM INFORMATION"
        echo -e "${GREEN}[02]${RESET} NETWORK DIAGNOSTICS"
        echo -e "${GREEN}[03]${RESET} CYBER SECURITY LEARNING"
        echo -e "${GREEN}[04]${RESET} PROGRAMMING"
        echo -e "${GREEN}[05]${RESET} FILE MANAGER"
        echo -e "${GREEN}[06]${RESET} SETTINGS"
        echo -e "${RED}[00]${RESET} EXIT"
        line

        read -r -p "Select an option: " option

        case "$option" in
            1|01) system_info ;;
            2|02) network_info ;;
            3|03) learning_menu ;;
            4|04) programming_menu ;;
            5|05) file_manager ;;
            6|06) settings_menu ;;
            0|00)
                clear
                echo "Thank you for using SAKIB TERMUX PRO MAX!"
                exit 0
                ;;
            *)
                echo "Invalid option. Try again."
                sleep 1
                ;;
        esac
    done
}

main_menu