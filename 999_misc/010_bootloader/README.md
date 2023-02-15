# Change Bootloader

Grub2 boots almost everything, but it 
[fails to generate](https://savannah.gnu.org/bugs/?63796) a 
configuration if the root file system is a cached logical volume.

A modern alternative is 
[systemd-boot](https://www.freedesktop.org/wiki/Software/systemd/systemd-boot/).
Regrettably there is little documentation how to install it on your
favorite distribution, maybe with the exception of 
[Arch](https://wiki.archlinux.org/title/systemd-boot).
The best instructions for the "Fedora family" that I could find are
[here](https://kowalski7cc.xyz/blog/systemd-boot-fedora-32/).
They can be used for AlmaLinux with only small additions.

Package `systemd-boot` for AlmaLinux is available from EPEL, install it 
first, then follow the steps described. After creating the directory
`/efi` run `restorecon -R /efi`. Just to make sure, run it again 
after creating the directory with the machine id.

