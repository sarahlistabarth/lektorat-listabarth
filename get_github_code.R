library(httr)
library(dotenv)
library(here)
if(!exists("at")) {at <- Sys.getenv("at")}

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
      authenticate("s.zeller@posteo.net", at),    
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
