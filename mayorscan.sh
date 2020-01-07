#!/bin/bash
source ./functions/functions.sh
DIRECTORY=$(cd `dirname $0` && pwd)

#Functions - You will not enjoy this.  This will not be over quickly.#	

greeting
addr_grab
scan_files
mk_dir
init_scan
menu
leave

exit 0

