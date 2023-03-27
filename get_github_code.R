library(httr)
library(dotenv)
library(here)

# check that env variable exists

# fail on missing env vars
missing_env <- function(key){
  result <- is.na(Sys.getenv(key,unset = NA_character_))
  if(result) warning(paste0("Missing env var: ",key))
  result
}

if(missing_env("ACCESS_TOKEN_MACROS")) stop("credentials not found")

if(!exists("ACCESS_TOKEN_MACROS")) {
  ACCESS_TOKEN_MACROS <- Sys.getenv("ACCESS_TOKEN_MACROS")
  cat("Accessing the access token now. It has", nchar(ACCESS_TOKEN_MACROS), "characters")
  }

if (!"macros" %in% list.files()) {
  dir.create("macros")
}

# Source R script from Github
scrape_macro <- function(macro_name) {
  url <- paste0("https://api.github.com/repos/szeller42/Word-macros/contents/",
                macro_name,
                "().vb",
                collapse = "")
  file_name <- paste0("macros/", macro_name, ".vb",
                      collapse = "")
  macro_script <-
    GET(
      url = url,
      authenticate("s.zeller@posteo.net", ACCESS_TOKEN_MACROS),    
      accept("application/vnd.github.v3.raw")
    ) |> 
    content(as = "text")
  
  write(macro_script,
        file_name)
}

macro_names <- c("AddM",
                 "AddN",
                 "AddR",
                 "AddS",
                 "Bindestrich",
                 "Compositum",
                 "Compositum_ohne_des",
                 "FindAndDeleteRFC",
                 "HoldMySpot",
                 "MarkierungenLoeschen",
                 "MoveToEndOfWord",
                 "SatzendeMarkieren",
                 "StopCombinationsAddEntry",
                 "Synonyme",
                 "countTC",
                 "deleteLastCharOfWord",
                 "geschuetztesLeerzeichen",
                 "swapSingularPlural",
                 "ZitatKlammernZuText"
                 # "toggleUmlaut"
                 )
sapply(macro_names, scrape_macro)
