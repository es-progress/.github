#!/usr/bin/env bash
#################
## Test script ##
#################

function _msg() {
  local msg="${1:?Message missing}"
  echo "${msg}"
}

# Strict mode
set -eufo pipefail
IFS=$'\n\t'

for f in *.m3u
do
  grep -qi "hq.*mp3" "$f" \
    && echo -e "'Playlist ${f} contains a HQ file in mp3 format'"
done

case "$1" in
  Testing)
    _msg Testing
    ;;
  Production)
    _msg Production
    ;;
  *) echo "test.sh: invalid case" >&2 ;;
esac

_msg "End of test script."

exit 0
