#!/bin/bash
osType=$(uname)
cp ./handy_browser.sh ~/
. ~/handy_browser.sh
case "$osType" in
    "Darwin")
        {
        echo "Set up on Mac OSX."
        if [[ ". ~/handy_browser.sh" != `tail ~/.bash_profile` ]];then
            echo ". ~/handy_browser.sh" >> ~/.bash_profile
        fi
        } ;;    
    "Linux")
        {   


            # If available, use LSB to identify distribution
    
            if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
                DISTRO=$(gawk -F= '/^NAME/{print $2}' /etc/os-release)
            else
                DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
            fi
            CURRENT_OS=$(echo "Set up on"$DISTRO | tr 'a-z' 'A-Z')
            if [[ ". ~/handy_browser.sh" != `tail ~/.bashrc` ]];then
                echo ". ~/handy_browser.sh" >> ~/.bashrc
            fi
        } ;;
            *) 
        {
            echo "Unsupported OS, exiting"
            exit
        } ;;
esac
