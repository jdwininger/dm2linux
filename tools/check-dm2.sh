#!/bin/bash
set -euo pipefail

# Simple runtime test for Mixman DM2 driver
# - checks for USB vendor:product
# - checks that amidi lists the Mixman DM2 device
# - sends a test Note On message

LSUSB_ID="0665:0301"

if ! lsusb -d ${LSUSB_ID} >/dev/null 2>&1; then
    echo "DM2 USB device ${LSUSB_ID} not found on bus." >&2
    exit 2
fi

echo "DM2 device present on USB (${LSUSB_ID})."

if ! command -v amidi >/dev/null 2>&1; then
    echo "amidi not found; please install alsa-utils to run this test." >&2
    exit 3
fi

DEV_LINE=$(amidi -l | grep -m1 -i "Mixman DM2" || true)
if [ -z "$DEV_LINE" ]; then
    echo "DM2 raw MIDI device not listed by amidi -l" >&2
    echo "Output of 'amidi -l':" >&2
    amidi -l || true
    exit 4
fi

DEV_HW=$(echo "$DEV_LINE" | awk '{print $2}')
if [ -z "$DEV_HW" ]; then
    echo "Could not parse hw device id from amidi output: $DEV_LINE" >&2
    exit 5
fi

echo "Found DM2 rawmidi device: $DEV_HW"
echo "Sending a test Note-On (channel 1, middle C, vel 127)..."
amidi -p "$DEV_HW" -S '90 3C 7F'
echo "Test message sent. Check device LEDs / behavior or dmesg for activity." 

exit 0
