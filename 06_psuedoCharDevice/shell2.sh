# make a file main.c and Makefile
#For read and Write

#Run make file using CROSSCOMPILE
make -C /home/praveen/deviceDrivers/06_psuedoCharDevice/linux-6.1.4/ M=${PWD} ARCH=arm \ CROSS_COMPILE=arm-linux-gnueabi- modules

# make a directory called rootfs in /mnt

# mount rootfs.img (acts as sd card) to /mnt/rootfs
sudo mount -o loop,rw,sync rootfs.img /mnt/rootfs
sudo cp char_driver.ko /mnt/rootfs/home/root/
sudo cp char_driver2.ko /mnt/rootfs/home/root/
sudo umount /mnt/rootfs 

# copy .dtb, and zImage to current folder

# Run the Target machine(Qemu)
qemu-system-arm -M vexpress-a9 -m 1024 -nographic -kernel zImage -dtb vexpress-v2p-ca9.dtb -sd rootfs.img -append "console=ttyAMA0 root=/dev/mmcblk0 rw"

# now ls to check weather .ko file is there or not in target machine
ls

#now to clear kernal messages
dmesg -c

#now to load driver
insmod char_driver.ko

#now to check all the drivers
cat /proc/devices

#now to remove module 
rmmod char_driver.ko
