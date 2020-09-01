# Nightly R package builds for Apache Arrow

[![Build Status](https://travis-ci.org/ursa-labs/arrow-r-nightly.svg?branch=master)](https://travis-ci.org/ursa-labs/arrow-r-nightly)
[![Windows binaries](https://github.com/ursa-labs/arrow-r-nightly/workflows/Binary%20Windows%20R%20packages/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Binary+Windows+R+packages")
[![C++ binaries](https://github.com/ursa-labs/arrow-r-nightly/workflows/Binary%20C++%20libraries/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Binary+C%2B%2B+libraries")
[![Linux source build](https://github.com/ursa-labs/arrow-r-nightly/workflows/Build%20source%20packages/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Build+source+packages")
[![Linux binary test](https://github.com/ursa-labs/arrow-r-nightly/workflows/Test%20binary%20installation/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Test+binary+installation")
[![Linux source test](https://github.com/ursa-labs/arrow-r-nightly/workflows/Test%20source%20installation/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Test+source+installation")
[![Daily pkgdown site](https://github.com/ursa-labs/arrow-r-nightly/workflows/Daily%20pkgdown%20site/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Daily+pkgdown+site")

This repository holds build scripts that pull the [`apache/arrow`](https://github.com/apache/arrow) repository and build and test the R package across several versions of R on macOS and Windows. They also build static `libarrow` C++ libraries for several Linux distributions.
These builds are triggered daily. C++ libraries are deployed to
https://dl.bintray.com/ursalabs/arrow-r, and R packages generated from those jobs
are pushed to a package repository at https://arrow-r-nightly.s3.amazonaws.com.

To install the latest version, use this repository as the first entry in your `"repos"` argument, ahead of your CRAN mirror, like

```r
install.packages("arrow", repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos")))
```

> Note: nightly packages were previously hosted at https://dl.bintray.com/ursalabs/arrow-r. Note the new URL.

These daily package builds are not official Apache releases and are not recommended for production use. They may be useful for testing bug fixes and new features under active development.

We currently build binary R packages for the following OS and versions:

* macOS: R 3.6, 4.0
* Windows: R 3.6, 4.0

We also build C++ static binaries for these Linux distributions and versions:

* Ubuntu: 16.04, 18.04
* Debian: 9, 10
* CentOS: 7, 8

Additional distribution-versions are supported by mapping them to binary builds that we know to work for them, such as Fedora to CentOS. See [distro-map.csv](https://github.com/ursa-labs/arrow-r-nightly/blob/master/linux/distro-map.csv) for a complete list.

Daily builds are kept for 30 days.

The `pkgdown` documentation site is also built daily. See https://ursalabs.org/arrow-r-nightly/.
