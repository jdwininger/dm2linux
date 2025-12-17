Fedora / RHEL installation notes
================================

This file documents a simple way to build and install the DM2 kernel module
on Fedora or RHEL-based systems.

Prerequisites
-------------

Install build tools and kernel headers:

  sudo dnf install -y @development-tools rpm-build kernel-devel kernel-headers alsa-lib-devel

Build and package
-----------------

1. Build a binary RPM (optional):

   ./scripts/fedora/build_rpm.sh

   The generated RPM will appear under `~/rpmbuild/RPMS/` for the appropriate
   architecture.

2. Or just build and install the module locally:

   ./scripts/fedora/install_on_fedora.sh

Udev rule
---------

The udev rule at `debian/udev/99-dm2.rules` is installed by the install script;
you can also copy it manually:

  sudo cp debian/udev/99-dm2.rules /etc/udev/rules.d/99-dm2.rules
  sudo udevadm control --reload
  sudo udevadm trigger

Testing
-------

With the module installed and the device plugged in run:

  sudo dmesg | tail -n 40
  aconnect -i
  amidi -l

See `tools/check-dm2.sh` for a small runtime test script.
