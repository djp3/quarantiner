#!/bin/bash

echo "**************"
echo "Loading sudo password"
sudo echo "ok"
echo "**************"

echo "**************"
echo "*** Creating a dummy folder for adobe to delete "
echo "**** Rationale : https://backblaze.zendesk.com/entries/98786348"
echo "*** begin "
sudo mkdir /.Adobe_will_delete_because_https___goo.gl_ZVJgCB
sudo mkdir ~/.Adobe_will_delete_because_https___goo.gl_ZVJgCB
echo "*** end "
echo "**************"
echo "Turn off  Extensions->Finder->Core Sync in System Preferences"
echo " as per http://apple.stackexchange.com/questions/236577/how-to-disable-adobe-core-sync-app-on-os-x-from-being-launched-automatically"

echo "**************"
echo "*** Removing updaters from LaunchAgents"
echo "*** begin "

pushd .
cd ~/Library/LaunchAgents
for i in AAM ARM ARMDCHelper AdobeCreativeCloud GC; do echo "removing" `basename com.adobe.$i.* .plist`; launchctl remove `basename com.adobe.$i.* .plist`; rm com.adobe.$i.*;done
popd 

pushd .
cd /Library/LaunchAgents
for i in AAM ARM ARMDCHelper AdobeCreativeCloud GC; do echo "removing" `basename com.adobe.$i.* .plist`; launchctl remove `basename com.adobe.$i.* .plist`; sudo rm com.adobe.$i.*;done
popd 


echo "**************"
echo "*** Killing Adobe Acrobat Pro"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Adobe Acrobat.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
for i in `ps auxwww | grep -i "AcroCEF helper.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
for i in `ps auxwww | grep -i "AcroCEF.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1

echo "Hard Kill"
for i in `ps auxwww | grep -i "Adobe Acrobat.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
for i in `ps auxwww | grep -i "AcroCEF helper.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
for i in `ps auxwww | grep -i "AcroCEF.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe Application Manager stuff"
echo "*** begin "
for i in `ps auxwww | grep -i "AAM Updates Notifier.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
for i in `ps auxwww | grep -i "Adobe Application Manager" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
for i in `ps auxwww | grep "Adobe" | grep -i "UpdaterStartupUtility" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done

echo "Soft Kill"
for i in `ps auxwww | grep -i "com.adobe.ARMDC" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1

echo "Hard Kill"
for i in `ps auxwww | grep -i "com.adobe.ARMDC" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"


echo "**************"
echo "*** Killing AGSService"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "AGSService" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "AGSService" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing AdobeGCClient"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "AdobeGCClient.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "AdobeGCClient.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing CS5 Service Manager"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "CS5ServiceManager.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "CS5ServiceManager.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe Desktop Service"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Adobe Desktop Service" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Adobe Desktop Service" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Core Sync"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Core Sync" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Core Sync" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing AdobeIPC"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "AdobeIPC" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "AdobeIPC" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe Crash Reporter"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Adobe Crash Reporter" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Adobe Crash Reporter" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe javascript"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Adobe Creative Cloud.*js$" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Adobe Creative Cloud.*js$" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe installer"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Adobe Installer" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Adobe Installer" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"


echo "**************"
echo "*** Killing Adobe Update Daemon"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "AdobeUpdateDaemon" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "AdobeUpdateDaemon" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Acrobat Update Helper"
echo "*** begin "
echo "Soft Kill"
for i in `ps auxwww | grep -i "Acrobat Update Helper" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill $i; done
sleep 1
echo "Hard Kill"
for i in `ps auxwww | grep -i "Acrobat Update Helper" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; sudo kill -9 $i; done
echo "*** end "
echo "**************"


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
echo "*** Consider editting any files below that have RunAtLoad true to RunAtLoad false "
echo "*** begin "
for i in `ls  /Library/LaunchAgents/com.adobe.*`;do echo;echo $i;grep -A 1 RunAtLoad $i;done
echo "*** end "
echo "**************"
sleep 10
