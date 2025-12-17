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

Kmod/kmod-dm2 RPM
------------------

There's also a `kmod`-style spec included (`fedora/kmod-dm2.spec`) that uses
the kmod build macros (`%kmod_build` / `%kmod_install`) to produce kmod
packages which are the preferred distribution format for kernel modules on
Fedora/RHEL. To build it, run the same `./scripts/fedora/build_rpm.sh` and
it will produce `kmod-dm2` RPM artifacts when built with rpmbuild.

Akmods support
--------------

You can create an akmod-style RPM that installs the source files for
automatic builds on kernel upgrades. This repository includes a template
spec file and a build helper:

  ./scripts/fedora/build_akmod_rpm.sh

Install the resulting RPM and force a build with:

  sudo dnf install -y ~/rpmbuild/RPMS/*/akmod-dm2-*.rpm
  sudo akmods --force
  sudo dracut -f -v   # regenerate initramfs if needed

Note: building and using akmods packages requires `akmods` and `kmod` to
be available on the target system.

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
