
# Motion Uploader

Motion Uploader is a **BASH** script used in conjunction with the **motion** video 
camera capture service. This script uploads any movement to a **Dropbox** share of your choosing.

## Hardware

This project was designed to work on a Raspberry Pi running raspbian. There is no reason why 
this won't work on other hardware with other devices. Here is the list of hardware used for 
my setup:

* Raspberry Pi Model B (512MB)
* Sandisk Ultra 32GB Class 10 SDHC Memory Card
* D-Link DUB-H7BL, 7-port USB 2.0 Hub
* Microsoft LifeCam HD-6000 720p HD Notebook Webcam w/Auto Focus
* Belkin F7D2102 802.11n N300 Micro Wireless Adapter v3000 [Realtek RTL8192CU] 
* Cambridge Silicon Radio, Ltd Bluetooth Dongle


## Installation

**Install Prerequisites:**
```bash
    sudo apt-get install curl motion git arp-scan
```

**Checkout motion uploader:**
```bash
git clone --recursive https://github.com/marek/MotionUploader.git motion
sudo mv motion /home/motion
sudo chown -R motion:motion /home/motion
sudo chmod -R +x /home/motion
```

**Create motion user:**
```bash
# adduser --system --home /home/motion --group motion motion
sudo usermod --home /home/motion
```

**Configure Dropbox Uploader**

The first time you use Dropbox Uploader, you have to run these commands:

```bash
 sudo chmod +x dropbox_uploader.sh
 sudo -u motion HOME=/home/motion ./dropbox_uploader.sh
```

This will allow you to create an API key so that the application can access your dropbox folder.

## Auto Startup/Shutdown

Motion Uploader can be setup to shutdown or startup based on the presence of wifi devices on your network
or on the presence of Bluetooth devices.

modify home_check.sh
```bash
nano home_check.sh

# What interface you want to use to scan with (wlan0 = wifi device, eth0 = wired network)
WIFI_INTERFACE=wlan0

# When these Wifi MAC addresses are found on the network, shutdown motion
WIFI_MACS=( "AA:00:BB:11:CC:22" "DD:33:EE:DD:44:FF" )

# When these Bluetooth MAC addresses are found within range, shutdown motion
BT_MACS=( "A1:B2:C3:D4:E5:F6" )

# The PID file Motion uses when it's running
PID_FILE=/var/run/motion/motion.pid
```

add the script to the root cron scheduler
```bash
nano /etc/crontab

# add this line to the end
*/10 *  * * *   root    cd /home/motion && /home/motion/home_check.sh
```

restart cron
``` bash
sudo service cron restart
```


## Hardware Tweaks

** Free up more ram for the motion process: **
Reduce the amount of memory that is allocated to the GPU.
```bash
sudo nano /boot/config.txt
# set gpu_mem to 16MB
gpu_mem=16
```

** Motion conf for LifeCam HD-6000 **

See ./extra/motion.pi.conf for the configuration file I used for the creation of this project.
