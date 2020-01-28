source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")
install.packages(
  "arrow",
  repos = c("https://dl.bintray.com/ursalabs/arrow-r", getOption("repos")),
  verbose = TRUE
)

library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))
