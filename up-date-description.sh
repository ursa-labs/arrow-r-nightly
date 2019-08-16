#! /bin/bash

TODAY=$(date +%Y%m%d)
sed -i.bak -E -e \
  's/(^Version: [0-9]+\.[0-9]+\.[0-9]+).*$/\1.'"${TODAY}"'/' \
  DESCRIPTION
rm -f DESCRIPTION.bak
