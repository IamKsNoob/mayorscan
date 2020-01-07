#!/bin/bash
DIRECTORY=$(cd `dirname $0` && pwd)
#Functions - You will not enjoy this.  This will not be over quickly.#

greeting() {
	
	tput setaf 2; tput bold;
	echo -e
	echo -e 	"--------------------"
	echo -e 	"- Mayor Scan 3000  -"
	echo -e     "-       v2.0       -"
	echo -e 	"--------------------"
	echo -e
	echo -e		"Custom Nmap Bash script"	
	echo -e		  "by The Mayor/Dievus"; tput sgr0;
	echo -e
}

init_scan() {
	tput bold; echo -e "Running Ping Scan to check if host is up."; tput sgr0;
	echo -e
	sudo nmap -Pn $name >&1 | tee $name/$name.FullScan.txt
	if cat $name/$name.FullScan.txt | grep "0 hosts up"; then
		tput bold; tput setaf 1; echo -e "No live host found. Exiting now."; tput sgr0;
		exit 0
		else echo
	fi
}

a_scan() {
	tput setaf 2; echo -e "#####################################"; tput sgr0;
	echo -e
	tput bold; echo -e "Running -A Scan as requested."; tput sgr0;
	echo -e
	sudo nmap -A $name >&1 | tee $name/$name.FullScan.txt
	if cat $name/$name.FullScan.txt | grep "0 hosts up"; then
		tput bold; tput setaf 1; echo -e "No live host found. Exiting now."; tput sgr0;
		exit 0
		else echo
	fi
}

vuln_scan() {
	tput setaf 2; echo -e "#####################################"; tput sgr0;
	echo -e
tput bold; echo -e "Conducting Target Vulnerability Scan"; tput sgr0;
	echo -e
sudo nmap --script-updatedb
sudo nmap --script vuln $name >&1 | tee -a $name/$name.FullScan.txt
	echo -e
tput setaf 2; echo -e "#####################################"; tput sgr0;
	echo -e
tput setaf 2 bold; echo -e "Running nmap-vulners and Vulscan. [Experimental]"; tput sgr0;
	echo -e

#Dependency Check#

check1=/usr/share/nmap/scripts/vulscan/
check2=/usr/share/nmap/scripts.vulners.nse
if [ -d "$check1" ] || [ -f "$check2" ]; then
sudo nmap --script nmap-vulners,vulscan --script-args vulscandb=scipvuldb.csv -sV $name >&1 | tee -a $name/$name.FullScan.txt
	echo -e
else
	tput setaf 2; echo -e "Required dependencies are not installed. Installing momentarily."; tput sgr0;
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
	sudo nmap --script nmap-vulners,vulscan --script-args vulscandb=scipvuldb.csv -sV $name >&1 | tee -a $name/$name.FullScan.txt
fi

}

addr_grab() {
	tput bold; echo -en "Please Enter an IP Address or website"; tput sgr0;
	echo -e
	read name
	if [ "$name" == "" ]
		then
		tput setaf 1; echo -e "You forgot to enter a target!"; tput sgr0;
		tput setaf 1; echo -e "Example - 192.168.1.1 or cybersecpadawan.com"; tput sgr0;
		exit 0
	fi
}

scan_files(){
	tput setaf 2; echo -e "#####################################################################"; tput sgr0;
	echo -e
	tput bold; tput setaf 2; echo -e "Would you like a single scan result, or separate files for each scan?"; tput sgr0;
	echo -e
while true; do	
tput bold; echo -e "Enter 1 for Single File"; tput sgr0;
tput bold; echo -e "Enter 2 for Separate Files for Each Scan"; tput sgr0;
read scan
case $scan in
	[1]*)
		tput setaf 2; tput bold; echo -e "Single File Selected."
		echo -e
		break
		;;
	[2]*)
		tput setaf 2; tput bold; echo -e "Separate Files Selected."
		echo -e
		break
		;;
	*)
		tput bold; tput setaf 1; echo -e "Please enter a valid selection."; tput sgr0; >&2
	esac	
done
}
mk_dir() {
if [ ! -d "$name" ];then
mkdir $name
fi
}

menu() {
tput setaf 2; echo -e "#####################################################################"; tput sgr0;
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
		["1"]*)
				tput setaf 2; tput bold; echo -e "-A All Scan Selected. Beginning momentarily."
				echo -e
				a_scan
				break
				;;
				
		["2"]*)		tput setaf 2; tput bold; echo -e "Vulnerability Scan Selected. Beginning momentarily."
				echo -e
				vuln_scan
				break
				;;
				
		["3"]*)		tput setaf 2; tput bold; echo -e "All Listed Scans Selected. Beginning momentarily."
				echo -e
				sleep 1s
				a_scan
				echo -e
				vuln_scan
				break				
				;;
		
		["99"]*)		leave
				break
				;;
		*)
			tput bold; tput setaf 1; echo -e "Please enter a valid selection" >&2
		esac
	done
}	

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
greeting
addr_grab
#scan_files
mk_dir
init_scan
menu
leave

exit 0
