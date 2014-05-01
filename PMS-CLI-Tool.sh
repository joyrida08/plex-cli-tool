#!/bin/bash
echo '[*******************************************]'
echo "       Welcome to Plex Media Server!"
echo "   Please choose a number from the options below"



I="0"
while [ $I -lt "1" ]; do
OPTIONS="Start Stop Restart Status Refresh Exit"
select opt in $OPTIONS; do
    if [ "$opt" = "Exit" ]; then
	echo Goodbye!
	let $I=$I+1
	exit 0
    elif [ "$opt" = "Start" ]; then
	su -c "systemctl start plexmediaserver.service"
	echo Starting...
	sleep 2
       	su -c "systemctl -l status plexmediaserver.service" 
       	                  
    elif [ "$opt" = "Stop" ]; then
               		su -c "systemctl stop plexmediaserver.service"
               		echo "Stopping..."
               		sleep 2
               		su -c "systemctl status plexmediaserver.service"
               		
    elif [ "$opt" = "Status" ]; then
        su -c "systemctl status plexmediaserver.service"
        
    elif [ "$opt" = "Refresh" ]; then
        echo Force Scan?
        FORCE="y n"
        select frc in $FORCE; do
        if [ "$frc" = "n" ]; then
           
       	    ppp="`curl -sL -w "%{http_code}" "http://plex.grassmucks.com/library/sections/all/refresh" -o /dev/null`"            
            if [ "$ppp" -eq "200" ]; then
                echo Success
                exit 0
            else
                echo Something Went Wrong
                exit 0
            fi
        elif [ "$frc" = "y" ]; then
            echo "Refreshing..."
	    ppp="`curl -sL -w "%{http_code}" "http://plex.grassmucks.com/library/sections/all/refresh" -o /dev/null`"            
            if [ "$ppp" -eq "200" ]; then
                echo Success
                exit 0
                
            else
                echo Something Went Wrong
               echo Uh Oh!
                 exit 0
            fi
           
        else
               echo Uh Oh!
            echo invalid choice
                 exit 0
        fi
        done
    else
        echo bad option
			      
fi
done
done
