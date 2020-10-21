source("https://raw.githubusercontent.com/apache/arrow/master/ci/etc/rprofile")

# We need dev remotes for system_requirements
install.packages("pak")
pak::pkg_install("r-lib/remotes")
pak::pkg_install("nealrichardson/distro")
d <- distro::distro()
# curl has same sysreqs so use it today (since arrow with updated sysreqs isn't yet on RSPM)
sysreqs <- remotes::system_requirements(d$id, d$short_version, package = "curl")
for (s in sysreqs) system(s)

install.packages(
  "arrow",
  repos = c("https://arrow-r-nightly.s3.amazonaws.com", getOption("repos")),
  verbose = TRUE
)

library(arrow)
read_parquet(system.file("v0.7.1.parquet", package = "arrow"))
