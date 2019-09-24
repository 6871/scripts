#!/usr/bin/env bash
# Time related helper functions.

##############################################################################
# Print the time and date (in UTC and local formats) for any given epoch
# second arguments to stdout; if no arguments are given the current epoch time
# is used.
#
# Ubunutu Docker container non UTC support may require:
#   apt-get update
#   export DEBIAN_FRONTEND=noninteractive
#   apt-get install --yes tzdata
#   export TZ=America/Chicago
#
# Arguments:
#   zero or more epoch second values to format
# Returns:
#   0 on success, non zero on failure
function epoch_seconds() {
  local inputs
  if [[ $# -eq 0 ]]; then
    # Default to current epoch seconds if no inputs
    inputs=("$(date +%s)")
  else
    inputs=("$@")
  fi

  local epoch_time
  for epoch_time in "${inputs[@]}"; do
    if [[ $(uname) == 'Darwin' ]]; then
      printf '%16s : %s : %s\n' \
        "${epoch_time}" \
        "$(date -u -r "${epoch_time}")" \
        "$(date -r "${epoch_time}")"
    else
      printf '%16s : %s : %s\n' \
        "${epoch_time}" \
        "$(date -u -d @"${epoch_time}")" \
        "$(date -d @"${epoch_time}")"
    fi
  done
}
