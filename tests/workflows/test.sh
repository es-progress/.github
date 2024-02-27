#!/usr/bin/env bash
#################
## Test script ##
#################

function _msg() {
  local msg="${1?:Message missing}"
  echo "${msg}"
}

# Strict mode
set -eufo pipefail
IFS=$'\n\t'

_msg Testing

exit 0
