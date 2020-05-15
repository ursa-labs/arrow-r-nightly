# Install dependencies by installing (yesterday's) binary, then removing it
install.packages("arrow",
  type = "binary",
  repos = c("https://dl.bintray.com/ursalabs/arrow-r", "https://cloud.r-project.org")
)
remove.packages("arrow")

# Build
Sys.setenv(MAKEFLAGS = paste0("-j", parallel::detectCores()))
install.packages("arrow",
  type = "source",
  repos = "https://dl.bintray.com/ursalabs/arrow-r",
  INSTALL_opts="--build"
)

# Test
library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))

# Upload
on_windows <- tolower(Sys.info()[["sysname"]]) == "windows"
tools::write_PACKAGES(".", type = ifelse(on_windows, "win.binary", "mac.binary"))

Sys.setenv(REPO_PATH=contrib.url("", type = "binary"))
status <- system("bash bintray-upload.sh")
if (status > 0) {
  stop("Upload failed")
}
