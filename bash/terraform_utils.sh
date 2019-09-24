#!/usr/bin/env bash
# Terraform related helper functions.

#############################################################################
# Get the latest stable Terraform version number from releases.hashicorp.com.
#
# Arguments:
#   None
# Returns:
#   0 on success, non zero on failure
function get_latest_terraform_version() {
  # 1. curl to get HTML listing of Terraform versions
  # 2. grep to chop out (-o) HTML lines with non alpha/beta versions
  #    '^\s*<a [^>]*>terraform_[0-9]+\.[0-9]+\.[0-9]+<'
  #     ^                                               : line start
  #      \s*                                            : whitespace
  #         <a                                          : string "<a "
  #            [^>]*                                    : not ">"
  #                 >terraform_                         : ">terraform_"
  #                            [0-9]+                   : 1+ 0-9 chars
  #                                  \.                 : string "."
  #                                         ...
  #                                                  <  : string "<"
  # 3. grep to locate and chop out (-o) the version link text
  # 4. grep to locate and chop out (-o) only the version string
  # 5. awk to format version numbers with leading zeros so they can be sorted
  #    e.g.:
  #       echo "42.24.42" \
  #       | awk -F "." '{printf "%03s.%03s.%03s %s\n", $1, $2, $3, $0}'
  #    prints:
  #       042.024.042 42.24.42
  # 6. sort the list
  # 7. tail -1 to get the last release number (the most recent one)
  # 8. cut to extract original unformatted version from line end
  curl \
    --location \
    --silent \
    https://releases.hashicorp.com/terraform \
  | grep -Eo '^\s*<a [^>]*>terraform_[0-9]+\.[0-9]+\.[0-9]+<' \
  | grep -Eo 'terraform_[0-9]+\.[0-9]+\.[0-9]+' \
  | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' \
  | awk -F "." '{printf "%03s.%03s.%03s %s\n", $1, $2, $3, $0}' \
  | sort \
  | tail -1 \
  | cut -d " " -f 2
}
