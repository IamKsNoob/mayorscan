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
echo -e
tput setaf 2; echo -e "Now running The Mayor's Nmap Scan Lite edition..."; tput sgr0;
sleep 2s
#Create Directory

echo -e
tput setaf 2; echo -e "You will need a directory to store your scan.  I've got you covered."; tput sgr0;
echo -e
sleep 2s

if [ ! -d "$name" ];then
	tput setaf 2; echo -e "Creating a Folder for $name."; tput sgr0;
	sleep 2s
	echo -e	
	tput setaf 2; echo -e "Folder is located in the same directory as mayorscan-lite."; tput sgr0;
	echo -e
	mkdir $name
	sleep 2s
else
	tput bold; echo -e "Directory already created.  Skipping to scanning phase."; tput sgr0;
	echo -e
	sleep 2s
fi

#Scan
tput setaf 2; echo -e "#####################################"; tput sgr0;
echo -e
tput bold; echo -e "Running Ping Scan."; tput sgr0;
echo -e
sudo nmap -Pn $name >&1 | tee $name/$name.FullScan.txt
echo -e
tput setaf 2; echo -e "#####################################"; tput sgr0;
echo -e
tput bold; echo -e "Conducting Software Version Scan"; tput sgr0;
echo -e
sudo nmap -sV $name >&1 | tee -a $name/$name.FullScan.txt
echo -e
tput setaf 2; echo -e "#####################################"; tput sgr0;
echo -e
tput bold; echo -e "Conducting Operating System Version Scan"; tput sgr0;
echo -e
sudo nmap -O $name >&1 | tee -a $name/$name.FullScan.txt
echo -e
tput setaf 2; echo -e "#####################################"; tput sgr0;
echo -e
tput bold; echo -e "Conducting Target Vulnerability Scan"; tput sgr0;
echo -e
sudo nmap --script-updatedb
sudo nmap --script vuln $name >&1 | tee -a $name/$name.FullScan.txt
echo -e
tput setaf 2; echo -e "Scans Complete. Your scan results are located in $name/$name. Have a great day!"; tput sgr0;

exit 0

read ans
	if [ "$ans" == "y" ]
		then
	tput setaf 2; echo -e "Now Conducting Vulnerability Scanning."; tput sgr0;
	sudo nmap --script-updatedb
	sudo nmap --script vuln $name $name >&1 | tee $name/$name.VulnScan.txt
	else [ "$ans" != "y" ]
	fi

exit 0
