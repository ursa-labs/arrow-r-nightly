# Nightly R package builds for Apache Arrow

[![Build Status](https://travis-ci.org/ursa-labs/arrow-r-nightly.png?branch=master)](https://travis-ci.org/ursa-labs/arrow-r-nightly)
[![Build status](https://ci.appveyor.com/api/projects/status/ume8udm5r26u2c9l/branch/master?svg=true)](https://ci.appveyor.com/project/nealrichardson/arrow-r-nightly-yxl55/branch/master)
[![Linux binary build](https://github.com/ursa-labs/arrow-r-nightly/workflows/Build%20binary%20C++%20libraries/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Build+binary+C%2B%2B+libraries")
[![Linux source build](https://github.com/ursa-labs/arrow-r-nightly/workflows/Build%20source%20packages/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Build+source+packages")
[![Linux binary test](https://github.com/ursa-labs/arrow-r-nightly/workflows/Test%20binary%20installation%20from%20Bintray/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Test+binary+installation+from+Bintray")
[![Linux source test](https://github.com/ursa-labs/arrow-r-nightly/workflows/Test%20source%20installation%20from%20Bintray/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Test+source+installation+from+Bintray")
[![Daily pkgdown site](https://github.com/ursa-labs/arrow-r-nightly/workflows/Daily%20pkgdown%20site/badge.svg)](https://github.com/ursa-labs/arrow-r-nightly/actions?query=workflow%3A"Daily+pkgdown+site")
[![codecov](https://codecov.io/gh/ursa-labs/arrow-r-nightly/branch/master/graph/badge.svg)](https://codecov.io/gh/ursa-labs/arrow-r-nightly)

This repository holds build scripts that pull the [`apache/arrow`](https://github.com/apache/arrow) repository and build and test the R package across several versions of R on macOS and Windows. They also build static `libarrow` C++ libraries for several Linux distributions.
These builds are triggered daily. Binary packages generated from those jobs are then pushed to a Bintray repository at https://dl.bintray.com/ursalabs/arrow-r.

To install the latest version, use this Bintray repository as the first entry in your `"repos"` argument, ahead of your CRAN mirror, like

```r
install.packages("arrow", repos = c("https://dl.bintray.com/ursalabs/arrow-r", getOption("repos")))
```

These daily package builds are not official Apache releases and are not recommended for production use. They may be useful for testing bug fixes and new features under active development.

We currently build binary R packages for the following OS and versions:

* macOS: R 3.2, 3.3, 3.4, 3.5, 3.6
* Windows: R 3.3, 3.4, 3.5, 3.6, R-devel (3.7)

We also build C++ static binaries for these Linux distributions and versions:

* Ubuntu: 16.04, 18.04
* Debian: 9, 10
* CentOS: 7, 8

Additional distribution-versions are supported by mapping them to binary builds that we know to work for them, such as Fedora to CentOS. See [distro-map.csv](https://github.com/ursa-labs/arrow-r-nightly/blob/master/linux/distro-map.csv) for a complete list.

The `pkgdown` documentation site is also built daily. See https://ursalabs.org/arrow-r-nightly/.
