#!/bin/bash

filter () {

		# ORS : Output record separator. Records printed out are separated using this value. Default is new line.
  gawk 'BEGIN{ORS=" ";} {

		if ($1 ~/^type=PROCTITLE/) {
			printf substr($2, index($2,"(") + 1) " " substr($3,1, index($3, ".") - 1) "     " substr($5, index($5, "=") + 1) " " $6 " " $7 "        "
		}

		if ($1 ~/^type=PATH/) {
			printf substr($9, index($9, ",") + 1) "  "substr($10, index($10, "=") + 1) " " substr($11, index($11, "=") + 1) " "
		}

		if ($1 ~/^type=CWD/) {  
			print "            " substr($5, index($5, "=") + 1) "    "
		}

		if ($1 ~/^type=SYSCALL/) {
			  print " " substr($17, index($17, "=") + 1) " " substr($18, index($18, "=") + 1) "         " substr($30, index($30, "=") + 1) "\n"
		}
	
	}'
}

	printf "|%-7s DATE %-7s| |%-7s COMMAND DETAILS %-7s| |%-2s PP OWNER AND GROUP%-7s| |%-5s CWD %-5s| |%-2s EXECUTED BY %-2s| |%-5s KEY %-5s|  \n"
	printf "#---------------------------------------------------------------------------------------------------------------------------------------------------#\n"


	ausearch --input-logs -ts today -k "monitor-hosts" -i |  grep -B4 -E "success=yes.*comm=chmod|success=yes.*comm=chown" | filter

	printf "\n* PP stands for PREVIOUS PERMISSIONS \n\n"
		
