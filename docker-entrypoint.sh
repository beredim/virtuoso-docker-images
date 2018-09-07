#!/bin/bash

if [ ! -f /opt/virtuoso-opensource/database/virtuoso.db ]; then
	echo "====================================================================="
	echo "virtuoso.db doesn't seem to exist. This appears to be the first run."
	echo "Therefore we are now going to secure the sparql endpoints"
	cat /secure_sparql.isql >> /opt/virtuoso-opensource/database/autoexec.isql
	rm /secure_sparql.isql
	echo "====================================================================="
	
	if [[ -n "$DBA_PASS" ]]; then
		echo "====================================================================="
		echo "Password for user 'dba' provided on first run."
		echo "Changing password for user 'dba'"
		echo "--" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "user_set_password ('dba', '$DBA_PASS');" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "CHECKPOINT;" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "--" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "====================================================================="	
	else
		echo "====================================================================="
		echo "Default password for dba user (dba:dba)."
		echo "====================================================================="
	fi
	
	if [[ -n "$DAV_PASS" ]]; then
		echo "====================================================================="
		echo "Password for user 'dav' provided on first run."
		echo "Changing password for user 'dav'"
		echo "--" >> /opt/virtuoso-opensource/database/autoexec.isql		
		echo "USER_CHANGE_PASSWORD ('dav', 'dav', '$DAV_PASS');" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "CHECKPOINT;" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "--" >> /opt/virtuoso-opensource/database/autoexec.isql
		echo "====================================================================="	
	else
		echo "====================================================================="
		echo "Default password for dav user (dav:dav)."
		echo "====================================================================="
	fi
	
	echo "Cleaning up autoexec.isql after 15 seconds"
	
	{
		sleep 15
		echo "====================================================================="			
		echo -n "Cleaning up autoexec.isql..."
		rm /opt/virtuoso-opensource/database/autoexec.isql
		echo "Finished"
	} &

fi

/opt/virtuoso-opensource/bin/virtuoso-t -f
