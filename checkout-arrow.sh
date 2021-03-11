#! /bin/bash

: ${FORK:="apache"}

git clone https://github.com/${FORK}/arrow
cd arrow

if [ "${REF}" != "" ]; then
  git checkout ${REF}
fi
cd r

if [ "${DATE}" != "" ]; then
  sed -i.bak -E -e \
    's/(^Version: [0-9]+\.[0-9]+\.[0-9]+).*$/\1.'"${DATE}"'/' \
    DESCRIPTION
  rm -f DESCRIPTION.bak
fi

cp ../dev/tasks/homebrew-formulae/autobrew/apache-arrow.rb tools/apache-arrow.rb
# Pin the git commit in the formula to match
cd tools
sed -i.bak -E -e 's/arrow.git"$/arrow.git", :revision => "'"$(git rev-list -n 1 HEAD)"'"/' apache-arrow.rb
rm -f apache-arrow.rb.bak