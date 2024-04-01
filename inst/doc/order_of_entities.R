## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  relationships <- list(
#    Cosponsors = list(
#      Legislators = list(id = "id", relationship = c(">0", "||")),
#      Bills = list(bill = "bill", relationship = c(">|", "||"))
#    )
#  )

## ----eval = FALSE-------------------------------------------------------------
#  relationships <- list(
#    Legislators = list(
#      Cosponsors = list(id = "id", relationship = c("||", "0<"))
#    ),
#    Cosponsors = list(
#      Bills = list(bill = "bill", relationship = c(">|", "||"))
#    )
#  )

## ----eval = FALSE-------------------------------------------------------------
#  relationships <- list(
#      Bills = list(
#      Cosponsors = list(bill = "bill", relationship = c("||", "|<"))
#    ),
#    Cosponsors = list(
#      Legislators = list(id = "id", relationship = c(">0", "||"))
#    )
#  )

## ----eval = FALSE-------------------------------------------------------------
#  
#  ## Load packages
#  library(ERDbuilder)
#  library(incidentally)
#  library(janitor)
#  library(dplyr)
#  library(tidyr)
#  library(tibble)
#  library(gt)
#  
#  # https://cran.r-project.org/web/packages/incidentally/vignettes/congress.html
#  
#  ## Download data for example
#  I <- incidence.from.congress(
#    session = 115,
#    types = c("sres"),
#    areas = c("All"),
#    format = "data",
#    narrative = TRUE)
#  
#  
#  ## Define entities. Cosponsors table required some formatting.
#  legislators_tbl <- I$legislator |> as_tibble()
#  bills_tbl <- I$bills |> as_tibble() |> clean_names()
#  cosponsors_tbl <-
#    I$matrix |>
#    as.data.frame() |>
#    rownames_to_column(var = "name") |>
#    pivot_longer(-name, names_to = "bill", values_to = "sponsored") |>
#    filter(sponsored == 1) |>
#    left_join(legislators_tbl, by = join_by(name)) |>
#    select(id, bill)
#  
#  ## Show the first five records of every entity
#  my_gt <- function(df) {
#    df |>
#      gt() |>
#      tab_style(
#        style = cell_fill(color = "darkolivegreen1"),
#        locations = cells_column_labels()
#      )
#  }
#  
#  gt_group(
#    cosponsors_tbl |> head(5) |> my_gt(),
#    legislators_tbl |> head(5) |> my_gt(),
#    bills_tbl |> head(5) |> my_gt()
#  )
#  
#  
#  ## Figure 1
#  ## Define first ERD: cosponsors linked to bills and legislators
#  relationships <- list(
#    Cosponsors = list(
#      Legislators = list(id = "id", relationship = c(">0", "||")),
#      Bills = list(bill = "bill", relationship = c(">|", "||"))
#    )
#  )
#  
#  ## Create ERD
#  erd <- create_erd(
#    list(
#      Cosponsors = cosponsors_tbl,
#      Legislators = legislators_tbl,
#      Bills = bills_tbl
#    ),
#    relationships
#  )
#  
#  ## Render ERD
#  render_erd(erd, label_distance = 0)
#  
#  ## Figure 2
#  ###   Legislators -> Cosponsors -> Bills
#  
#  relationships <- list(
#    Legislators = list(
#      Cosponsors = list(id = "id", relationship = c("||", "0<"))
#    ),
#    Cosponsors = list(
#      Bills = list(bill = "bill", relationship = c(">|", "||"))
#    )
#  )
#  
#  erd <- create_erd(
#    list(
#      Cosponsors = cosponsors_tbl,
#      Legislators = legislators_tbl,
#      Bills = bills_tbl
#    ),
#    relationships
#  )
#  
#  render_erd(erd, label_distance = 0)
#  
#  ## Figure 3
#  ### Bills -> Cosponsors -> Legislators
#  
#  relationships <- list(
#      Bills = list(
#      Cosponsors = list(bill = "bill", relationship = c("||", "|<"))
#    ),
#    Cosponsors = list(
#      Legislators = list(id = "id", relationship = c(">0", "||"))
#    )
#  )
#  
#  erd <- create_erd(
#    list(
#      Cosponsors = cosponsors_tbl,
#      Legislators = legislators_tbl,
#      Bills = bills_tbl
#    ),
#    relationships
#  )
#  
#  render_erd(erd, label_distance = 0)
#  
#  

