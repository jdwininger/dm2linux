#!/usr/bin/env bash
set -euo pipefail

# Simple install helper for Fedora systems
# - installs build deps
# - builds module with make
# - installs module for current kernel
# - installs udev rule and reloads udev

echo "Install prerequisites (requires dnf and root):"
echo "  sudo dnf install -y @development-tools rpm-build kernel-devel kernel-headers alsa-lib-devel"
read -p "Proceed to install build dependencies now? [y/N] " yn
case "$yn" in
  y|Y) sudo dnf install -y @development-tools rpm-build kernel-devel kernel-headers alsa-lib-devel || true;;
  *) echo "Skipping install of build deps.";;
esac

echo "Building module..."
make -j$(nproc)

echo "Installing module for current kernel..."
sudo cp dm2.ko /lib/modules/$(uname -r)/extra/dm2.ko
sudo depmod -a

echo "Installing udev rule..."
sudo cp debian/udev/99-dm2.rules /etc/udev/rules.d/99-dm2.rules
sudo udevadm control --reload
sudo udevadm trigger

echo "Done. You can try: sudo modprobe dm2 && dmesg | tail -n 40"
