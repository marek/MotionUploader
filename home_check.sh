#!/usr/bin/env bash


## CONFIGURATION
#WIFI_INTERFACE=eth0
WIFI_INTERFACE=wlan0
WIFI_MACS=( "AA:00:BB:11:CC:22" "DD:33:EE:DD:44:FF" )
BT_MACS=( "A1:B2:C3:D4:E5:F6" )
PID_FILE=/var/run/motion/motion.pid


#########################################

shopt -s nocasematch
ENABLE_MOTION=1

## WIFI LOOKUP
DEVICES=`sudo arp-scan --interface=$WIFI_INTERFACE --localnet | awk '{if(length($2) == 17) printf $2 }'`

for mac in "${WIFI_MACS[@]}"
do
    FOUND=`[[ $DEVICES =~ $mac ]] && echo 1 || echo 0`
    if [ $FOUND -eq 1 ]; then
        echo "Found network device $mac";
        ENABLE_MOTION=0
        break
    fi
done


## BLUETOOTH
if [ $ENABLE_MOTION -ne 0 ]; then
    DEVICES=`hcitool scan | awk '{if(length($1) == 17) printf $1 }'`

    for mac in "${BT_MACS[@]}"
    do
        FOUND=`[[ $DEVICES =~ $mac ]] && echo 1 || echo 0`
        if [ $FOUND -eq 1 ]; then
            echo "Found bluetooth device $mac";
            ENABLE_MOTION=0
            break
        fi
    done
fi

## CHECK IF MOTION IS RUNNING
MOTION_RUNNING=0
if [ -a "$PID_FILE" ]; then
    MOTION_PID=`cat "$PID_FILE"`
    kill -0 $MOTION_PID
    if [ $? ]; then
        MOTION_RUNNING=1
    fi
fi


## STOP OR START MOTION SERVICE
if [ $ENABLE_MOTION -eq 1 ]; then
    if [ $MOTION_RUNNING -ne 1 ]; then
        service motion start
    else
       echo "Motion is already running"
    fi
else
    if [ $MOTION_RUNNING -ne 0 ]; then
        service motion stop
    else
       echo "Motion is already stopped"
    fi
fi

