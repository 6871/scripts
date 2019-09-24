#!/usr/bin/env bash
# Disk related helper functions.

#############################################################################
# Convert an ISO file to a format suitable for writing to a USB boot disk.
#
# Arguments:
#   1 : The ISO file to be converted to an image file
#   2 : The image file to be created
# Returns:
#   0 on success, non zero on failure
function iso_to_img() {
  if [[ $# -eq 2 ]]; then
    local disk_iso="$1"
    local disk_img="$2"
    hdiutil convert "${disk_iso}" -format UDRW -o "${disk_img}"
    mv -i "${disk_img}.dmg" "${disk_img}"
  else
    printf 'usage: source_file target_file\n' >&2
    return 64
  fi
}

#############################################################################
# Reset a disk (typically USB) to a macOS compatible state.
#
# Arguments:
#   1 : The number of the disk to be reset (identify with: diskutil list)
# Returns:
#   0 on success, non zero on failure
function reset_disk() {
  if [[ $# -eq 1 ]]; then
    local disk_number="$1"
    local status_sudo_ok
    local status_disk_exists
    local number_of_partitions=1
    local partition_scheme='GPT' # GUID Partitioning Table (Intel Mac)
    local partition_1_fs_format='Free Space'
    local partition_1_volume_name='%noformat%'
    local partition_1_size='100%'

    local dev_disk="/dev/disk${disk_number}"
    diskutil list "${dev_disk}" >/dev/null
    status_disk_exists=$?
    if [[ ${status_disk_exists} -eq 0 ]]; then
      printf 'Found disk "%s"\n' "${dev_disk}" >&2
      diskutil list
      read -p "Reset disk ${dev_disk} (y/n)? : " -r
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        printf 'Enter sudo password (diskutil operations require sudo):\n'
        sudo true
        status_sudo_ok=$?
        if [[ ${status_sudo_ok} -eq 0 ]]; then
          printf 'Resetting "%s" with partition scheme "%s"...\n' \
            "${dev_disk}" "${partition_scheme}" >&2
          sudo diskutil partitionDisk "${dev_disk}" \
            "${number_of_partitions}" "${partition_scheme}" \
            "${partition_1_fs_format}" \
            "${partition_1_volume_name}" "${partition_1_size}"
          printf 'Unmounting "%s"...\n' "${dev_disk}" >&2
          diskutil unmountDisk "${dev_disk}"
          printf 'Ejecting "%s" (may fail)...\n' "${dev_disk}" >&2
          sudo diskutil eject "${dev_disk}"
          sudo -k
          printf 'Reset of "%s" complete\n' "${dev_disk}" >&2
          return 0
        else
          printf 'ERROR: sudo failed, no changes made\n' >&2
        fi
      else
        printf 'No changes made\n' >&2
      fi
    else
      diskutil list
      printf 'ERROR: "%s" not found; try: diskutil list\n' "${dev_disk}" >&2
    fi
  else
    printf 'usage: target_disk_number\n' >&2
  fi

  return 64
}

#############################################################################
# Write a disk image file to a target disk.
#
# Arguments:
#   1 : The source image file that will be written to the target disk
#   2 : The number of the disk that the image file will be written to
# Returns:
#   0 on success, non zero on failure
function write_to_disk() {
  if [[ $# -eq 2 ]]; then
    local disk_image="$1"
    local disk_number="$2"
    local status_sudo_ok
    local status_dev_disk_exists
    local status_dev_rdisk_exists
    local dev_disk="/dev/disk${disk_number}"
    local dev_rdisk="/dev/rdisk${disk_number}"

    diskutil list "${dev_disk}" > /dev/null
    status_dev_disk_exists=$?
    if [[ ${status_dev_disk_exists} -eq 0 ]]; then
      printf 'Found disk "%s"\n' "${dev_disk}" >&2
      diskutil list "${dev_rdisk}" 2>/dev/null
      status_dev_rdisk_exists=$?
      if [[ ${status_dev_rdisk_exists} -eq 0 ]]; then
        printf 'Found disk "%s"\n' "${dev_rdisk}" >&2
        read -p "Overwrite ${dev_rdisk} with ${disk_image} (y/n)? : " -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          printf 'Enter sudo password (diskutil operations need sudo)\n:' >&2
          sudo true
          status_sudo_ok=$?
          if [[ ${status_sudo_ok} -eq 0 ]]; then
            printf 'Unmounting "%s"...\n' "${dev_disk}" >&2
            diskutil unmountDisk "${dev_disk}"
            printf 'Copying "%s" to "%s" (ctrl-t for status)...\n' \
              "${disk_image}" " ${dev_rdisk}" >&2
            sudo dd bs=1m "if=${disk_image}" of="${dev_rdisk}"
            printf 'Ejecting "%s" (may fail)...\n' "${dev_disk}" >&2
            sudo diskutil eject "${dev_rdisk}"
            printf 'Copy complete\n' >&2
            return 0
          else
            printf 'ERROR: sudo failed, no changes made\n' >&2
          fi
        else
          printf 'No changes made\n' >&2
        fi
      else
        printf 'ERROR: "%s" not found; try: diskutil list\n' \
          "${dev_rdisk}" >&2
      fi
    else
      printf 'ERROR: "%s" not found; try: diskutil list\n' "${dev_disk}" >&2
    fi
  else
    printf 'usage: source_file target_disk_number\n' >&2
  fi

  return 64
}
