#!/usr/bin/env bash
# Time related helper functions.

##############################################################################
# Print the time and date (in UTC and local formats) for any given epoch
# second arguments to stdout; if no arguments are given the current epoch time
# is used.
#
# Ubuntu Docker container non UTC support may require:
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

# macOS   : date -u -j -f '%Y-%m-%d %H:%M:%S' '2021-06-01 16:35:16'
# macOS   : date -u -j -f '%Y-%m-%d %H:%M:%S' '2021-06-01 16:35:16' +'%s'
#         : 1622565316
# Ubuntu  : TZ=UTC date -d '2021-06-01 16:35:16' +'%s'
#         : 1622565316
function epoch_seconds_from_date_string() {
  if [ $# -ne 1 ]; then
    printf 'Usage                   : date_string\n'
    printf 'macOS example, UTC only : %s\n' "'2021-06-01 16:35:16'"
    printf 'Linux examples          : %s\n' "'2021-06-01 16:35:16'"
    printf '                        : %s\n' "'2021-06-01 16:35:16 BST'"
    printf '                        : %s\n' "'2021-06-01 16:35:16 PST'"
    return 1
  fi

  local date_string="${1}"

  if [[ $(uname) == 'Darwin' ]]; then
    local format_string='%Y-%m-%d %H:%M:%S'

    printf '%s : %s : %s\n' \
      "${date_string}" \
      "$(date -u -j -f "${format_string}" "${date_string}")" \
      "$(date -u -j -f "${format_string}" "${date_string}" +'%s')"
  else
    local time_zone='UTC'

    printf '%s : %s : %s\n' \
      "${date_string}" \
      "$(TZ="${time_zone}" date -d "${date_string}")" \
      "$(TZ="${time_zone}" date -d "${date_string}" +'%s')"
  fi
}
