#! /bin/bash

# Variables to customize for your destination repository
# BINTRAY_APIKEY is set outside this script, encrypted
BINTRAY_USER=nealrichardson
BINTRAY_ORG=ursalabs # aka "subject"
BINTRAY_REPO="arrow-r"
BINTRAY_PKG=arrow
BINTRAY_VERSION=latest
R_PKG=$BINTRAY_PKG

# If PKG_FILE is set, we'll just upload that (also have to set REPO_PATH); else
# find the binary package file for either macOS or Windows, or a source package
ls ${R_PKG}_*.*
if [ "$PKG_FILE" = "" ]; then
  PKG_FILE=$(ls ${R_PKG}_*.tgz 2> /dev/null)
  if [ "$PKG_FILE" != "" ]; then
    PKG_TYPE="mac.binary.el-capitan"
  else
    PKG_FILE=$(ls ${R_PKG}_*.zip 2> /dev/null)
    if [ "$PKG_FILE" != "" ]; then
      PKG_TYPE="win.binary"
    else
      PKG_FILE=$(ls ${R_PKG}_*.tar.gz 2> /dev/null)
      if [ "$PKG_FILE" != "" ]; then
        PKG_TYPE="source"
      else
        echo "R package not found"
        exit 1
      fi
    fi
  fi
  # Generate the R repository relative path, depending on macOS/Windows
  REPO_PATH=$(Rscript -e 'cat(contrib.url("", type="'$PKG_TYPE'"))')
fi

# Concatenate that with the Bintray API URL
DST_URL="https://api.bintray.com/content/${BINTRAY_ORG}/${BINTRAY_REPO}/${BINTRAY_PKG}/${BINTRAY_VERSION}${REPO_PATH}"

upload_file() {
  if [ -f "$1" ]; then
    echo "PUT ${DST_URL}/$1?override=1&publish=1"
    # curl -sS -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "${DST_URL}/$1?override=1&publish=1" --data-binary "@$1"
  else
    echo "$1 not found"
  fi
}

# Upload the binary package
upload_file $PKG_FILE

if [ "$PKG_TYPE" != "" ]; then
  # Write out the PACKAGES manifest files and upload them too
  Rscript -e 'tools::write_PACKAGES(".", type = substr("'$PKG_TYPE'", 1, 10))'
  upload_file PACKAGES
  upload_file PACKAGES.gz
  upload_file PACKAGES.rds
fi
