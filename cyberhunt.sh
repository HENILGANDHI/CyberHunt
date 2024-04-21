#!/bin/bash

red=$'\e[1;31m'
blue=$'\e[1;34m'
yellow=$'\e[1;33m'
green=$'\e[1;32m'
meg=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[1;37m'

banner () {
    printf "${green}
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒
▒▒▒▒    ▒   ▒▒▒   ▒   ▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒  ▒    ▒   ▒▒▒▒▒▒   ▒▒   ▒   ▒   ▒▒▒    ▒  
▓▓   ▓▓▓▓▓   ▓   ▓▓   ▓   ▓▓▓▓  ▓▓▓   ▓▓▓   ▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓   ▓▓   ▓▓▓   ▓▓
▓   ▓▓▓▓▓▓▓▓    ▓▓▓   ▓▓▓   ▓         ▓▓▓   ▓▓▓▓   ▓▓  ▓▓   ▓▓   ▓▓   ▓▓   ▓▓▓   ▓▓
▓▓   ▓▓▓▓▓▓▓▓   ▓▓▓   ▓▓▓   ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓  ▓▓▓   ▓   ▓▓   ▓▓   ▓▓   ▓▓▓   ▓ 
████    ████   ████   █   █████     ████    ████  ███   ███      █    ██   ████   █
███████████   █████████████████████████████████████████████████████████████████████
                            
                            
    ${white}"

    printf "${cyan}
                                        <❤> Made By HENIL GANDHI <❤>
    ${white}"

    printf "${meg}
Linkedin :-  https://linkedin.com/in/henil-gandhi-102957218/
Instagram :- https://www.instagram.com/fantastic_henil
Twitter :-   https://twitter.com/fantasticHENIL

${white}"
echo -e "\n"
}

# Function to display usage information
usage() {
    banner
    echo "${white}Usage: $0 -d <target>"
    echo "${white}Options:"
    echo "${blue}  -d, --domain <target>   Target domain name"
    echo "${white}===============================================================================${white}"
    echo "${green} Enumeration Mode: ${yellow}It will complete the Reconnaissance on the given target domain${white}"
    echo "${green} Exploitation Mode: ${yellow}It will complete the Reconnaissance & Automation Vulnerability scan on the given target domain${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"   
    echo "${meg} Example"
    echo "${cyan} cyberhunt -d target.com"
    exit 1
}

# Function to perform subdomain enumeration
subdomain_enum() {
    echo "${white}===============================================================================${white}"
    echo "${meg}Subdomain enumeration started on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
    
    # Create folder for target
    mkdir -p "$1"
    cd "$1" || exit

    # Run subfinder and findomain
    subfinder -d "$1" -silent | tee subfinder.txt
    findomain -t "$1" -silent | tee findomain.txt


    # Merge and sort subdomain lists
    cat subfinder.txt findomain.txt | sort -u > all_subdomains.txt

    echo "${white}===============================================================================${white}"
    echo "${meg}Subdomain enumeration completed on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
}

# Function to perform httpx scanning
httpx_scan() {
    echo "${white}===============================================================================${white}"
    echo "${meg}Httpx started on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"

    # Run httpx
    httpx -l all_subdomains.txt -silent -o running_urls.txt

    echo "${white}===============================================================================${white}"
    echo "${meg}Httpx completed on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
}

# Function to perform waybackurls scanning
wayback_scan() {
    echo "${white}===============================================================================${white}"
    echo "${meg}WaybackURLs started on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"

    # Run waybackurls
    waybackurls < running_urls.txt > wayback.txt

    echo "${white}===============================================================================${white}"
    echo "${meg}WaybackURLs completed on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
}

# Function to perform nuclei scanning
nuclei_scan() {
    echo "${white}===============================================================================${white}"
    echo "${meg}Nuclei scanning started on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
    
    # Run nuclei with notification
    nuclei -l running_urls.txt -t /root/nuclei-templates -stats -o "nuclei_out_for_$1.txt" -silent | notify

    echo "${white}===============================================================================${white}"
    echo "${meg}Nuclei scanning completed on ${blue}$1${white}"
    echo "${white}===============================================================================${white}"
    echo -e "\n"
}

# Main script logic
if [ "$#" -ne 2 ]; then
    usage
fi

# Parse command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--domain) domain="$2"; shift ;;
        *) echo "${red}Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if target domain is provided
if [ -z "$domain" ]; then
    echo "${red}Target domain is missing!"
    usage
fi

banner

# Prompt user for mode selection
echo "${yellow}Choose mode:"
echo "${yellow}1. Enumeration mode"
echo "${yellow}2. Exploitation mode"
read -r mode

# Perform tasks based on selected mode
case $mode in
    1)
        subdomain_enum "$domain"
        httpx_scan "$domain"
        wayback_scan "$domain"
        ;;
    2)
        subdomain_enum "$domain"
        httpx_scan "$domain"
        wayback_scan "$domain"
        nuclei_scan "$domain"
        ;;
    *)
        echo "${red}Invalid mode selected!"
        usage
        ;;
esac
