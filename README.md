# Nightly binary R package builds for Apache Arrow

[![Build Status](https://travis-ci.org/ursa-labs/arrow-r-nightly.png?branch=master)](https://travis-ci.org/ursa-labs/arrow-r-nightly) [![Build status](https://ci.appveyor.com/api/projects/status/ume8udm5r26u2c9l/branch/master?svg=true)](https://ci.appveyor.com/project/nealrichardson/arrow-r-nightly-yxl55/branch/master) [![codecov](https://codecov.io/gh/ursa-labs/arrow-r-nightly/branch/master/graph/badge.svg)](https://codecov.io/gh/ursa-labs/arrow-r-nightly)

This repository holds Travis and Appveyor build scripts that pull the [`apache/arrow`](https://github.com/apache/arrow) repository and build and test the R package across several versions of R on macOS and Windows. These builds are triggered daily. Binary packages generated from those jobs are then pushed to a Bintray repository at https://dl.bintray.com/ursalabs/arrow-r.

To install the latest version, use this Bintray repository as the `"repos"` argument, like

```r
install.packages("arrow", repos="https://dl.bintray.com/ursalabs/arrow-r")
```

These daily package builds are not official Apache releases and are not recommended for production use. They may be useful for testing bug fixes and new features under active development.

We currently build binaries for the following OS and versions:

* macOS: R 3.2, 3.3, 3.4, 3.5, 3.6
* Windows: R 3.4, 3.5, 3.6, R-devel (3.7)
