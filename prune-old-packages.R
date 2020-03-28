library(httr)
library(dplyr)

MAX_AGE <- as.numeric(Sys.getenv("MAX_AGE", 30))
MAX_REQUESTS <- as.numeric(Sys.getenv("MAX_REQUESTS", 30))

auth <- authenticate("nealrichardson", Sys.getenv("BINTRAY_APIKEY"))
all_files_url <- "https://api.bintray.com/packages/ursalabs/arrow-r/arrow/files"

get_patch_version <- function(paths) {
  # For URLs containing arrow version x.y.z.p, return p, or 0 if version is x.y.z
  versions <- numeric_version(sub("^.*/arrow[-_]([0-9\\.]+)\\.[tz].*$", "\\1", paths))
  vapply(versions, function(v) {
    v <- unlist(v)
    if (length(v) > 3) {
      return(v[4])
    } else {
      return(0L)
    }
  }, integer(1))
}

files <- all_files_url %>%
  GET(config = auth) %>%
  content("text") %>%
  jsonlite::fromJSON(simplifyDataFrame = TRUE) %>%
  mutate(date = as.Date(substr(created, 1, 10))) %>%
  select(path, size, date) %>%
  # Only consider those older than MAX_AGE
  filter(date < (Sys.Date() - MAX_AGE)) %>%
  # Only purge dev/nightly versions (those x.y.z.p versions with p > 1000)
  filter(get_patch_version(path) > 1000) %>%
  # Sort the biggest first
  arrange(desc(size)) %>%
  pull(path) %>%
  head(MAX_REQUESTS)

for (f in paste0("https://api.bintray.com/content/ursalabs/arrow-r/", files)) {
  print(DELETE(f, config = auth))
}
