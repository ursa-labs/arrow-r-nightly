source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")

# We need dev remotes for system_requirements
install.packages("https://github.com/r-lib/remotes/archive/master.tar.gz", repos = NULL, type = "source")
remotes::install_github("nealrichardson/distro")
d <- distro::distro()
# curl has same sysreqs so use it today (since arrow with updated sysreqs isn't yet on RSPM)
sysreqs <- remotes::system_requirements(d$id, d$short_version, package = "curl")
if (any(grepl("apt-get", sysreqs))) {
  system("apt-get update -y")
}
for (s in sysreqs) system(s)

install.packages(
  "arrow",
  repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos")),
  verbose = TRUE
)

library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))
