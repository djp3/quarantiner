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
echo "*** Creating a dummy folder for adobe to delete "
echo "**** Rationale : https://backblaze.zendesk.com/entries/98786348"
echo "*** begin "
mkdir /.Adobe_will_delete_because_https___goo.gl_ZVJgCB
mkdir ~/.Adobe_will_delete_because_https___goo.gl_ZVJgCB
echo "*** end "
echo "**************"
echo "Turn off  Extensions->Finder->Core Sync in System Preferences"
echo " as per http://apple.stackexchange.com/questions/236577/how-to-disable-adobe-core-sync-app-on-os-x-from-being-launched-automatically"

echo "**************"
echo "*** Removing updaters from LaunchAgents"
echo "*** begin "

pushd . > /dev/null
cd ~/Library/LaunchAgents
for i in AAM ARM ARMDCHelper AdobeCreativeCloud GC ARMDC agsservice ccxprocess acc.installer.v2;
	do 
		if compgen -G `basename com.adobe.$i.*.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.*.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi
		if compgen -G `basename com.adobe.$i.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi
	done
popd  > /dev/null

pushd . > /dev/null
cd /Library/LaunchAgents
for i in AAM ARM ARMDCHelper AdobeCreativeCloud GC ARMDC agsservice ccxprocess acc.installer.v2;
	do 
		if compgen -G `basename com.adobe.$i.*.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.*.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi
		if compgen -G `basename com.adobe.$i.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi
	done
popd  > /dev/null

pushd . > /dev/null
cd /Library/LaunchDaemons
for i in AAM ARM ARMDCHelper AdobeCreativeCloud GC ARMDC agsservice ccxprocess acc.installer.v2;
	do 
		if compgen -G `basename com.adobe.$i.*.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.*.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi

		if compgen -G `basename com.adobe.$i.plist` > /dev/null; then
			# "Some files exist."
			echo "removing" `basename com.adobe.$i.plist`;
			$RM com.adobe.$i.*;
			#launchctl remove `basename com.adobe.$i.*`;
		fi
	done
popd  > /dev/null

echo "**************"
echo "*** Removing items installed in launchctl with adobe name"
echo "*** begin "

pushd . > /dev/null
for i in `launchctl list | grep adobe | cut -f 3`;
	do 
		echo $i;
		launchctl remove $i;
	done;
popd > /dev/null


echo "Staged Kill"
#List problematic apps
for k in "Adobe Acrobat.app" "AcroCEF helper.app" "AcroCEF.app" "AAM Updates Notifier.app" "Adobe Application Manager" "AdobeUpdaterStartupUtility" "com.adobe.ARMDC" "AGSService" "AGMService" "AdobeGCClient.app" "CS5ServiceManager.app" "Adobe Desktop Service" "Core Sync" "AdobeIPC" "Adobe Crash Reporter" "Adobe Creative Cloud.*js$" "Adobe Installer" "AdobeUpdateDaemon" "Acrobat Update Helper" "Adobe.Creative Cloud Libraries" "com.adobe.acc.installer.v2" "AdobeCrashReporter" "Adobe Creative Cloud Experience";
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
for i in `ps auxwww | grep -i "Adobe" | grep -v grep | grep -v "cleanUpAdobe" | tr -s " " | cut -d' ' -f2`; do ps auxwww -u $i | tail -n 1; done
for i in `ps auxwww | grep -i "Core Sync" | grep -v grep | grep -v "cleanUpAdobe" | tr -s " " | cut -d' ' -f2`; do ps auxwww -u $i | tail -n 1; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Listing launch agents that might be relevant that are not removed "
echo "*** begin "
ls /Library/LaunchAgents | grep -i adobe
ls ~/Library/LaunchAgents | grep -i adobe
ls /Library/LaunchDaemons | grep -i adobe
echo "*** end "
echo "**************"



if compgen -G "/Library/LaunchAgents/com.adobe.*" > /dev/null; then
	# "Some files exist."
	echo "**************"
	echo "*** Consider editting any files below that have RunAtLoad true to RunAtLoad false "
	echo "*** begin "
	for i in `ls  /Library/LaunchAgents/com.adobe.*`;do echo;echo $i;grep -A 1 RunAtLoad $i;done
	echo "*** end "
	echo "**************"
fi

echo "Sleeping for 10 seconds"
sleep 10
