# meta-rpi4b-dev Yocto Layer 

## Description
This is an application layer for the Raspberry Pi 4B which has some basic Linux Dev Utilities installed. Raspbian is currently only avaiable in 64-bit

## Dependencies
This layer depends on:

* URI: git://git.yoctoproject.org/poky
  * branch: kirkstone
  * revision: HEAD
* URI: https://github.com/agherzan/meta-raspberrypi
  * branch: kirkstone
  * revision: HEAD

## Usage
This layer is meant to be used along side the official [meta-raspberrypi bsp yocto layer](https://github.com/agherzan/meta-raspberrypi/tree/kirkstone).

## Deployment to SD-CARD

Install the [bmaptool](https://manpages.ubuntu.com/manpages/trusty/man1/bmaptool.1.html) to copy the generated .wic file to the SD card

```sh
sudo apt install bmap-tools 
```
Insert the microSD into your workstation and note where it shows up.

lsblk is convenient for finding the microSD card.

For example

```sh
user@host:~/$ lsblk

NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda       8:0    0 931.5G  0 disk
|-sda1    8:1    0  93.1G  0 part /
|-sda2    8:2    0  93.1G  0 part /home
sdb       8:16   1   7.4G  0 disk
|-sdb1    8:17   1    64M  0 part
|-sdb2    8:18   1   7.3G  0 part
```
Unmount the sdcard with the following command (in this example the sdcard has two partitions that are unmounted individually)

```sh
umount /dev/sdb1
umount /dev/sdb2
```

Change directories to the location of the yocto build image ```.wic``` and ```.wic.bmap``` file.
Then run the bmaptool command as below. Note that this should be done outside of the container.

```sh
cd <path_to_yocto_build_dir>/build-pi4/tmp/deploy/images/raspberrypi4-64

sudo bmaptool copy --bmap rpi4-dev-raspberrypi4-64-20220928230009.rootfs.wic.bmap \ 
rpi4-dev-raspberrypi4-64-20220928230009.rootfs.wic /dev/sdb

```