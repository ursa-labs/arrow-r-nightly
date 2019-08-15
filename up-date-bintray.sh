#! /bin/bash

# TODAY=$(date +%Y%m%d) && perl -pe 's/latest/'"${TODAY}"'/' -i bintray.json
R_VERSION=$(R --slave -e 'rv <- R.version; cat(paste0(rv$major, ".", unlist(strsplit(rv$minor, ".", fixed=TRUE))[1]))')
perl -pe 's/RVERSION/'"${R_VERSION}"'/' -i bintray.json
