# Change Bootloader

Grub2 boots almost everything, but it 
[fails to generate](https://savannah.gnu.org/bugs/?63796) a 
configuration if you use LVM2 and the root file system is a 
RAID1 LV with SSD caching on top.

A modern alternative is 
[systemd-boot](https://www.freedesktop.org/wiki/Software/systemd/systemd-boot/).
Regrettably there is little documentation how to install it on your
favorite distribution, maybe with the exception of 
[Arch](https://wiki.archlinux.org/title/systemd-boot).
The best instructions for the "Fedora family" that I could find are
[here](https://kowalski7cc.xyz/blog/systemd-boot-fedora-32/).
They can be used for AlmaLinux with only small additions.

*systemd-boot seems to have become part of the systemd package with 9.2 and does not have to be installed any more*

Package `systemd-boot` for AlmaLinux is available from EPEL, install it 
first, then follow the steps described. After creating the directory
`/efi` run `restorecon -R /efi`.

Here's what I did in detail:

 * I assume you know what you're doing, but just in case...

```
# test -d /sys/firmware/efi && echo EFI || echo Legacy
```

 * Enable caching for your LV. Booting a cached LV requires module
   `dm-cache` to be included in initrd-fs by dracut. As usual, it is
   only included if dracut detects that it is used. If you want to
   do things step by step, you can also enable caching after your
   first successful boot with systemd-boot, but remember to run
   dracut again for all images. Now let's prepare some things...
   
``` 
# dnf install epel-release
# dnf update
# mkdir /efi
# restorecon -R -v /efi
# cp /etc/fstab /etc/fstab.bak
```

 * The EFI file system becomes a "first class" participant, so
   edit `/etc/fstab` now and change its mount point from
   `/boot/efi` to `/efi`. Unmount from old mount point, re-mount 
   and create machine directory.
 
```
# vi /etc/fstab
# umount /boot/efi 
# mount -a
# mkdir /efi/$(cat /etc/machine-id)
```

 * Remove "old boot stuff"
 
```
# rm /etc/dnf/protected.d/grub2-*
# dnf remove grubby grub2\* shim\* memtest86*
# umount /boot 
```

 * Edit `/etc/fstab` again and remove the mount for `/boot`. You don't
   need this filesystem any more. Don't remove
   directory `/boot` though, it is owned by the filesystem package.

 * It should not be necessary to modify `/etc/kernel/cmdline`, because 
   we need the same arguments as with grub, but check if you
   have something special there.

 * Now install systemd-boot, both the package and then the bootloader itself.
 
```
# dnf install systemd-boot
# bootctl install 
```

 * As systemd-boot does not know what kernels have been installed before,
   we have to re-add them. Minimum is the running kernel, but you
   may add older ones if you like.

```
# kernel-install add $(uname -r) /lib/modules/$(uname -r)/vmlinuz
```

 * I don't know if this is redundant, but play it safe.
 
```
# dnf reinstall kernel-core
```

 * Make sure everything is in place.
 
```
# bootctl 
```



