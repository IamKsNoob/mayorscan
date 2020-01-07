#!/bin/bash
DIRECTORY=$(cd `dirname $0` && pwd)

#############Functions#################

#Greeting#

greeting() {
	
	tput setaf 2; tput bold;
	echo -e
	echo -e 	"--------------------"
	echo -e 	"- Mayor Scan 3000  -"
	echo -e     	"-       v2.0       -"
	echo -e 	"--------------------"
	echo -e
	echo -e		"Custom Nmap Bash script"	
	echo -e		  "by The Mayor/Dievus"; tput sgr0;
	echo -e
}

#Address Grab#

addr_grab() {
	tput bold; echo -en "Please Enter an IP Address or website"; tput sgr0;
	echo -e
	read name
	if [ "$name" == "" ]
		then
		tput setaf 1; tput bold; echo -e "You forgot to enter a target!"; tput sgr0;
		tput setaf 1; tput bold; echo -e "Example - 192.168.1.1 or cybersecpadawan.com"; tput sgr0;
		exit 0
	fi
}

#Directory Creation#

mk_dir() {
tput setaf 2; tput bold; echo -e "You will need a directory to store your scan.  I've got you covered."; tput sgr0;
echo -e
sleep 2s

if [ ! -d "$name" ];then
	tput setaf 2; tput bold; echo -e "Creating a Folder for $name."; tput sgr0;
	sleep 2s
	echo -e
	tput setaf 2; tput bold; echo -e "Folder is located in the same directory as msv2."; tput sgr0;	
	mkdir $name
	echo -e
	sleep 2s
else
	tput bold; tput bold; echo -e "Directory already created. Skipping to next phase."; tput sgr0;
	echo -e
	sleep 2s
	
fi
}

#Scans#

scan_files(){
	echo -e	
	tput setaf 2; tput bold; echo -e "#####################################"; tput sgr0;
	echo -e
	tput bold; tput setaf 2; echo -e "Would you like a single scan result, or separate files for each scan?"; tput sgr0;
	echo -e
while true; do	
tput bold; echo -e "[1] Single File"; tput sgr0;
tput bold; echo -e "[2] Separate Files for Each Scan"; tput sgr0;
read scan
case $scan in
	"1")
		tput setaf 2; tput bold; echo -e "Single File Selected."
		echo -e
		break
		;;
	"2")
		tput setaf 2; tput bold; echo -e "Separate Files Selected."
		echo -e
		break
		;;
	*)
		tput bold; tput setaf 1; echo -e "Please enter a valid selection."; tput sgr0; >&2
	esac	
done
}

#Initial Ping Scan#

init_scan() {
	tput bold; echo -e "Running Ping Scan to check if host is up."; tput sgr0;
	echo -e
	if [ "$scan" = "1" ]; then
	sudo nmap -Pn $name > $name/$name.FullScan.txt
	echo -e 
	tput bold; tput setaf 2; echo -e "[SUCCESS] Host is alive.  Continuing..."; tput sgr0;
	echo -e
	elif [ "$scan" = "2" ]; then
	sudo nmap -Pn $name > $name/$name.PingScan.txt
	tput bold; tput setaf 2; echo -e "[SUCCESS] Host is alive.  Continuing..."; tput sgr0;
	echo -e
fi
	if cat $name/$name.FullScan.txt 2> /dev/null | grep "0 hosts up"; then
		tput bold; tput setaf 1; echo -e "No live host found. Removing unnecessary files and exiting now."; tput sgr0;	
		sudo rm -rf ./$name
		exit 0
fi
	if cat $name/$name.PingScan.txt 2> /dev/null | grep "0 hosts up"; then
		tput bold; tput setaf 1; echo -e "No live host found. Removing unnecessary files and exiting now."; tput sgr0;	
		sudo rm -rf ./$name		
		exit 0
fi
}


#-A Scan#

a_scan() {
	tput setaf 2; tput bold; echo -e "#####################################"; tput sgr0;
	echo -e
	tput bold; echo -e "Running -A Scan as requested."; tput sgr0;
	echo -e
	if [ "$scan" = "1" ]; then
	sudo nmap -A $name >&1 | tee -a $name/$name.FullScan.txt
	elif [ "$scan" = "2" ]; then
	sudo nmap -A $name >&1 | tee $name/$name.AllScan.txt
	echo -e
fi
}

#Vulnerability Scanning#

vuln_scan() {
	tput setaf 2; tput bold; echo -e "#####################################"; tput sgr0;
	echo -e
tput bold; echo -e "Updating Definitions and Conducting Target Vulnerability Scan"; tput sgr0;
	echo -e
sudo nmap --script-updatedb
if [ "$scan" = "1" ]; then
sudo nmap --script vuln $name >&1 | tee -a $name/$name.FullScan.txt
elif [ "$scan" = "2" ]; then
sudo nmap --script vuln $name >&1 | tee -a $name/$name.nmapVulnScan.txt
	echo -e
fi
}

vulners(){
tput setaf 2; tput bold; echo -e "#####################################"; tput sgr0;
	echo -e
tput setaf 2; tput bold; echo -e "Running nmap-vulners and Vulscan. [Experimental]"; tput sgr0;
	echo -e
tput bold; echo -e "Checking for necessary dependencies."; tput sgr0;
echo -e
sleep 1s
check1=/usr/share/nmap/scripts/vulscan/
check2=/usr/share/nmap/scripts/vulners.nse
if [ -d "$check1" ] || [ -f "$check2" ]; then
	tput bold; tput setaf 2; echo -e "[SUCCESS] Dependencies installed. Initializing Scanning. This may take some time."; tput sgr0;
else vuln_depen
fi
if [ "$scan" = "1" ]; then
	echo -e
	sudo nmap --script vulscan --script-args vulscandb=exploitdb.csv -sV $name >&1 | tee -a $name/$name.FullScan.txt
	echo -e

elif [ "$scan" = "2" ]; then
	echo -e
	sudo nmap --script vulscan --script-args vulscandb=exploitdb.csv -sV $name >&1 | tee $name/$name.Vulner.Vulscan.txt
	echo -e
fi

}

vuln_depen(){
tput setaf 1; tput bold; echo -e "#####################################################################"; tput sgr0;
	echo -e
tput setaf 1; tput bold; echo -e "Required dependencies are not installed. Installing momentarily."; tput sgr0;
sleep 2s
echo -e
	tput setaf 2; echo -e "Cloning Git Repositories and Updating Dependencies."; tput sgr0;
echo -e
		cd ..
		cd ..
		cd /usr/share/nmap/scripts/
	sudo git clone https://github.com/vulnersCom/nmap-vulners.git
	echo -e
	sudo git clone https://github.com/scipag/vulscan.git
	echo -e
		cd vulscan/utilities/updater
		sudo chmod +x updateFiles.sh
		sudo ./updateFiles.sh
		cd
		cd $DIRECTORY/
		#path=$PWD
		#echo "$path"

	echo -e
	tput setaf 2; tput bold; echo -e "[SUCCESS] Dependencies installed. Restarting scan."; tput sgr0;
vulners
		 
}

#User Options#

menu() {
tput setaf 2; tput bold; echo -e "#####################################"; tput sgr0;
	echo -e
while true; do
tput bold; tput setaf 2; echo -e "Please select which scan(s) you would like to run"; tput sgr0;
	echo -e
tput bold; tput setaf 2; echo -e "Syntax - enter your NUMBER selections with no spaces."; tput sgr0;
	echo -e
tput bold; 
echo -e "[1] -A All Scan";
echo -e "[2] Vulnerability Scan";
echo -e "[3] All Listed Scans";
echo -e "[99] Exit to Terminal";
	read scan_set
		case $scan_set in
		"1")
				tput setaf 2; tput bold; echo -e "-A All Scan Selected. Beginning momentarily."; tput sgr0;
				echo -e
				a_scan
				return_menu
				break
				;;
				
		"2")		tput setaf 2; tput bold; echo -e "Vulnerability Scan Selected. Beginning momentarily."; tput sgr0;
				echo -e
				vuln_scan
				vulners
				return_menu
				break
				;;
				
		"3")		tput setaf 2; tput bold; echo -e "All Listed Scans Selected. Beginning momentarily."; tput sgr0;
				echo -e
				sleep 1s
				a_scan
				vuln_scan
				vulners
				return_menu
				break				
				;;
		"4")		tput bold; echo -e "Running Ping Scan to check if host is up."; tput sgr0;
				echo -e
				sudo nmap -Pn $name >&1 | tee $name/$name.FullScan.txt
				return_menu
				break
				;;		
		"99")		leave
				break
				;;
		*)
			tput bold; tput setaf 1; echo -e "Please enter a valid selection"; tput sgr0; >&2
		esac
	done
}

return_menu(){
	echo -e
	tput setaf 2; echo -e "#####################################################################"; tput sgr0;
	echo -e
	tput bold; tput setaf 2; echo -e "Would you like to run another scan?"; tput sgr0;
	echo -e
while true; do	
tput bold; echo -e "[1] Yes"; tput sgr0;
tput bold; echo -e "[2] Exit to Command Line"; tput sgr0;
read scan
case $scan in
	"1")
		menu
		break
		;;
	"2")
		exit 0
		;;
	*)
		tput bold; tput setaf 1; echo -e "Please enter a valid selection."; tput sgr0; >&2
	esac	
done
}

#Exit Message#

leave() {

tput setaf 2;
echo -e
echo -e 	"-------------------"
echo -e 	"-  Scan Complete  -"
echo -e 	"-------------------"
echo -e
echo -e		"Thanks for using Mayor Scan 3000. Have a great Day!"	
echo -e
exit
}
