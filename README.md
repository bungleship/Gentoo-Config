# Gentoo Configuration
These are my Gentoo configuration files
## Installing Gentoo

We are using the environment provided by Gentoo, and we are using a wired connection. Wireless tends to have more steps
```bash
ip addr
ping -c 3 www.gentoo.org
```
Now you partition your drive and set up filesystems. I am using sda1 for boot partition and sda2 for root partition.
```bash
lsblk
fdisk /dev/sda
mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2
```
We now mount the root partition and extract the stage 3 tarball.
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
mount --types proc /proc ./proc
mount --rbind /sys ./sys
mount --make-rslave ./sys
mount --rbind /dev ./dev
mount --make-rslave ./dev
mount --bind /run ./run
mount --make-slave ./run
chroot /mnt/gentoo /bin/bash
source /etc/profile
mount /dev/sda1 /boot
```
Copy in `make.conf` and the package sets into `/etc/portage/sets`, and update
```bash
emerge-webrsync
emerge --ask --verbose --update --deep --newuse @world
```
Now we do a few tweaks.
```bash
# cpu flags
emerge --ask app-portage/cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
# timezone
echo "US/Pacific" > /etc/timezone
emerge --config sys-libs/timezone-data
echo '
en_US ISO8859-1
en_US.UTF8 UTF8
' >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update
source /etc/profile
```
Install firmware and kernel, here we just take the binary
```bash
emerge --ask sys-kernel/linux-firmware sys-firmware/intel-microcode
emerge --ask sys-kernel/gentoo-kernel-bin
emerge --depclean
```
First, set a hostname. Then grab all the system tools in sys0. Don't forget rc-updates
```bash
echo ${hostname} > /etc/hostname
emerge --ask @leo-sys0
# rc-update ${} default
```
There are some things you want to configure:
- `/etc/fstab` - make sure the labels are correct
- `/etc/conf.d/hwclock` - check instructions inside
- `/etc/hosts` set more aliases or nicknames

Setup the bootloader
```bash
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
```
set a root password, exit and reboot into your new machine!
```bash
passwd
exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
```
