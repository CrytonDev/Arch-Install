#!/bin/bash

# Exit script on any error
set -e

# Create and configure a 16GB swap file
fallocate -l 16G /swapfile                # Allocate file space
chmod 600 /swapfile                       # Set correct permissions
mkswap /swapfile                          # Setup swap space
swapon /swapfile                          # Enable swap space

# Add swap entry to /etc/fstab to make the swap permanent
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

# Set the timezone to Europe/Berlin and sync hardware clock
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Uncomment en_US.UTF-8 for generation
sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen

# Generate the locales
locale-gen

# Set the system language
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set the console keyboard layout
echo "KEYMAP=de" > /etc/vconsole.conf

# Set the hostname
echo "omega" > /etc/hostname

# Setup /etc/hosts
cat <<EOF > /etc/hosts
127.0.0.1       localhost
::1             localhost
127.0.1.1       omega.localdomain omega
EOF

# Script end
echo "System configuration completed successfully."
