# mayorscan

Mayorscan is a Bash script that adds simplistic options to running Nmap scans against a target.

In order to use Mayorscan, first download by typing or copying and pasting in to a Linux terminal:
  <br>git clone https://github.com/dievus/mayorscan.git
  <br>cd mayorscan
  <br>chmod u+x mayorscan.sh
  
To run, type ./mayorscan.sh with an IP address or a URL

Mayorscan runs up to four different scans, including:
  <br>Ping Scan
  <br>Software Version Scan
  <br>Operating System Scan
  <br>Vulnerability Scan
  
Results will be outputted to a file based on selection at the beginning of the program
  <br>Option 1 creates a single output file
  <br>Option 2 creates individual files based on the selected scans
<br>File output will be into a directory based on the operating directory of Mayorscan
  
