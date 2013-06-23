
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
    sudo apt-get install curl motion git
```

**Checkout motion uploader:**
```bash
git clone https://github.com/marek/MotionUploader.git motion
sudo mv motion /home/motion
sudo chown -R motion:motion /home/motion
```

**Create motion user:**
```bash
# adduser --system --home /home/motion --group motion motion
sudo usermod --home /home/motion
```

** Configure Dropbox Uploader **

The first time you use Dropbox Uploader, you have to run these commands:

```bash
 sudo chmod +x dropbox_uploader.sh
 sudo -u motion HOME=/home/motion ./dropbox_uploader.sh
```

This will allow you to create an API key so that the application can access your dropbox folder.


## Hardware Tweaks

** Free up more ram for the motion process: **
Reduce the amount of memory that is allocated to the GPU.
```bash
sudo vim /boot/config.txt
# set gpu_mem to 16MB
gpu_mem=16
```

** Motion conf for LifeCam HD-6000 **

See ./extra/motion.pi.conf for the configuration file I used for the creation of this project.
