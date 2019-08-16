#! /bin/bash

RVERSION=$(Rscript -e 'rv <- R.version; cat(paste0(rv$major, ".", unlist(strsplit(rv$minor, ".", fixed=TRUE))[1]))')

upload_file() {
  curl -fsSv -u "${BINTRAY_USER}:${BINTRAY_APIKEY}" -X PUT "https://api.bintray.com/content/nealrichardson/arrow-r/arrow/latest/bin/windows/contrib/${RVERSION}/$1?override=1&publish=1" --data-binary "@$1"
}
export -f upload_file

ls $1 | xargs -n 1 bash -c "upload_file $@"
