#!/usr/bin/env bash

# Along with kb_firmware.service, this automatically extracts the most recently
# downloaded firmware and pushes the left.uf2 file to the keyboard when the
# keyboard is detected

# chmod +x ~/.dotfiles/scripts/kb_firmware.sh
# cp ~/.dotfiles/kb_firmware.service /etc/systemd/system/
# sudo systemctl enable kb_firmware.service
# sudo systemctl start kb_firmware.service

source="/home/n/Downloads/"
dest="/media/n/ADV360PRO/"

# get the most recently downloaded firmware
firmware=$(find "$source" -type f -name "firmware*.zip" -exec ls -t {} + | head -n 1)

if [ -n "$firmware" ]; then
    # unzip to keyboard if the left.uf2 file exists
    if unzip -l "$firmware" | grep -q "left.uf2"; then
        unzip "$firmware" left.uf2 -d "$dest"
    fi
fi
