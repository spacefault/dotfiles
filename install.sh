#!/usr/bin/env bash

# spacefault dotfiles installation script

usercheck () {
	if [ `id -u` == 0 ]; then
		echo -e "\e[1;31mROOT ACCOUNT DETECTED\e[0m"
		echo
		echo "This Installer will NOT work when run as root!"
		echo "Running this script will install the files to /root, and not ~/"
		echo "Please run this as a normal user, and try again!"
		exit 1
	fi
}

welcome () {
	clonedir="$(pwd)"
	user="$(whoami)"
	dotdir="/home/$user/.config"
	echo -e "\033[1mspacefault dotfiles installer\033[0m"
	echo
	echo Current User = $user
	echo Current cloned directory = $clonedir
	echo Current .config directory = $dotdir
	echo 
	echo Welcome to the spacefault dotfiles installer!
	echo This installer will help you install and update the dotfiles
	echo The installer will make symlinks from .config/ to here, so the files can be updated through git
	echo
	read -p "Press ENTER to continue, or CTRL+C to exit"
}

overview () {
	echo ====================
	echo -e "\e[1;31m>>> THESE FOLLOWING FILES WILL BE SYMLINKED, and the existing files at $dotdir will be **REMOVED!!** <<<\e[0m"
	echo
	echo "$clonedir/anyrun/  ---SYMLINKED-->  $dotdir/anyrun/"
	echo "$clonedir/waybar/  ---SYMLINKED-->  $dotdir/waybar/"
	echo "$clonedir/kitty/   ---SYMLINKED-->  $dotdir/kitty/"
	echo "$clonedir/hypr/    ---SYMLINKED-->  $dotdir/hypr/"
	echo
	echo "any existing configuration files at these locations will be REMOVED, including symlinks"
	echo
	read -p "Press ENTER to continue, or CTRL+C to exit."
}

confirm () {
	echo -e "\e[1;31m>>> CONFIRMATION REQUIRED <<<\e[0m"
	echo
	echo "YOU ARE ABOUT TO POTENTIALLY DO SOMETHING **IRREVERSIBLE**"
	echo "It is HIGHLY recommended to backup your existing configuration files at $dotdir."
  	echo "If you would like to turn back, now's your chance."
  	echo "Press CTRL+C to exit the installer, and return to the terminal."
  	echo
  	echo "If you would like to continue, read below"
  	echo "Please enter 'Yes, do as I say!' exactly as seen on the screen to continue (without the quotes)"
  	echo
  	echo -n ">>> "
  	read confirmcode
  	if [[ "$confirmcode" != "Yes, do as I say!" ]]; then
    		echo -e "\e[1;31m>>> CONFIRMATION REJECTED <<<\e[0m"
    		echo The Confirmation was rejected, and you must start over.
    		sleep 5
    		exit 1
  	else
    		echo -e "\e[1;32m>>> CONFIRMATION APPROVED <<<\e[0m"
    		echo Approved!
    		echo Installation will resume in a few seconds.
    		sleep 5
  	fi
}

install () {
	echo "Installing dotfiles.."
	echo "DO NOT CLOSE THIS TERMINAL PROCESS UNTIL IT HAS COMPLETED."
	rm $dotdir/anyrun
	rm $dotdir/waybar
	rm $dotdir/kitty
	rm $dotdir/hypr
	ln -sf $clonedir/anyrun $dotdir/anyrun
	ln -sf $clonedir/waybar $dotdir/waybar
	ln -sf $clonedir/kitty $dotdir/kitty
	ln -sf $clonedir/hypr $dotdir/hypr
	echo "done"
}


over () {
	echo -e "\e[1;32m>>> INSTALLATION COMPLETE <<<\e[0m"
	echo
	echo "the installation was successful!"
	echo "from now on, if you would like to update the dotfiles, all you have to do is run the command:"
	echo
	echo "git pull"
	echo
	echo "in $clonedir and the dotfiles should update automatically."
	echo "thanks for using this script!"
}

usercheck
welcome
overview
confirm
install
over
