#!/usr/bin/env bash
# Java related helper functions.

#############################################################################
# Recursively search JAR files for a string value, print matches to stdout.
#
# Arguments:
#   1 : the directory from which to search recursively for JAR files
#   2 : the package/class search string to be found in the JAR file(s)
#   3 : optional filter for JAR file(s) to search; defaults to '*.jar'
# Returns:
#   0 on success, non zero on failure
function find_in_jars() {
  if [[ $# -lt 2 || $# -gt 3 ]]; then
    printf 'usage: find_in_jars search_dir search_string [jar_filter]\n' >&2
    return 64
  else
    local search_dir="$1"
    local search_string="$2"
    local jar_filter="${3:-*.jar}"
    local i
    find "${search_dir}" -name "${jar_filter}" -type f |
    while read -r i; do
      jar -tvf "$i" | grep -i "${search_string}" \
      | xargs -I '{}' printf "$i : %s\n" '{}' \
      | grep --color "${search_string}"
    done
  fi
}
