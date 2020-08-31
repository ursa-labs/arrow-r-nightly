source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")
options(
  install.packages.check.source = "no",
  repos = c("https://arrow-r-nightly.s3.us-east-1.amazonaws.com", getOption("repos"))
)
install.packages(c("remotes", "pkgdown"), verbose = TRUE)
remotes::install_deps("arrow/r", dependencies = TRUE, verbose = TRUE)
