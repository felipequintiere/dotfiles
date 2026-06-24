# Downloads the pkgbuild from the AUR.
git clone https://aur.archlinux.org/opentabletdriver.git

# Changes into the correct directory, pulls needed dependencies, then installs OpenTabletDriver
cd opentabletdriver && makepkg -si

# Clean up leftovers
cd ..
rm -rf opentabletdriver

# Regenerate initramfs
sudo mkinitcpio -P

# Unload kernel modules
sudo rmmod wacom hid_uclogic
