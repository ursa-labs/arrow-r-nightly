on_windows <- tolower(Sys.info()[["sysname"]]) == "windows"

# Install dependencies by installing (yesterday's) binary, then removing it
install.packages("arrow",
  type = "binary",
  repos = c("https://arrow-r-nightly.s3.amazonaws.com", "https://cloud.r-project.org")
)
remove.packages("arrow")

# Build
Sys.setenv(MAKEFLAGS = paste0("-j", parallel::detectCores()))
INSTALL_opts <- "--build"
if (!on_windows) {
  # Windows doesn't support the --strip arg
  INSTALL_opts <- c(INSTALL_opts, "--strip")
}
install.packages("arrow",
  type = "source",
  repos = "https://arrow-r-nightly.s3.amazonaws.com",
  INSTALL_opts = INSTALL_opts
)

# Test
library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))

# Upload
tools::write_PACKAGES(".", type = ifelse(on_windows, "win.binary", "mac.binary"))
python <- ifelse(on_windows, "python", "python3")
repo_path <- contrib.url("", type = "binary")
pkg_file <- dir(pattern = "^arrow_")
for (f in c(pkg_file, "PACKAGES", "PACKAGES.gz", "PACKAGES.rds")) {
  status <- system(paste(python, "s3-upload.py", f, repo_path))
  if (status > 0) {
    stop("Upload failed")
  }
}
