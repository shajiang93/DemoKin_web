# This script modifies the .Rmd files inside the vignettes directory to add pkgdown metadata

# List of vignette files to process
vignette_files <- c(
  "1_1_OneSex_TimeInvariant_Age.Rmd",
  "1_2_OneSex_TimeVarying_Age.Rmd",
  "1_3_TwoSex_TimeInvariant_Age.Rmd",
  "1_4_TwoSex_TimeVarying_Age.Rmd",
  "2_1_OneSex_TimeInvariant_AgeStage.Rmd",
  "2_2_TwoSex_TimeVarying_AgeStage.Rmd"
)

# Function to add vignette metadata
add_vignette_metadata <- function(file_path) {
  # Read the file content
  full_path <- file.path("vignettes", file_path)
  if (!file.exists(full_path)) {
    stop("File not found: ", full_path)
  }

  content <- readLines(full_path)

  # Extract title from YAML header
  title_line <- grep("^title:", content, value = TRUE)
  if (length(title_line) == 0) {
    stop("Title not found in YAML header for file: ", file_path)
  }
  title <- gsub("^title: \"(.*?)\".*$", "\\1", title_line)

  # Create vignette metadata block
  vignette_block <- c(
    "---",
    paste0("title: \"", title, "\""),
    "output: rmarkdown::html_vignette",
    "vignette: >",
    "  %\\VignetteIndexEntry{", title, "}",
    "  %\\VignetteEngine{knitr::rmarkdown}",
    "  %\\VignetteEncoding{UTF-8}",
    "---"
  )

  # Find the end of the original YAML header
  yaml_markers <- which(content == "---")
  if (length(yaml_markers) < 2) {
    stop("YAML header not properly formatted in file: ", file_path)
  }
  yaml_end <- yaml_markers[2]

  # Replace the original YAML header with the vignette metadata
  new_content <- c(vignette_block, content[(yaml_end+1):length(content)])

  # Write back to the same location
  writeLines(new_content, full_path)

  message("Converted ", file_path, " to vignette format")
}

# Process each vignette file
for (file in vignette_files) {
  add_vignette_metadata(file)
}

# Create a functions.R file in the vignettes directory if it doesn't exist
if (!file.exists("vignettes/functions.R")) {
  # Create a minimal functions.R file with placeholder functions
  functions_content <- c(
    "# Placeholder functions for vignettes",
    "",
    "# Function to rename kin codes to readable labels",
    "rename_kin <- function(data) {",
    "  if (!'kin' %in% names(data)) {",
    "    return(data)",
    "  }",
    "  ",
    "  data$kin_label <- factor(data$kin,",
    "                          levels = c('m', 'gm', 'ggm', 'd', 'gd', 'ggd', 's', 'a', 'c', 'n'),",
    "                          labels = c('Mother', 'Grandmother', 'Great-grandmother',",
    "                                     'Daughter', 'Granddaughter', 'Great-granddaughter',",
    "                                     'Sister', 'Aunt', 'Cousin', 'Niece'))",
    "  return(data)",
    "}",
    "",
    "# Function to plot a Keyfitz diagram",
    "plot_diagram <- function(data, rounding = 2) {",
    "  # Placeholder function - would be implemented in the actual package",
    "  message('Keyfitz diagram would be plotted here')",
    "}"
  )

  writeLines(functions_content, "vignettes/functions.R")
  message("Created placeholder functions.R file in vignettes directory")
}

message("Vignette processing complete. You can now build the pkgdown site.")
