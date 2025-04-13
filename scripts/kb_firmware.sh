#!/usr/bin/env bash

# automatically extract the most recently downloaded firmware and push the
# left.uf2 file to the keyboard when the keyboard is detected

LABEL="ADV360PRO"
TARGET="/dev/disk/by-label/$LABEL"
MOUNTPOINT="/mnt/adv360/"
REPO="$HOME/Repos/Adv360-Pro-ZMK"

OLD_FIRMWARE_MSG="This firmware artifact is greater than 24 hrs old. Do you want to flash it to $LABEL?\n[y/N] "

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT


_jq() {
    echo "$data" | jq -r ".[].$1"
}


get_firmware() {
    find "$TMP_DIR" -name "*$1.uf2" -exec realpath {} \;
}


yes_no() {
    local response

    read -rp "$1" response
    response=${response,,}

    [[ "$response" =~ ^(yes|y)$ ]]
}


download_run_artifacts() {

    local artifact current_ts data date days name run_id status target_ts title url

    echo "Retreiving latest firmware from GitHub..."

    cd "$REPO"

    data=$(gh run list -L 1 --json databaseId,displayTitle,name,status,updatedAt,url)

    date=$(_jq 'updatedAt')
    name=$(_jq 'name')
    run_id=$(_jq 'databaseId')
    status=$(_jq 'status')
    title=$(_jq 'displayTitle')
    url=$(_jq 'url')

    artifact="$name: '$title'"

    if [ "$status" == "completed" ]; then

        target_ts=$(date -d "$date" +%s)
        current_ts=$(date -u +%s)
        days=$(( (current_ts - target_ts) / 86400 ))

        echo "$artifact $status at $date"
        echo "$url"

        if [ $days -gt 0 ] && ! yes_no "$OLD_FIRMWARE_MSG"; then
            exit 1
        fi

        gh run download "$run_id" -n firmware-no-clique -D "$TMP_DIR"

    else

        echo "$artifact not yet completed [$status]"
        echo "$url"
        exit

    fi

}


wait_for_mount() {

    local timeout elapsed

    timeout=30
    elapsed=0

    echo "Ready to mount $1 board. Waiting for $LABEL..."

    while [ ! -e "$TARGET" ]; do
        sleep 1
        elapsed=$((elapsed + 1))
        if [ $elapsed -ge $timeout ]; then
            echo "Timeout: $LABEL not found within $timeout seconds"
            return 1
        fi
    done

    echo "$LABEL found, mounting..."

    sudo mount "$TARGET" "$MOUNTPOINT"

}


flash_firmware() {

    local firmware

    wait_for_mount "$1"

    firmware=$(get_firmware "$1")

    if [ -f "$firmware" ]; then
        echo "Firmware found: $firmware"
        echo "Flashing..."

        sudo mv "$firmware" "$MOUNTPOINT" 2>/dev/null

        while [ -e "$TARGET" ]; do
            sleep 1
        done

        echo "${1^} board flash complete"
    else
        echo "No firmware found"
        exit 1
    fi

}


run() {
    set -e
    sudo -v
    download_run_artifacts
    flash_firmware "left"

    if yes_no "Flash right board? [y/N] "; then
        flash_firmware "right"
    fi

}

run
