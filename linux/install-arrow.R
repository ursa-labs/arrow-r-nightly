source("https://raw.githubusercontent.com/apache/arrow/3a0abf03c07473a84123e4805157348d24e80220/ci/etc/rprofile")
install.packages(
  "arrow",
  repos = c("https://dl.bintray.com/ursalabs/arrow-r", getOption("repos")),
  verbose = TRUE
)

library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))
