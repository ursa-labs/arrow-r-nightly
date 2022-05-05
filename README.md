# Nightly R package builds for Apache Arrow

[![Build and test](https://github.com/ursa-labs/arrow-r-nightly/actions/workflows/build-and-test-all.yml/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions/workflows/build-and-test-all.yml)

This repository holds build scripts that pull the [`apache/arrow`](https://github.com/apache/arrow) repository and build and test the R package across several versions of R on macOS and Windows. They also build static `libarrow` C++ libraries for several Linux distributions and for Windows.
These builds are triggered daily and are pushed to a package repository at https://arrow-r-nightly.s3.amazonaws.com.

To install the latest version, use this repository as the first entry in your `"repos"` argument, ahead of your CRAN mirror, like

```r
install.packages("arrow", repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos")))
```

These daily package builds are not official Apache releases and are not recommended for production use. They may be useful for testing bug fixes and new features under active development.

We currently build binary R packages for the following OS and versions:

* macOS: R 4.0, 4.1
* Windows: R 4.0, 4.1

We also build a couple of versions of C++ static binaries for Linux:

* Ubuntu 18.04: gcc 7.5
* CentOS 7: gcc 4.8

Additional distribution-versions are supported by mapping them to binary builds that we know to work for them, such as Fedora to CentOS. See [distro-map.csv](https://github.com/ursa-labs/arrow-r-nightly/blob/master/linux/distro-map.csv) for a complete list. If you have a mapping you'd like to add, please [make a pull request](https://github.com/ursa-labs/arrow-r-nightly/edit/master/linux/distro-map.csv) to add one.

All Linux binaries except for `centos-7` include support for connecting to AWS S3, so they have additional system requirements--`libcurl` and `openssl`--that must be installed prior to installing `arrow`. The `aws-sdk-cpp` requires gcc >= 4.9 so is not supported in the gcc 4.8 build.

