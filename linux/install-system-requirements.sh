#! /bin/bash

if [ "`which dnf`" ]; then
  dnf install -y libcurl-devel openssl-devel
elif [ "`which yum`" ]; then
  yum install -y libcurl-devel openssl-devel
elif [ "`which zypper`" ]; then
  zypper install -y libcurl-devel libopenssl-devel
else
  apt-get update
  apt-get install -y libcurl4-openssl-dev libssl-dev
fi

# Install patch if it doesn't already exist
# Only needed while we are patching snappy
 if [ ! $(command -v patch) ]; then
   if [ "`which dnf`" ]; then
     dnf install -y patch
   elif [ "`which yum`" ]; then
     yum install -y patch
   elif [ "`which zypper`" ]; then
     zypper install -y patch
   else
     apt-get update
     apt-get install -y patch
   fi
 fi
 
