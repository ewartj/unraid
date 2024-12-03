#!/bin/bash
# Default unasigned disk script for backing up to a external HDD
# Available variables:
#
# ACTION - if mounting, ADD; if unmounting, UNMOUNT; if unmounted, REMOVE; if error, ERROR_MOUNT, ERROR_UNMOUNT
# DEVICE - partition device, e.g. /dev/sda1
# UD_DEVICE - unassigned devX designation
# SERIAL - disk serial number
# LABEL - partition label
# LUKS - if the device is encrypted, this is the partition device, e.g. /dev/sda1
# FSTYPE - partition filesystem
# MOUNTPOINT - where the partition is mounted
# OWNER - "udev" if executed by UDEV, otherwise "user"
# PROG_NAME - program name of this script
# LOGFILE - log file for this script

case $ACTION in
  'ADD' )
    /usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Unassigned Devices" -d "Device mounted" -i "normal"

    rsync –av --delete /mnt/user /mnt/disks/Expansion/backup
   tar -cvjf /mnt/disks/Expansion/backup/backup_$(date +%Y%m%d).tar.bz2 /home/rsync/daily/

  'UNMOUNT' )
    # do your stuff here

    /usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Unassigned Devices" -d "Device unmounting" -i "normal"
  ;;

  'REMOVE' )
    # do your stuff here

    # Spin down disk - uncomment this if you want the disk to be spun down after the disk is unmounted
#   /usr/local/sbin/rc.unassigned spindown $UD_DEVICE

    # Detach the disk - uncomment this if you want the USB disk to be detached after it is unmounted
#   /usr/local/sbin/rc.unassigned detach $UD_DEVICE

    /usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Unassigned Devices" -d "Device unmounted" -i "normal"
  ;;

  'ERROR_MOUNT' )
    # do your stuff here

    /usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Unassigned Devices" -d "Error mounting device" -i "alert"
  ;;

  'ERROR_UNMOUNT' )
    # do your stuff here

    /usr/local/emhttp/webGui/scripts/notify -e "Unraid Server Notice" -s "Unassigned Devices" -d "Error unmounting device" -i "alert"
  ;;
esac
