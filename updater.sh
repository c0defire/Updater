#! /bin/bash
# ----------------------- DESCRIPTIVE INFORMATION ---------------------------------
#
# Updates your system.
#
# ----------------------- DESCRIPTIVE INFORMATION ---------------------------------
#
# -------------------------- DECLARED VARIABLES -----------------------------------
#
#
# -------------------------- DECLARED VARIABLES -----------------------------------
#
#
os=$(uname -r)  # Name of system

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")

############################################
# Notes:                                   #
#                                          #
# Black        0;30     Dark Gray     1;30 #
# Red          0;31     Light Red     1;31 #
# Green        0;32     Light Green   1;32 #
# Brown/Orange 0;33     Yellow        1;33 #
# Blue         0;34     Light Blue    1;34 #
# Purple       0;35     Light Purple  1;35 #
# Cyan         0;36     Light Cyan    1;36 #
# Light Gray   0;37     White         1;37 #
#                                          #
############################################

#
# -------------------------------- FUNCTIONS --------------------------------------
#

# banner - Alias art
function banner()
{
GREEN='\033[0;32m'
NC='\033[0m' # No color

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

Updater v1.2
Author: C0defire
For updates run command: wget https://raw.githubusercontent.com/c0defire/Updater/master/updater.sh


EOF
}

# percentage - Shows percentage at process
function percentage()
{
    echo "================================================"
    echo "=                $*% COMPLETE                  ="
    echo "================================================"
}

# redhat - If system is RedHat then it performs the following instructions
function redhat() {

percentage 30

echo "Updating: $os"
sudo yum update -y

sleep 1
echo
percentage 60

echo "Upgrading: $os"
sudo yum upgrade -y
sleep 1
echo
percentage 90

echo "Removing unnecessary software"
sudo yum autoremove -y
sleep 1
echo
percentage 100
}

# ubuntu - If system is ubuntu then it performs the following instructions
function debian() {

echo "Cleaning: $os"
sudo apt clean
sleep 1
echo
percentage 20

echo "Updating: $os"
sudo apt update -y
sleep 1
echo
percentage 40

echo "Upgrading: $os"
sudo apt upgrade -y
sleep 1
echo
percentage 60

echo "Dist-Upgrading: $os"
sudo apt dist-upgrade -y
sleep 1
echo
percentage 80

echo "Auto removing unwanted programs: $os"
sudo apt autoremove -y
echo

percentage 100
sleep 1
}

#
# -------------------------------- FUNCTIONS --------------------------------------
#

#
# ------------------------------ INSTRUCTIONS -------------------------------------
#
clear
echo
banner

# Below if-statement to be used by newer OS
if [ "$UNAME" == "linux" ]
then
# If available, use LSB to identify distribution
export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    if [ "$DISTRO" == "CentOS" ]
    then
        redhat # Runs the redhat function
    fi

    if [ "$DISTRO" == "Ubuntu" ]
    then
        debian # Runs the debian function
    fi

    if [ "$DISTRO" == "Kali" ]
	then
	    debian # Runs the debian function
	fi

    if [ "$DISTRO" == "Parrot" ]
    then
        debian # Runs the debian function
    fi

    if [ "$DISTRO" == "Raspbian" ]
    then
        debian # Runs the debian function
    fi
fi
# Below if-statement to be used by newer OS
if [ "$UNAME" == "linux" ]
then
# If available, use LSB to identify distribution
    if [ -f /usr/bin/lsb_release  ]
    then
       export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
	if [ "$DISTRO" == "Raspbian" ]
	then
	    debian # Runs the raspbian function
        fi
    fi
fi

#
# ------------------------------ INSTRUCTIONS -----------------------------------

