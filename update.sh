#####Simple bash script that runs apt-get commands, pulls contents of this repository, and makes .sh files executable#####
#!/bin/bash

greeting() {
	
	echo -e
	tput setaf 2; tput bold; echo -e "This script will update and upgrade dependencies."; tput sgr0;
	sleep 1s
	echo -e
	tput setaf 2; tput bold; echo -e "Please be patient while updates are applied. Sudo may be required."; tput sgr0;
	echo -e
	sleep 1s
}

update() {
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
	tput setaf 2; tput bold; echo -e "Update, upgrade, and dist upgrade commencing."; tput sgr0;
	echo -e
	sleep 1s
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
	tput setaf 2; tput bold; echo -e "Updating Repositories"; tput sgr0;
	echo -e
	sleep 1s
	sudo apt-get update;
	echo -e
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
	tput setaf 2; tput bold; echo -e "Upgrading Repositories"; tput sgr0;
	echo -e
	sleep 1s
	sudo apt-get upgrade -y;
	echo -e
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
	tput setaf 2; tput bold; echo -e "Dist-upgrade commencing"; tput sgr0;
	echo -e
	sleep 1s
	sudo apt-get dist-upgrade -y;
	echo -e 
} 	

mayorscan(){
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
	tput setaf 2; tput bold; echo -e "Retrieving Current Mayorscan 3000 dependencies from Github"; tput sgr0;
	echo -e 
	sleep 1s
	tput setaf 2; tput bold; echo -e "Note that it will replace existing files."; tput sgr0; 
	sleep 1s
	echo -e
	tput setaf 2; echo -e "########################################################"; tput sgr0;
	echo -e
#	echo -e "to include previous scans. yes/no "; tput sgr0;
#	read ans
#		if [ "$ans" == "yes" ] || [ "$ans" == "y" ]
#			then
		sudo rm -r mayorscan/;
		tput setaf 2; tput bold; echo -e "Cloning in to Github Repositories."; tput sgr0;
		echo -e
		sleep 1s
		git clone https://github.com/dievus/mayorscan.git;
		sleep 1s
		echo -e
		tput setaf 2; echo -e "########################################################"; tput sgr0;
		echo -e
		tput setaf 2; tput bold; echo -e "Changing Permissions and making Mayorscan executable."; tput sgr0;
		cd mayorscan/;
		sudo chmod u+x *.sh;
		echo -e
		sleep 2s
	tput setaf 2; tput bold; echo -e "Mayorscan dependencies updated. Have fun!"; tput sgr0;
#	else [ "$ans" != "yes" ] || [ "$ans" != "y" ]
# fi

}

greeting
update
mayorscan
exit
