#!/bin/bash
name=$1
if [ "$1" == "" ]
	then
	echo -e "\e[31mYou forgot a target!\e[0m"
	echo -e "\e[31mExample - ./mayorscan.sh 192.168.1.1 or cybersecpadawan.com\e[0m"
	exit 0 
fi
echo -en "\e[32mWelcome to :Mayorsir:'s Automated Nmap Scan 3000\n\n\e[0m"
echo "Would you like a single scan result, or separate files for each scan?"
echo "Enter 1 for Single File"
echo "Enter 2 for Separate Files for Each Scan"
read scan
if [ "$scan" = "1" ] || [ "$scan" = "2" ]
	then
	echo -e "\e[32mNow running The Mayor's Nmap Scan 3000. Running a Mandatory Ping Scan against target(s)...\e[0m"
	else
	echo -e "\e[31mFailure.  Please enter either a 1 or a 2.\e[0m"
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

echo -e "\e[32m-----------------------------------------------------------\e[0m"
echo -e "Do you wish to conduct a Software Version Scan? (y/n)?"
read ans
if [ "$ans" = "y" ]
	then
	echo -e "\e[32mScanning for Target Software.\e[0m"
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

echo -e "\e[32m-----------------------------------------------------------\e[0m"
echo "Do you wish to conduct a Operating System Version Scan? (y/n)?"
read ans
if [ "$ans" = "y" ]
	then	
	echo -e "\e[32mScanning for Target Operating System information.  Please be patient.\e[0m"
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

echo -e "\e[32m-----------------------------------------------------------\e[0m"
echo -e "Do you wish to conduct a Vulnerability Scan against your target(s)? This may take some time. (y/n)"
read ans
if [ "$ans" == "y" ]
	then
	echo -e "\e[32mNow Conducting Vulnerability Scanning.  This will take some time.\e[0m"
fi

if [ "$ans" = "y" ] && [ "$scan" = "2" ]
	then
	echo -e "\e[32mI am going to check to make sure that Nmap's vulnerability database is up to date.\e[0m"
	nmap --script-updatedb
	nmap --script vuln $name >&1 | tee $name/$name.VulnerabilityScan.txt
elif [ "$ans" = "y" ] && [ "$scan" = "1" ]
	then
	echo -e "\e[32mI am going to check to make sure that Nmap's vulnerability database is up to date.\e[0m"
	nmap --script-updatedb
	nmap --script vuln $name >&1 | tee -a $name/$name.FullScan.txt;
else [ "$ans" = "n" ]
fi
echo -e "\e[32mThanks for using Mayor Scan 3000.  Have a wonderful day!.\e[0m"
exit 0
