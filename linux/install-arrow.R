source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")

# We need dev remotes for system_requirements
install.packages("https://github.com/r-lib/remotes/archive/master.tar.gz", repos = NULL, type = "source")
remotes::install_github("nealrichardson/distro")
d <- distro::distro()
if (!(d$id %in% names(remotes:::supported_os_versions()))) {
  # Let's see if we can map this to something else we know
  os <- paste0(d$id, "-", d$short_version)
  lookup <- utils::read.csv("linux/distro-map.csv", stringsAsFactors = FALSE)
  if (os %in% lookup$actual) {
    new <- unlist(strsplit(lookup$use_this[lookup$actual == os], "-"))
    d <- list(id = new[1], short_version = new[2])
  }
}
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
