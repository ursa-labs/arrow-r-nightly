#! /bin/bash

# This script relies on three environment variables, which in the
# GitHub Actions workflow are set by the `setup` job:
#
# * FORK: which fork of apache/arrow to clone
# * REF: which commit or ref on that repository to check out
# * DATE: a version suffix to use. Dev versions of the R package
#     have a version number like x.y.z.9000; if $DATE is set,
#     this script will set the version to x.y.z.$DATE

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
