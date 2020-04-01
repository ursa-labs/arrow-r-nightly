source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")
options(
  install.packages.check.source = "no",
  repos = c("https://dl.bintray.com/ursalabs/arrow-r", getOption("repos"))
)
install.packages("arrow", dependencies = TRUE, verbose = TRUE)
# install.packages("pkgdown", verbose = TRUE)
install.packages("remotes")
remotes::install_github("r-lib/pkgdown@v1.4.1")
