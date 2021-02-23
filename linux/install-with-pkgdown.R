source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")
options(
  install.packages.check.source = "no",
  repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos"))
)
install.packages("remotes", verbose = TRUE)
# when https://github.com/r-lib/pkgdown/pull/1466 is released, can go back to std install
remotes::install_github("r-lib/pkgdown")
remotes::install_local("arrow/r", dependencies = TRUE, verbose = TRUE, build = FALSE)
