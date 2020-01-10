#! /bin/bash

: ${DATE:="$(date +%Y%m%d)"}
sed -i.bak -E -e \
  's/(^Version: [0-9]+\.[0-9]+\.[0-9]+).*$/\1.'"${DATE}"'/' \
  DESCRIPTION
rm -f DESCRIPTION.bak
