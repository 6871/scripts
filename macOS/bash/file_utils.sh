#!/usr/bin/env bash
# File related helper functions.

#############################################################################
# Recursively search files for a string value.
#
# Arguments:
#   1 : the directory from which to search
#   2 : file filter to determine which files to search, e.g. "*.tf"
#   3 : search string (regex)
# Returns:
#   0 on success, non zero on failure
function find_in_files() {
  if [[ $# -eq 3 ]]; then
    local search_dir="$1"
    local search_filter="$2"
    local search_regex="$3"

    grep --color --recursive --line-number \
      --include="${search_filter}" -- "${search_regex}" "${search_dir}"
  else
    printf 'usage: find_in_files directory file_filter regex\n' >&2
    return 64
  fi
}
