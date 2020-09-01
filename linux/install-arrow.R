source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")
install.packages(
  "arrow",
  repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos")),
  verbose = TRUE
)

library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))
