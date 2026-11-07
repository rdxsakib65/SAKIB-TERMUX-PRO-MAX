#!/data/data/com.termux/files/usr/bin/bash

# TERMUX PRO MAX — ULTRA EDITION
# MODE BOY PNL SAKIB

RESET='\033[0m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
WHITE='\033[1;37m'

line() {
    printf "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

root_status() {
    if [ "$(id -u 2>/dev/null)" = "0" ]; then
        printf "${GREEN}ROOT ACCESS: DETECTED${RESET}\n"
    elif command -v su >/dev/null 2>&1; then
        printf "${YELLOW}ROOT STATUS: POSSIBLE — NOT CONFIRMED${RESET}\n"
    else
        printf "${RED}ROOT ACCESS: NOT DETECTED${RESET}\n"
    fi
}

system_info() {
    clear
    line
    printf "${PURPLE}          SYSTEM INFORMATION${RESET}\n"
    line
    printf "${CYAN}Device OS:${RESET} "
    getprop ro.build.version.release 2>/dev/null || echo "Unknown"

    printf "${CYAN}Android SDK:${RESET} "
    getprop ro.build.version.sdk 2>/dev/null || echo "Unknown"

    printf "${CYAN}Shell:${RESET} %s\n" "$SHELL"
    printf "${CYAN}Username:${RESET} %s\n" "$(whoami 2>/dev/null)"
    printf "${CYAN}Storage:${RESET}\n"
    df -h "$HOME" 2>/dev/null | tail -n 1

    printf "${CYAN}RAM:${RESET}\n"
    if [ -r /proc/meminfo ]; then
        awk '/MemTotal|MemAvailable/ {
            printf "%s: %.0f MB\n", $1, $2/1024
        }' /proc/meminfo
    else
        echo "Unavailable"
    fi

    printf "${CYAN}Root:${RESET} "
    root_status
    line
    read -r -p "Press Enter to return..."
}

network_info() {
    clear
    line
    printf "${PURPLE}       NETWORK DIAGNOSTICS${RESET}\n"
    line
    echo "1. Show network interfaces"
    echo "2. Test internet connection"
    echo "0. Back"
    read -r -p "Select: " choice

    case "$choice" in
        1)
            if command -v ip >/dev/null 2>&1; then
                ip addr
            else
                echo "Install the iproute2 package first."
            fi
            ;;
        2)
            if command -v ping >/dev/null 2>&1; then
                ping -c 3 1.1.1.1
            else
                echo "Install the iputils package first."
            fi
            ;;
        0) return ;;
        *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter to return..."
}

learning() {
    clear
    line
    printf "${PURPLE}      CYBER SECURITY LEARNING${RESET}\n"
    line
    echo "Learn about:"
    echo "• Linux and Termux basics"
    echo "• Password safety"
    echo "• Network security concepts"
    echo "• Authorized lab practice"
    echo
    echo "Use these skills only on systems you own"
    echo "or have permission to test."
    read -r -p "Press Enter to return..."
}

main_menu() {
    while true; do
        clear
        line
        printf "${PURPLE}"
        echo "  ████████╗██████╗ ███╗   ███╗"
        echo "     ██║   ██╔══██╗████╗ ████║"
        echo "     ██║   ██████╔╝██╔████╔██║"
        echo "     ██║   ██╔══██╗██║╚██╔╝██║"
        echo "     ██║   ██║  ██║██║ ╚═╝ ██║"
        echo "${RESET}"
        printf "${CYAN}       TERMUX PRO MAX${RESET}\n"
        printf "${GREEN}       ULTRA EDITION${RESET}\n"
        printf "${WHITE}    MODE BOY PNL SAKIB${RESET}\n"
        line

        printf "${CYAN}Date:${RESET} %s\n" "$(date '+%d %b %Y')"
        printf "${CYAN}Time:${RESET} %s\n" "$(date '+%I:%M:%S %p')"
        printf "${CYAN}Device:${RESET} Android %s\n" \
            "$(getprop ro.build.version.release 2>/dev/null || echo Unknown)"
        printf "${CYAN}Root:${RESET} "
        root_status
        line

        echo -e "${GREEN} [01]${RESET} SYSTEM INFORMATION"
        echo -e "${GREEN} [02]${RESET} NETWORK DIAGNOSTICS"
        echo -e "${GREEN} [03]${RESET} CYBER SECURITY LEARNING"
        echo -e "${GREEN} [04]${RESET} PROGRAMMING"
        echo -e "${GREEN} [05]${RESET} FILE MANAGER"
        echo -e "${GREEN} [06]${RESET} SETTINGS"
        echo -e "${RED} [00]${RESET} EXIT"
        line

        read -r -p "  Select an option: " option

        case "$option" in
            1) system_info ;;
            2) network_info ;;
            3) learning ;;
            4)
                clear
                echo "Programming workspace: $HOME"
                echo "Try: python, node, bash"
                read -r -p "Press Enter to return..."
                ;;
            5)
                clear
                ls -lah "$HOME"
                read -r -p "Press Enter to return..."
                ;;
            6)
                clear
                echo "TERMUX PRO MAX Settings"
                echo "Theme: Purple / Cyan / Green"
                echo "Configuration: ~/.termux-pro/"
                read -r -p "Press Enter to return..."
                ;;
            0) clear; exit 0 ;;
            *) echo "Invalid option."; sleep 1 ;;
        esac
    done
}

main_menu