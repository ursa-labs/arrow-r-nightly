library(httr)
library(dplyr)

MAX_AGE <- as.numeric(Sys.getenv("MAX_AGE", 30))
MAX_REQUESTS <- as.numeric(Sys.getenv("MAX_REQUESTS", 30))

auth <- authenticate("nealrichardson", Sys.getenv("BINTRAY_APIKEY"))
all_files_url <- "https://api.bintray.com/packages/ursalabs/arrow-r/arrow/files"

files <- all_files_url %>%
  GET(config = auth) %>%
  content("text") %>%
  jsonlite::fromJSON(simplifyDataFrame = TRUE) %>%
  mutate(date = as.Date(substr(created, 1, 10))) %>%
  select(path, size, date) %>%
  filter(date < (Sys.Date() - MAX_AGE)) %>%
  arrange(desc(size)) %>%
  pull(path) %>%
  head(MAX_REQUESTS)

for (f in paste0("https://api.bintray.com/content/ursalabs/arrow-r/", files)) {
  print(DELETE(f, config = auth))
}
