#!/usr/bin/env bash

# automatically extract the most recently downloaded firmware and push the
# left.uf2 file to the keyboard when the keyboard is detected

# chmod +x ~/.dotfiles/scripts/kb_firmware.sh
# kb_firmware.service deprecated in favor of defining the service in nixos config

echo "Adv360 found; begin update service"

source="/home/n/Downloads/"
dest="/media/n/ADV360PRO/"

# get the most recently downloaded firmware
firmware=$(find "$source" -type f -name "firmware*.zip" -exec ls -t {} + | head -n 1)

if [ -n "$firmware" ]; then
    echo "Firmware found: $firmware"
    # unzip to keyboard if the left.uf2 file exists
    if unzip -l "$firmware" | grep -q "left.uf2"; then
        echo 'Extracting...'
        unzip "$firmware" left.uf2 -d "$dest"
    else
        echo "No 'left.uf2' file found in firmware archive"
    fi
else
    echo "No firmware found"
fi
