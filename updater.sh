#!/bin/bash
set -euo pipefail

# ----------------------- VARIABLES -----------------------
os=$(uname -r)
UNAME=$(uname | tr '[:upper:]' '[:lower:]')
GREEN='\033[0;32m'
NC='\033[0m'

# ----------------------- FUNCTIONS -----------------------
banner() {
cat << "EOF"

                                 /h`
                  `-/+osssso+/-oMMm.
             `:ohmMMMNNNNNNNNMMMMMMm-
          `:yNMMNmyo/:-....-+NMMMMMMN/
        `/dMMNh/.          -dNNNNNNNNN/
       :dMMmo.             ``````......
      oNMNs.
     sMMN/                                 `-
    +MMN:                                `ymM+
   `NMMo                                  oMMN`
   /MMN`                                  `NMM/
   sMMm                                    dMMs
   sMMm                                    dMMs
   /MMN`                                  `NMM/
   `mMMs                                  sMMm`
    /MNd.                                /NMM/
     :.`                                /NMMo
                                      .yNMN+
           .--........`             -sNMMh-
           :mNNNNNNNNd.          -+hNMMh:`
            :NMMMMMMN+--..--:+shmNMMms-
             -mMMMMMMNNNNNNNNMMNmy+-`
              `dMMo.:/+oooo+/:.`
               .h/

#    # #####  #####    ##   ##### ###### #####
#    # #    # #    #  #  #    #   #      #    #
#    # #    # #    # #    #   #   #####  #    #
#    # #####  #    # ######   #   #      #####
#    # #      #    # #    #   #   #      #   #
 ####  #      #####  #    #   #   ###### #    #

Updater v1.3
Author: C0defire
For updates run: wget https://raw.githubusercontent.com/c0defire/Updater/master/updater.sh

EOF
}

progress_bar() {
    local progress=$1
    local total=100
    local width=40
    local filled=$((progress*width/total))
    local empty=$((width-filled))
    printf "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    printf "] %d%%" "$progress"
    if [[ $progress -eq 100 ]]; then
        echo -e " ${GREEN}✅ Done!${NC}"
    fi
}

redhat() {
    echo -e "\nUpdating: $os"
    sudo yum update -y
    progress_bar 30
    sleep 1

    echo -e "\nUpgrading: $os"
    sudo yum upgrade -y
    progress_bar 60
    sleep 1

    echo -e "\nRemoving unnecessary software"
    sudo yum autoremove -y
    progress_bar 100
}

debian() {
    echo -e "\nUpdating: $os"
    sudo apt update -y
    progress_bar 25
    sleep 1

    echo -e "\nUpgrading: $os"
    sudo apt upgrade -y
    progress_bar 50
    sleep 1

    echo -e "\nDist-Upgrading: $os"
    sudo apt dist-upgrade -y
    progress_bar 75
    sleep 1

    echo -e "\nRemoving uninstalled applications: $os"
    sudo apt autoremove -y
    progress_bar 100
}

# ----------------------- MAIN -----------------------
clear
banner

if [[ "$UNAME" != "linux" ]]; then
    echo "This script only supports Linux."
    exit 1
fi

DISTRO=$(lsb_release -si 2>/dev/null || echo "Unknown")

case "$DISTRO" in
    CentOS|RedHatEnterpriseServer|Fedora)
        redhat
        ;;
    Ubuntu|Kali|Parrot|Raspbian|Debian)
        debian
        ;;
    *)
        echo "Unsupported or unrecognized distribution: $DISTRO"
        exit 1
        ;;
esac

echo -e "\n${GREEN}🎉 System update complete!${NC}"