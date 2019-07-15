#!/bin/bash
ECHO=/bin/echo
FIND=/usr/bin/find
ID=/usr/bin/id
RM=/bin/rm
KILL=/bin/kill
SLEEP=/bin/sleep

echo "**************"
echo "Check if you are running as root "
$ECHO -n "Running as root"
if [ `$ID -u` = 0 ]
	then 
                $ECHO "...ok"
        else
		 $ECHO "...failed. Exiting..."
		 exit 1
fi 
echo "**************"


echo "**************"
echo "**** Rationale : https://medium.com/@jonathan.leitschuh/zoom-zero-day-4-million-webcams-maybe-an-rce-just-get-them-to-visit-your-website-ac75c83f4ef5"
echo "**************"
echo "**** Disabling web applications "
echo "*** begin "
for i in "zoomus" "ringcentralopener"
	do
		echo "Working on web application for $i"
		rm -rf ~/.$i
		touch ~/.$i && chmod 000 ~/.$i
	done
echo "*** end "
echo "**************"
echo "**************"
echo "Staged Kill"
#List problematic apps
for k in "ZoomCentral" "RingCentralOpener" "ZoomOpener.app";
	do
		echo "*** Targetting " $k
		#Get PIDs
		for i in `ps auxwww | grep -i "$k" | grep -v grep | tr -s " " | cut -d' ' -f2`;
			do
				echo -n "*** *** Soft kill: " $i;
				$KILL $i > /dev/null;
				echo -n "... Sleeping 5 seconds"
				$SLEEP 5;

				#Check to see if it's still going
				for j in `ps auxwww $i | grep -v "^USER"`;
					do	
						echo -n "... Hard kill: " $j
						$KILL -9 $i;
					done
				echo "...Done"
			done
	done

echo
echo

echo "**************"
echo "*** Listing Processes that might be relevant that are still running"
echo "*** begin "
for i in `ps auxwww | grep -i "Zoom" | grep -v grep | grep -v "cleanUpZoom" | tr -s " " | cut -d' ' -f2`; do ps auxwww -u $i | tail -n 1; done
for i in `ps auxwww | grep -i "RingCentral" | grep -v grep | grep -v "cleanUpZoom" | tr -s " " | cut -d' ' -f2`; do ps auxwww -u $i | tail -n 1; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Listing launch agents that might be relevant that are not removed "
echo "*** begin "
ls /Library/LaunchAgents | grep -i zoom
ls ~/Library/LaunchAgents | grep -i ring
echo "*** end "
echo "**************"

echo "Sleeping for 10 seconds"
sleep 10
