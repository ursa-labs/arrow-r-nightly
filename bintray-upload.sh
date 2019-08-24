#! /bin/bash

# Variables to customize for your destination repository
# BINTRAY_APIKEY is set outside this script, encrypted
BINTRAY_USER=nealrichardson
BINTRAY_ORG=ursalabs # aka "subject"
BINTRAY_REPO="arrow-r"
BINTRAY_PKG=arrow
BINTRAY_VERSION=latest
R_PKG=$BINTRAY_PKG

# Find the binary package file for either macOS or Windows
PKG_FILE=$(ls ${R_PKG}_*.tgz)
if [ "$PKG_FILE" != "" ]; then
  PKG_TYPE="mac.binary.el-capitan"
else
  PKG_FILE=$(ls ${R_PKG}_*.zip)
  if [ "$PKG_FILE" != "" ]; then
    PKG_TYPE="win.binary"
  else
    echo "Binary package not found"
    exit 1
  fi
fi
# Generate the R repository relative path, depending on macOS/Windows
R_REPO_PATH=$(Rscript -e 'cat(contrib.url("", type="'$PKG_TYPE'"))')
# Concatenate that with the Bintray API URL
DST_URL="https://api.bintray.com/content/${BINTRAY_ORG}/${BINTRAY_REPO}/${BINTRAY_PKG}/${BINTRAY_VERSION}${R_REPO_PATH}"

# Upload the binary package
curl -fsSv -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "${DST_URL}/${PKG_FILE}?override=1&publish=1" --data-binary "@$PKG_FILE"

# Write out the PACKAGES manifest files and upload them too
Rscript -e 'tools::write_PACKAGES(".", type = substr("'$PKG_TYPE'", 1, 10))'
for FILENAME in PACKAGES*; do
  curl -fsS -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "${DST_URL}/${FILENAME}?override=1&publish=1" --data-binary "@$FILENAME"
done
