## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = TRUE, message=FALSE----------------------------------------
# Load Packages -----------------------------------------------------------

library(ERDbuilder)
library(gt)
library(dplyr)

# Define entities ---------------------------------------------------------

students_tbl <- data.frame(
  st_id = c("hu1", "de2", "lo3"),
  dep_id = c("water", "evil", "values"),
  student = c("Huey", "Dewey", "Louie"),
  email = c("hubert.duck", "dewfort.duck", "llewellyn.duck"),
  dob = c("04-15", "04-15", "04-15")
)

courses_tbl <- data.frame(
  crs_id = c("water101", "evil205", "water202"),
  fac_id = c("02do", "03pe", "04mi"),
  dep_id = c("water", "evil", "water"),
  course = c("Swimming", "Human-chasing", "Dives")
)

enrollment_tbl <- data.frame(
  crs_id = c("water101", "evil205", "evil205", "water202"),
  st_id = c("hu1", "hu1", "de2", "de2"),
  final_grade = c("B", "A", "A", "F")
)

department_tbl <- data.frame(
  dep_id = c("water", "evil", "values"),
  department = c("Water activities", "Evil procurement", "Good values")
)

faculty_tbl <- data.frame(
  faculty_name = c("Scrooge McDuck", "Donald", "Pete", "Mickey"),
  title = c("Emeritus", "Full", "Assistant", "Full"),
  fac_id = c("01sc", "02do", "03pe", "04mi"),
  dep_id = c("water", "water", "evil", "values")
)


my_gt <- function(df) {
  df |> 
    gt() |>
    tab_style(
      style = cell_fill(color = "darkolivegreen1"),
      locations = cells_column_labels()
    )
}

gt_group(
  my_gt(students_tbl),
  my_gt(courses_tbl),
  my_gt(enrollment_tbl),
  my_gt(department_tbl),
  my_gt(faculty_tbl)
)


## ----eval = TRUE--------------------------------------------------------------
## Define relationships
relationships <- list(
  courses = list(
    enrollment = list(crs_id = "crs_id", relationship = c("||", "|<")),
    department = list(dep_id = "dep_id", relationship = c(">|", "||")),
    faculty = list(fac_id = "fac_id", relationship = c(">0", "||"))
  ),
  enrollment = list(
    students = list(st_id = "st_id", relationship = c(">0", "||")
    )
  ),
  students = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  ),
  faculty = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  )
)

## Create ERD object
erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

## Render ERD
render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)

## ----eval = TRUE--------------------------------------------------------------
## Define relationships
relationships <- list()

## Create ERD object
erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

## Render ERD
render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)


## ----eval = TRUE--------------------------------------------------------------
## Define relationships: ugly attempt
relationships <- list(
  courses = list(
    enrollment = list(),
    department = list(),
    faculty = list()
  ),
  enrollment = list(
    students = list()
  ),
  students = list(
    department = list()
  ),
  department = list(
    faculty = list()
  )
)

erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)


# 2. Define Relationships: improved example

## Define relationships
relationships <- list(
  courses = list(
    enrollment = list(),
    department = list(),
    faculty = list()
  ),
  enrollment = list(
    students = list()
  ),
  students = list(
    department = list()
  ),
  faculty = list(
    department = list()
  )
)

erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)


## ----eval = TRUE--------------------------------------------------------------

## Define relationships
relationships <- list(
  courses = list(
    enrollment = list(crs_id = "crs_id", relationship = c("", "")),
    department = list(dep_id = "dep_id", relationship = c("", "")),
    faculty = list(fac_id = "fac_id", relationship = c("", ""))
  ),
  enrollment = list(
    students = list(st_id = "st_id", relationship = c("", "")
    )
  ),
  students = list(
    department = list(dep_id = "dep_id", relationship = c("", ""))
  ),
  faculty = list(
    department = list(dep_id = "dep_id", relationship = c("", ""))
  )
)

## Create ERD object
erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

## Render ERD
render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)


## ----eval = TRUE--------------------------------------------------------------
## Define relationships
relationships <- list(
  courses = list(
    enrollment = list(crs_id = "crs_id", relationship = c("||", "|<")),
    department = list(dep_id = "dep_id", relationship = c(">|", "||")),
    faculty = list(fac_id = "fac_id", relationship = c(">0", "||"))
  ),
  enrollment = list(
    students = list(st_id = "st_id", relationship = c(">0", "||")
    )
  ),
  students = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  ),
  faculty = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  )
)

## Create ERD object
erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

## Render ERD
render_erd(erd_object, label_distance = 0, label_angle = 15, n = 20)


## ----eval = TRUE--------------------------------------------------------------
## Define relationships
relationships <- list(
  courses = list(
    enrollment = list(crs_id = "crs_id", relationship = c("||", "|<")),
    department = list(dep_id = "dep_id", relationship = c(">|", "||")),
    faculty = list(fac_id = "fac_id", relationship = c(">0", "||"))
  ),
  enrollment = list(
    students = list(st_id = "st_id", relationship = c(">0", "||")
    )
  ),
  students = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  ),
  faculty = list(
    department = list(dep_id = "dep_id", relationship = c(">|", "||"))
  )
)

## Create ERD object
erd_object <-
  create_erd(
    list(
      students = students_tbl,
      courses = courses_tbl,
      enrollment = enrollment_tbl,
      department = department_tbl,
      faculty = faculty_tbl
    ),
    relationships)

## Render ERD
render_erd(erd_object, label_distance = 2, label_angle = 50, n = 2)

