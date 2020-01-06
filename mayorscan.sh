#!/bin/bash
name=$1
	if [ "$1" == "" ]
	then
	tput setaf 1; echo -e "You forgot a target!";
	echo -e "Example - ./mayorscan.sh 192.168.1.1 or cybersecpadawan.com"; tput sgr0;
	exit 0 
fi

greeting() {

	tput setaf 2;
	echo -e
	echo -e 	"--------------------"
	echo -e 	"- Mayor Scan 3000 - "
	echo -e 	"--------------------"
	echo -e
	echo -e		"Custom Nmap Bash script"	
	echo -e		"by The Mayor/Dievus"
	echo -e
}

#tput setaf 2; echo -en "Welcome to :Mayorsir:'s Automated Nmap Scan 3000"; tput sgr0;
#echo -e
scan_time(){
	tput setaf 2; echo -en "Would you like a single scan result, or separate files for each scan?\n"; tput sgr0;
echo -e
tput bold; echo -e "Enter 1 for Single File"; tput sgr0;
tput bold; echo -e "Enter 2 for Separate Files for Each Scan"; tput sgr0;
read scan
if [ "$scan" = "1" ] || [ "$scan" = "2" ]
	then
	tput setaf 2; echo -e "Running a Mandatory Ping Scan against target(s)..."; tput sgr0;
	else
	tput setaf 1; echo -e "Failure.  Please enter either a 1 or a 2."; tput sgr0;
	exit 0
fi

if [ ! -d "$name" ];then
	mkdir $name
fi

if [ "$scan" = "1" ]
	then
	nmap -Pn $name >&1 | tee $name/$name.FullScan.txt
	elif [ "$scan" = "2" ]
	then 
	nmap -Pn $name >&1 | tee $name/$name.PingScan.txt
fi

#Software Scan

tput setaf 2; echo -e "-----------------------------------------------------------"; tput sgr0;
tput bold; echo -e "Do you wish to conduct a Software Version Scan? (y/n)?"; tput sgr0;
read ans
if [ "$ans" = "y" ]
	then
	tput setaf 2; echo -e "Scanning for Target Software."; tput sgr0;
fi

if [ "$ans" = "y" ] && [ "$scan" = "2" ]
	then
	nmap -sV $name >&1 | sort -u | tee $name/$name.SoftwareScan.txt
elif [ "$ans" = "y" ] && [ "$scan" = "1" ]
	then
	nmap -sV $name >&1 | tee -a $name/$name.FullScan.txt	
	else [ "$ans" = "n" ]
fi

#OS System Scanning

tput setaf 2; echo -e "-----------------------------------------------------------"; tput sgr0;
tput bold; echo "Do you wish to conduct a Operating System Version Scan? (y/n)?"; tput sgr0;
read ans
if [ "$ans" = "y" ]
	then	
	tput setaf 2; echo -e "Scanning for Target Operating System information.  Please be patient."; tput sgr0;
fi

if [ "$ans" = "y" ] && [ "$scan" = "2" ]
	then
	nmap -O $name >&1 | sort -u | tee $name/$name.OperatingSystemScan.txt
	elif [ "$ans" = "y" ] && [ "$scan" = "1" ]
	then
	nmap -O $name >&1 | tee -a $name/$name.FullScan.txt
	else [ "$ans2" = "n" ]
fi

#Vulnerability Assessment Scanning

tput setaf 2; echo -e "-----------------------------------------------------------"; tput sgr0;
tput bold; echo -e "Do you wish to conduct a Vulnerability Scan against your target(s)? This may take some time. (y/n)"; tput sgr0;
read ans
if [ "$ans" == "y" ]
	then
	tput setaf 2; echo -e "Now Conducting Vulnerability Scanning.  This will take some time."; tput sgr0;
fi

if [ "$ans" = "y" ] && [ "$scan" = "2" ]
	then
	tput setaf 2; echo -e "I am going to check to make sure that Nmap's vulnerability database is up to date."; tput sgr0;
	nmap --script-updatedb
	nmap --script vuln $name >&1 | tee $name/$name.VulnerabilityScan.txt
elif [ "$ans" = "y" ] && [ "$scan" = "1" ]
	then
	tput setaf 2; echo -e "I am going to check to make sure that Nmap's vulnerability database is up to date."; tput sgr0;
	nmap --script-updatedb
	nmap --script vuln $name >&1 | tee -a $name/$name.FullScan.txt;
else [ "$ans" = "n" ]
fi
}
leave() {

	tput setaf 2;
	echo -e
	echo -e 	"--------------------"
	echo -e 	"- Scan Complete -"
	echo -e 	"--------------------"
	echo -e
	echo -e		"Thanks for using Mayor Scan 3000. Have a great Day!"	
	echo -e
	exit
}
greeting
scan_time
leave

#tput setaf 2; echo -e "Thanks for using Mayor Scan 3000.  Have a wonderful day!."; tput sgr0;
#exit 0


