#!/usr/bin/env bash
# Markdown related helper functions.

##############################################################################
# Internal function to print a list output row.
#
# Arguments:
#   1 : Start directory
#   2 : Current depth in directory hierarchy
function md_utils_print_list_row() {
  local path="${1}"
  local depth="${2}"
  local name
  name="$(basename "${path}")"

  printf "%$(( "${depth}" * 2 ))s- [%s](%s)\n" "" "${name}" "${path}"
}

##############################################################################
# Internal function to process a directory's files and subdirectories.
#
# Arguments:
#   1 : Start directory
#   2 : Current depth in directory hierarchy
function md_utils_find_files_and_dirs() {
  local start_dir="${1}"
  local current_depth="${2}"
  local file

  find "${start_dir}" -maxdepth 1 -type f -not -path '*/\.*' | sort |
  while read -r file; do
    md_utils_print_list_row "${file}" "${current_depth}"
  done

  md_utils_find_dirs "${start_dir}" "${current_depth}"
}

##############################################################################
# Internal entry point function to process directories.
#
# Arguments:
#   1 : Start directory
#   2 : Current depth in directory hierarchy
function md_utils_find_dirs() {
  local start_dir="${1}"
  local current_depth="${2}"
  local dir
  find "${start_dir}" -maxdepth 1 -type d \
    -not -path '*/\.*' \
    -not -path "${start_dir}" \
  | sort | while read -r dir; do
    md_utils_print_list_row "${dir}" "${current_depth}"
    md_utils_find_files_and_dirs "${dir}" $(( "${current_depth}" + 1 ))
  done
}

##############################################################################
# Generate a hierarchical list of directories and files as a markdown list.
#
# Arguments:
#   1 : Start directory; optional, defaults to "."
# Returns:
#   0 on success, non zero on failure
function print_md_index() {
  local start_dir="${1:-.}"

  md_utils_find_dirs "${start_dir}" 0
}