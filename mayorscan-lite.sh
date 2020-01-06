#!/bin/bash
echo -en "Please Enter an IP Address or website"
echo -e
read name
	if [ "$name" == "" ]
	then
	tput setaf 1; echo -e "You forgot to enter a target!";
	echo -e "Example - 192.168.1.1 or cybersecpadawan.com"; tput sgr0;
	exit 0
fi
tput setaf 2; echo -e "Now running The Mayor's Nmap Scan Lite edition..."; tput sgr0;

#Create Directory

if [ ! -d "$name" ];then
	mkdir $name
fi

#Ping Scan
tput setaf 2; echo -e "Running mandatory Ping Scan."; tput sgr0;
sudo nmap -Pn $name >&1 | tee $name/$name.PingScan.txt

#Software Scan

tput setaf 2; echo -e "#####################################"; tput sgr0;
tput bold; echo -e "Do you wish to conduct a Software Version Scan? (y/n)?"; tput sgr0;
read ans
	if [ "$ans" == "y" ]
		then	
tput setaf 2; echo -e "Scanning for Target Software."; tput sgr0;
sudo nmap -sV $name $name >&1 | tee $name/$name.SoftwareScan.txt
	else [ "$ans" != "y" ]
fi

#OS System Scanning

tput setaf 2; echo -e "#####################################"; tput sgr0;
tput bold; echo "Do you wish to conduct a Operating System Version Scan? (y/n)?"; tput sgr0;
read ans
	if [ "$ans" == "y" ]
		then	
tput setaf 2; echo -e "Scanning for Target Operating System Information.  Please be patient."; tput sgr0;
sudo nmap -O $name $name >&1 | tee $name/$name.OperatingSystemScan.txt
	else [ "$ans" != "y" ]
fi

#Vulnerability Assessment Scanning

tput setaf 2; echo -e "#####################################"; tput sgr0;
tput bold; echo -e "Do you wish to conduct a Vulnerability Scan against your target(s)? This may take some time. (y/n)"; tput sgr0;
read ans
	if [ "$ans" == "y" ]
		then
	tput setaf 2; echo -e "Now Conducting Vulnerability Scanning."; tput sgr0;
	sudo nmap --script-updatedb
	sudo nmap --script vuln $name $name >&1 | tee $name/$name.VulnScan.txt
	else [ "$ans" != "y" ]
	fi

exit 0
