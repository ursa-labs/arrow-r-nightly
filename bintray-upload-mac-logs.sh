#! /bin/bash

# Variables to customize for your destination repository
# BINTRAY_APIKEY is set outside this script, encrypted
BINTRAY_USER=nealrichardson
BINTRAY_ORG=ursalabs # aka "subject"
BINTRAY_REPO="arrow-r"
BINTRAY_PKG=arrow
BINTRAY_VERSION=latest
R_PKG=$BINTRAY_PKG
TODAY=$(date +%Y%m%d)

PKG_TYPE="mac.binary.el-capitan"

# Generate the R repository relative path, depending on macOS/Windows
R_REPO_PATH=$(Rscript -e 'cat(contrib.url("", type="'$PKG_TYPE'"))')
# Concatenate that with the Bintray API URL
DST_URL="https://api.bintray.com/content/${BINTRAY_ORG}/${BINTRAY_REPO}/${BINTRAY_PKG}/${BINTRAY_VERSION}/logs${R_REPO_PATH}"

upload_file() {
  if [ -f "$1" ]; then
    echo "PUT ${DST_URL}/$1?override=1&publish=1"
    curl -sS -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "${DST_URL}/$TODAY-$1?override=1&publish=1" --data-binary "@$1"
  else
    echo "$1 not found"
  fi
}

upload_file 00install.out
