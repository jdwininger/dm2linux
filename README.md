
Linux Alsa driver for the Mixman DM2
======================================

What it is
============

  This driver converts the mixman DM2 into a ALSA MIDI device which
  can be connected to other MIDI devices with the aconnect command or
  with specialized GUIs such as qjackctl.

  The driver was originally written to work well with Mixxx, an Open
  Source DJ mixing program, but it can just as well be used as a
  generic MIDI control surface.


Preliminaries
===============

  The driver has been updated to support modern Linux kernels (3.x/4.x/5.x/6.x).
  A kernel patch is no longer required; the driver uses interrupt endpoints by default
  and should work on current distributions without modifying kernel source.


Compiling / Installing
========================

  1. The Debian / Ubuntu Way

    Get the newest dm2-source_<version>_all.deb from sourceforge. Use
    the following command sequence as root to build and install the
    driver.

      # dpkg -i dm2-source_<version>_all.deb
      # apt-get install module-assistant
      # module-assistant prepare
      # module-assistant auto-install dm2

  2. The Old-Fashioned Way

    Provided you have a recent kernel with header files, you can just
    type "make" in the source directory. You should get a dm2.ko
    kernel module shortly afterwards.

      make

    This module can be insmod'ded (as root) or installed directly. To
    install, you also need root privileges.

      sudo make install

    This deposits the module in the "kernel/sound/drivers" section of
    your kernel and scans it for USB autodetection.


Mixxx Configuration
=====================

  For using the dm2 with mixxx, copy the MIDI mapping files into the
  mixxx midi directory:

    # sudo cp mixxx/Mixman DM2* /usr/share/mixxx/midi/

  For your convenience, there's a PNG there, which shows what
  functions are where in the default mapping.


Testing
=========

  Plug the DM2 into a free USB socket, and its LEDs should flash for a
  short time. This is meant as a self-test and it also signals the
  first step in the auto-calibration procedure, so please make sure
  the fader and joystick of the DM2 are centered when you plug the
  device in.

  If you have seen the flashing LEDs, your driver is operational. For
  additional info, you can read "/var/log/messages" or the "dmesg"
  output.


 Files

   dm2.c                       driver source file
   dm2.h                       driver header file 
   mixxx/*                     MIDI mapping for mixxx.org
   LICENSE.txt                 GNU General Public License
   linux-lowspeedbulk.patch    kernel patch to allow bulk transfers
                               on non-standard lowspeed USB devices (kept for history)
   Makefile                    makefile to build and install
   README                      this file

Continuous Integration
----------------------

This repository now includes a GitHub Actions workflow that builds the kernel module inside Fedora containers (Fedora 37/38/39/40) on push and PRs. The workflow attempts to install prerequisites and run `make` inside the container; build artifacts (`dm2.ko`) are uploaded as workflow artifacts for inspection.


 Authors

   Andre Roth   <lynx@netlabs.org>
   Jan Jockusch <jan@jockusch.de>
