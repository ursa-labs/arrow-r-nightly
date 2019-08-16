#! /bin/bash
upload_file() {
  curl -fsSv -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "https://api.bintray.com/content/nealrichardson/arrow-r/arrow/latest/bin/windows/contrib/3.6/$1?override=1&publish=1" --data-ascii "@$1"
}
export -f upload_file

ls $1
ls "$1"
ls "$1" | xargs -n 1 bash -c "upload_file $@"
