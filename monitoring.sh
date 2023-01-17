#!/bin/bash

# OS architecture and kernel version:
ARCH=$(uname -srvmo) 
ARCH1=$(uname -sr)
ARCH2=$(uname -vmo)

# Number of physical processors:
PCPU=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)

# Number of virtual processors:
VCPU=$(grep processor /proc/cpuinfo | uniq | wc -l)

# Current available RAM on the server and its utilization rate as a percentage:
RAM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
RAM_USED=$(free -h | grep Mem | awk '{print $3}')
#RAM_PERC=$(free -k | grep Mem | awk '{printf("%.3f%%"), $3 / $2 * 100}' | sed -ne "s/%/%%/gp" )
RAM_PERC=$(free -k | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100}' )

# Current available disc space on the server and its utilization rate as a percentage:
DISK_TOTAL=$(df -h --total | grep total | awk '{print $2}')
DISK_USED=$(df -h --total | grep total | awk '{print $3}') 
#DISK_PERC=$(df -k --total | grep total | awk '{print $5}'  | sed -ne "s/%/%%/gp" )
DISK_PERC=$(df -k --total | grep total | awk '{print $5}' )

# Current utilization rate of the processors as a percentage:
#CPU_LOAD=$(top -bn1 | grep '^%Cpu' | xargs | awk '{printf("%.1f%%"), $2 + $4}' | sed -ne "s/%/%%/gp" )
CPU_LOAD=$(top -bn1 | grep '^%Cpu' | xargs | awk '{printf("%.1f%%"), $2 + $4}' )

# Last boot:
LAST_BOOT=$(who -b | awk '{print($3 " " $4)}')

# alt: $(who -b | awk G')

# Whether LVM is active or not:
LVM=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)

# Number of active connections:
TCP=$(grep TCP /proc/net/sockstat | awk '{print $3}')

# Number of users using the server:
USER_LOG=$(who | wc -l)

# IP and MAC address:
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip link show | grep link/ether | awk '{print $2}')

# Number of commands executed with the sudo program:
SUDO_LOG=$(cat /var/log/sudo/sudo.log | grep USER | wc -l)

# Print to Screen:
 
echo "Architectura	:  "
echo "- Kernel name and release: $ARCH1"
echo "- OS, HW version: $ARCH2"
echo "Physical CPUs:  $PCPU"
echo "Virtual CPUs:  $VCPU"
echo "Memory Usage:  $RAM_USED / $RAM_TOTAL ( $RAM_PERC )"
echo "Disk Usage:  $DISK_USED / $DISK_TOTAL ( $DISK_PERC )"
echo "CPU Load:  $CPU_LOAD"
echo "Last Boot:  $LAST_BOOT"
echo "LVM use:  $LVM"
echo "TCP Connections: $TCP  established"
echo "Users logged: $USER_LOG"
echo "Network: IP  $IP_ADDR  (MAC  $MAC_ADDR)"
echo "Sudo: $SUDO_LOG  commands used"

exit
