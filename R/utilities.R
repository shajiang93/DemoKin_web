#' Convert kin codes to readable labels
#'
#' This function converts abbreviated kin codes to human-readable labels
#'
#' @param data A data frame containing a column named "kin" with relationship codes
#'
#' @return The original data frame with an additional column "kin_label" containing relationship labels
#'
#' @examples
#' \dontrun{
#' # Convert kin codes in results
#' labeled_results <- rename_kin(results$kin_summary)
#' }
#'
#' @export
rename_kin <- function(data) {
  if (!'kin' %in% names(data)) {
    return(data)
  }
  
  data$kin_label <- factor(data$kin,
                          levels = c('m', 'gm', 'ggm', 'd', 'gd', 'ggd', 's', 'a', 'c', 'n'),
                          labels = c('Mother', 'Grandmother', 'Great-grandmother',
                                     'Daughter', 'Granddaughter', 'Great-granddaughter',
                                     'Sister', 'Aunt', 'Cousin', 'Niece'))
  return(data)
}

#' Plot a Keyfitz kinship diagram
#'
#' This function creates a network visualization of kinship relationships
#'
#' @param data A data frame containing kin counts by relationship type
#' @param rounding Number of decimal places to display in counts
#'
#' @return A diagram object (invisible)
#'
#' @examples
#' \dontrun{
#' # Create a Keyfitz diagram for a 65-year-old woman
#' kin_results$kin_summary %>%
#'   filter(age_focal == 65) %>%
#'   select(kin, count = count_living) %>%
#'   plot_diagram(rounding = 2)
#' }
#'
#' @export
plot_diagram <- function(data, rounding = 2) {
  # This is a placeholder implementation
  # In a real package, this would create an actual visualization
  
  message("This is a placeholder for the 'plot_diagram' function")
  message("It would create a Keyfitz kinship diagram with these relationships:")
  
  # Display the kin relationships and counts
  for (i in 1:nrow(data)) {
    kin_code <- data$kin[i]
    count <- round(data$count[i], rounding)
    
    kin_name <- switch(kin_code,
                       "m" = "Mother",
                       "gm" = "Grandmother",
                       "ggm" = "Great-grandmother",
                       "d" = "Daughter",
                       "gd" = "Granddaughter",
                       "ggd" = "Great-granddaughter",
                       "s" = "Sister",
                       "a" = "Aunt",
                       "c" = "Cousin",
                       "n" = "Niece",
                       kin_code)
    
    message(paste0(" - ", kin_name, ": ", count))
  }
  
  invisible(NULL)
}

#' Relationship codes used in DemoKin
#'
#' A data frame mapping relationship codes to their descriptions
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{code}{Abbreviated code used in the package}
#'   \item{relationship}{Description of the relationship}
#'   \item{caswell_code}{Corresponding code in Caswell papers}
#' }
#'
#' @examples
#' demokin_codes
"demokin_codes"

# Create the relationship codes data
demokin_codes <- data.frame(
  code = c("m", "gm", "ggm", "d", "gd", "ggd", "s", "a", "c", "n"),
  relationship = c("Mother", "Grandmother", "Great-grandmother",
                 "Daughter", "Granddaughter", "Great-granddaughter",
                 "Sister", "Aunt", "Cousin", "Niece"),
  caswell_code = c("μ", "γμ", "γγμ", "δ", "γδ", "γγδ", "σ", "α", "κ", "ν"),
  stringsAsFactors = FALSE
)
