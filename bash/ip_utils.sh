#!/usr/bin/env bash
# IP related helper functions.

##############################################################################
# Print host IP addresses that match optional filter.
#
# Arguments:
#   1 : Optional IP address filter, matches from line start; e.g. 192.168
# Returns:
#   0 on success, non zero on failure
function ip_list() {
  local filter
  if [[ $# -gt 0 ]]; then
    filter="$1"
  fi

  local ip
  for ip in $(hostname --all-ip-addresses); do
    local cut_length=${#filter}
    if [[ cut_length -eq 0 ]]; then
      cut_length=${#ip}
    fi

    # Use cut to simulate search from line start (can't use ^ with grep -F)
    local match
    match=$( \
      printf '%s\n' "${ip}" \
      | cut -c 1-"${cut_length}"  \
      | grep -F "${filter}")

    if [[ ${#match} -gt 0 ]]; then
      printf '%s\n' "${ip}" | grep --color -F "${filter:-${ip}}"
    fi
  done
}
