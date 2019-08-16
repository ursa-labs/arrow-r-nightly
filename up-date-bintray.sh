#! /bin/bash

RVERSION=$(R --slave -e 'rv <- R.version; cat(paste0(rv$major, ".", unlist(strsplit(rv$minor, ".", fixed=TRUE))[1]))')
perl -pe 's/RVERSION/'"${RVERSION}"'/' -i bintray.json
