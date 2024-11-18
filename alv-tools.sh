#!/bin/bash

# PALETAS DE COLORES

# Colores básicos
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

# Colores intensos
BRIGHT_BLACK="\033[1;30m"
BRIGHT_RED="\033[1;31m"
BRIGHT_GREEN="\033[1;32m"
BRIGHT_YELLOW="\033[1;33m"
BRIGHT_BLUE="\033[1;34m"
BRIGHT_MAGENTA="\033[1;35m"
BRIGHT_CYAN="\033[1;36m"
BRIGHT_WHITE="\033[1;37m"

# Colores básicos | Background
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

# Colores intensos | Background
BG_BRIGHT_BLACK="\033[100m"
BG_BRIGHT_RED="\033[101m"
BG_BRIGHT_GREEN="\033[102m"
BG_BRIGHT_YELLOW="\033[103m"
BG_BRIGHT_BLUE="\033[104m"
BG_BRIGHT_MAGENTA="\033[105m"
BG_BRIGHT_CYAN="\033[106m"
BG_BRIGHT_WHITE="\033[107m"
RESET="\033[0m"

#Manual de ayuda
function show_help() {
    echo -e "____________________________________________________________________________________________\n"
    
    echo -e "${BRIGHT_CYAN}                                        
          _____       _    __         __        _________   _____   _____   _       _____ 
         / ___ \     | |   \ \       / /       |___   ___| |  _  | |  _  | | |     |  ___| ®
        / /___\ \    | |    \ \     / /  _____     | |     | | | | | | | | | |     | |___
       / /_____\ \   | |     \ \   / /  |_____|    | |     | | | | | | | | | |     |___  |
      / /       \ \  | |_____ \ \_/ /              | |     | |_| | | |_| | | |___   ___| |
     /_/         \_\ |_______| \___/               |_|     |_____| |_____| |_____| |_____|
    
    ${RESET}"

    echo ""
    echo "                      Welcome to Alv-tools - Pentesting Toolkit"
    echo ""
    echo "____________________________________________________________________________________________"
    echo ""
    echo -e "Usage: ${BRIGHT_YELLOW}sudo bash alv-tool.sh ${RESET}${BRIGHT_GREEN}[OPTION]${RESET} ${BRIGHT_RED}[TARGET]${RESET}"
    echo ""
    echo "Options:"
    echo "  -p, --portscan         Perform a port scan on the specified IP"
    echo "  -n, --pingsweep        Perform a ping sweep on a subnet"
    echo "  -s, --serviceenum      Enumerate services on the specified IP"
    echo "  -a, --arp-scan         Network scanning"
    echo "  -o, --osdetect         Detect the Operating System and Version"
    echo "  -f, --fullscan         It does a complete scan taking out the port, version, Operating System and Domain Name"
    echo "  -h, --help             Display this help message"
    echo ""
    echo "Examples:"
    echo "  sudo bash alv-tool.sh -p 192.168.1.10      Perform a port scan on 192.168.1.10"
    echo "  sudo bash alv-tool.sh -n 192.168.1         Perform a ping sweep on 192.168.1.0/24"
    echo "  sudo bash alv-tool.sh -s 192.168.1.10      Enumerate services on 192.168.1.10"
    echo "  sudo bash alv-tool.sh -a eth0              Scan the eth0 interface"
    echo "  sudo bash alv-tool.sh -o 192.168.1.10      Try to detect the operating system and version"
    echo "  sudo bash alv-tool.sh -f 192.168.1.10      Does a full scan to IP 192.168.1.10"
    echo ""
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi
if [ "$#" -lt 2 ]; then
    echo -e "${RED}Error: Not enough parameters provided.${RESET}"
    echo "Use -h or --help for usage instructions."
    exit 1
fi

case "$1" in
    # PortScan
    -p|--portscan)
        target_ip=$2

        if ! command -v nmap &> /dev/null; then
            echo -e "${RED}Nmap is not installed. Starting installation...${RESET}"
            
            sudo apt-get update > /dev/null 2>&1
            sudo apt-get install -y nmap > /dev/null 2>&1 &
  
            for i in {1..100}; do
                sleep 0.05
                echo -ne "${BRIGHT_GREEN}Installing nmap... ${i}%\r${RESET}"
            done
            echo -e "\n${BRIGHT_GREEN}Nmap installation complete.${RESET}"
        fi

        echo ""
        echo -e "${GREEN}Performing port scan on $target_ip...${RESET}"
        open_ports=$(nmap -p- -sS $target_ip 2>&1 | grep '^[0-9]' | cut -d "/" -f1 | sort -u | xargs | tr ' ' ',')

        if [[ -n "$open_ports" ]]; then
            echo -e "${GREEN}Open port/s: ${RESET}$open_ports"
        else
            echo -e "${RED}No open ports found in range.${RESET}"
        fi
        ;;
    # PingSweep
    -n|--pingsweep)
        network=$2

        if ! command -v ping &> /dev/null; then
            echo -e "${RED}Ping command is not available. Installing iputils-ping...${RESET}"

            sudo apt-get update > /dev/null 2>&1
            sudo apt-get install -y iputils-ping > /dev/null 2>&1 &
            
            for i in {1..100}; do
                sleep 0.05
                echo -ne "${BRIGHT_GREEN}Installing iputils-ping... ${i}%\r${RESET}"
            done
            echo -e "\n${BRIGHT_GREEN}Ping installation complete.${RESET}"
        fi

        echo -e "${GREEN}Performing ping sweep on $network.0/24...${RESET}"
        for ip in {1..254}; do
            ping -c 1 -W 1 $network.$ip &> /dev/null && echo -e "${GREEN}Host $network.$ip is up.${RESET}" &
        done
        wait
        ;;
    # ServiceEnum
    -s|--serviceenum)
        target_ip=$2

        if ! command -v nmap &> /dev/null; then
            echo -e "${RED}Nmap is not installed. Starting installation...${RESET}"
            
            sudo apt-get update > /dev/null 2>&1
            sudo apt-get install -y nmap > /dev/null 2>&1 &
            
            for i in {1..100}; do
                sleep 0.05
                echo -ne "${BRIGHT_GREEN}Installing nmap... ${i}%\r${RESET}"
            done
            echo -e "\n${BRIGHT_GREEN}Nmap installation complete.${RESET}"
        fi

        echo -e "${GREEN}Enumerating services on $target_ip...${RESET}"
        services=$(nmap -sV $target_ip)

        if [[ "$services" == *"open"* ]]; then
            echo -e "+-------------------+----------------------------+----------------------------+"
            echo -e "| Port              | Service                    | Version                    |"
            echo -e "+-------------------+----------------------------+----------------------------+"

            echo "$services" | grep -E "^[0-9]+/tcp.*open" | while read -r line; do
                port=$(echo "$line" | awk '{print $1}' | cut -d '/' -f1)
                service=$(echo "$line" | awk '{print $3}')
                version=$(echo "$line" | awk '{print $4, $5, $6}' | sed 's/^ *//g')
                printf "| %-17s | %-26s | %-26s |\n" "$port" "$service" "$version"
            done

            echo -e "+-------------------+----------------------------+----------------------------+"

        else
            echo -e "${RED}No open ports found on $target_ip.${RESET}"
        fi
        ;;
    # Arp-Scan
    -a|--arp-scan)
        interface=$2

        if ! command -v arp-scan &> /dev/null; then
            echo -e "${RED}arp-scan is not installed. Starting installation...${RESET}"
            
            sudo apt-get update > /dev/null 2>&1
            sudo apt-get install -y arp-scan > /dev/null 2>&1 &

            for i in {1..100}; do
                sleep 0.05
                echo -ne "${BRIGHT_GREEN}Installing arp-scan... ${i}%\r${RESET}"
            done
            echo -e "\n${BRIGHT_GREEN}arp-scan installation complete.${RESET}"
        fi

        echo -e "${GREEN}Performing ARP scan on interface $interface...${RESET}"
        sudo arp-scan --interface="$interface" --localnet
        ;;
    # OSDetect
    -o|--osdetect)
        target_ip=$2

        if ! command -v nmap &> /dev/null; then
            echo -e "${RED}Nmap is not installed. Starting installation...${RESET}"
            
            sudo apt-get update > /dev/null 2>&1
            sudo apt-get install -y nmap > /dev/null 2>&1 &

            for i in {1..100}; do
                sleep 0.05
                echo -ne "${BRIGHT_GREEN}Installing nmap... ${i}%\r${RESET}"
            done
            echo -e "\n${BRIGHT_GREEN}Nmap installation complete.${RESET}"
        fi

        echo -e "${GREEN}Detecting OS on $target_ip...${RESET}"
        os_detection=$(nmap -O $target_ip)
        echo "$os_detection"
        ;;
esac
