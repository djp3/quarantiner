#!/bin/bash

echo "**************"
echo "*** Creating a dummy folder for adobe to delete "
echo "**** Rationale : https://backblaze.zendesk.com/entries/98786348"
echo "*** begin "
sudo mkdir /.Adobe_will_delete_because_https___goo.gl_ZVJgCB
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing CS5 Service Manager"
echo "*** begin "
for i in `ps auxwww | grep -i "CS5ServiceManager.app" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe Desktop Service"
echo "*** begin "
for i in `ps auxwww | grep -i "Adobe Desktop Service" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Core Sync"
echo "*** begin "
for i in `ps auxwww | grep -i "Core Sync" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing AdobeIPC"
echo "*** begin "
for i in `ps auxwww | grep -i "AdobeIPC" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe Crash Reporter"
echo "*** begin "
for i in `ps auxwww | grep -i "Adobe Crash Reporter" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe javascript"
echo "*** begin "
for i in `ps auxwww | grep -i "Adobe Creative Cloud.*js$" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
echo "*** end "
echo "**************"

echo "**************"
echo "*** Killing Adobe installer"
echo "*** begin "
for i in `ps auxwww | grep -i "Adobe Installer" | grep -v grep | tr -s " " | cut -d' ' -f2`; do echo "   " $i; kill -9 $i; done
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
