# mayorscan

Mayorscan is a Bash script that adds simplistic options to running Nmap scans against a target.


In order to use Mayorscan, first download by typing or copying and pasting in to a Linux terminal:
  <br>git clone https://github.com/dievus/mayorscan.git
  <br>I recommend moving the directory to your desktop at this point for simplicity, as well as some experimental directory downloads in the future
  <br>cd mayorscan
  <br>chmod u+x mayorscan.sh
  
To run, type ./mayorscan.sh
  
Results will be outputted to a file based on selection at the beginning of the program
  <br>Option 1 creates a single output file
  <br>Option 2 creates individual files based on the selected scans
<br>File output will be into a directory based on the operating directory of Mayorscan

# A script called update.sh is also included
<br>
Update.sh runs apt-get update, upgrade, and dist-upgrade, as well as pulls the current Mayorscan git to your machine, and, if located in the same level directory as the Mayorscan folder, will replace it with the new version.  

# IT WILL REMOVE YOUR OLD MAYORSCAN DIRECTORY. 

<br>
If you wish to keep the old mayorscan folder and contents, make sure update.sh is located in a different directory location.
