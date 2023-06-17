# Gentoo Configuration
These are my Gentoo configuration files
## Installing Gentoo

We are using the environment provided by Gentoo, and we are using a wired connection. Wireless tends to have more steps
```bash
ip addr
ping -c 3 www.gentoo.org
```
Now you partition your drive and set up filesystems
```bash
lsblk
fdisk /dev/sda
mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2
```
We now mount the home partition and extract the stage 3 tarball.
```bash
mount /dev/sda2 /mnt/gentoo
cd /mnt/gentoo
wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20230611T170207Z/stage3-amd64-desktop-openrc-20230611T170207Z.tar.xz
sha256sum stage3-*
tar xpvf stage3-* --xattrs-include='*.*' --numeric-owner
rm stage3-*
mkdir --parents etc/portage/repos.conf
cp usr/share/portage/config/repos.conf etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf etc/
```
Now we mount and chroot
```bash
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
chroot /mnt/gentoo /bin/bash
source /etc/profile
mount /dev/sda1 /boot
```
Now tweak your `etc/portage/make.conf` file, and update
```bash
emerge-webrsync
eselect profile list
emerge --ask --verbose --update --deep --newuse @world
```
