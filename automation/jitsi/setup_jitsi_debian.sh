#!/usr/bin/bash

# These document is prepared for Automation of the Debian server for Jitsi-Meet
# Author: Alp Tureci
# Installation Steps: https://www.digitalocean.com/community/tutorials/how-to-install-jitsi-meet-on-debian-10

POST_HOSTNAME="jitsi"

usage(){

    echo "Usage: "
    echo "-h    :   your domain name i.e. alptureci.com Note Jitsi is included"

}

configure_firewall(){

    #Check if ufw is installed if installed
    if [ $(which ufw) ]; then
        echo "ufw installed";
        echo "allowing ports 80/tcp,443/tcp,4443/tcp,10000/udp";

        sudo ufw allow 80/tcp
        sudo ufw allow 443/tcp
        sudo ufw allow 4443/tcp
        sudo ufw allow 10000/udp

        sudo ufw status

    fi
}

install_jitsi(){
    # First, install the gnupg package that enables the system to manage GPG cryptographic keys:
    sudo apt install gnupg

    # Next, download the Jitsi GPG key with the wget downloading utility:
    wget https://download.jitsi.org/jitsi-key.gpg.key

    # The apt package manager will use this GPG key to validate the packages that you will
    # download from the Jitsi repository.
    # Now, add the GPG key you downloaded to apt’s keyring using the apt-key utility:
    sudo apt-key add jitsi-key.gpg.key

    # You can now delete the GPG key file as it is no longer needed:
    rm jitsi-key.gpg.key

    # Now, you will add the Jitsi repository to your server
    # by creating a new source file that contains the Jitsi repository.
    # Open and create the new file with your editor:
    sudo touch /etc/apt/sources.list.d/jitsi-stable.list

    # Add this line to the file for the Jitsi repository:
    echo "deb https://download.jitsi.org stable/"

    # Finally, perform a system update to collect the package list
    # from the Jitsi repository and then install the jitsi-meet package:
    sudo apt update
    sudo apt install jitsi-meet
}

sudo hostnamectl set-hostname "$POST_HOSTNAME.$DOMAIN_NAME"
hostname

echo "127.0.0.1 $POST_HOST_NAME.$DOMAIN_NAME"

configure_firewall;




while [ "$1" != "" ]; do
case $1 in
        -h )           shift
                       DOMAIN_NAME=$1
                       ;;
        -i )           shift
                       INSTANCE=$1
                       ;;
        -u )           shift
                       USER=$1
                       ;;
        -p )           shift
                       PASSWORD=$1
                       ;;
        -w )           shift
                       WARNINGVAL=$1
                       ;;
        -c )           shift
                       CRITICVAL=$1
                       ;;
        * )            QUERY=$1
    esac
    shift
done

if [ $# -ne 1 ] ; then
    usage
else
    filename=$1
fi
