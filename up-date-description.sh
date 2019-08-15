#! /bin/bash

TODAY=$(date +%Y%m%d) && perl -pe 's/(^Version: [0-9]+\.[0-9]+\.[0-9]+).*$/\1.'"${TODAY}"'/' -i DESCRIPTION
