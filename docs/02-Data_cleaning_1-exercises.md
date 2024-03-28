# Data Cleaning, Part 1 Exercises

## Part 1: Looking at documentation to load in data

Suppose that you want to load in data "students.csv" in a CSV format, and you don't know what tools to use. You decide to see whether the package "readr" can be useful to solve your problem. Where should you look?

All R packages must be stored on CRAN (Comprehensive R Archive Network), and all packages have a website that points to the reference manual (what is pulled up using the `?` command), source code, vignettes examples, and dependencies on other packages. Here is [the website](https://cran.r-project.org/web/packages/readr/) for "readr".

In the package, you find some potential functions for importing your data:

-   `read_csv("file.csv")` for comma-separated files

-   `read_tsv("file.tsv")` for tab-deliminated files

-   `read_excel("example.xlsx")` for excel files

-   `read_excel("example.xlsx", sheet = "sheet1")` for excel files with a sheet name

-   `read_delim()` for general-deliminated files, such as: `read_delim("file.csv", sep = ",")`.

After looking at the vignettes, it seems that `read_csv()` is a function to try.

Let's look at the `read_csv()` function documentation, which can be accessed via `?read_csv`.

```         
read_csv(
  file,
  col_names = TRUE,
  col_types = NULL,
  col_select = NULL,
  id = NULL,
  locale = default_locale(),
  na = c("", "NA"),
  quoted_na = TRUE,
  quote = "\"",
  comment = "",
  trim_ws = TRUE,
  skip = 0,
  n_max = Inf,
  guess_max = min(1000, n_max),
  name_repair = "unique",
  num_threads = readr_threads(),
  progress = show_progress(),
  show_col_types = should_show_types(),
  skip_empty_rows = TRUE,
  lazy = should_read_lazy()
)
```

We see that the only *required* argument is the `file` variable, which is documented to be "Either a path to a file, a connection, or literal data (either a single string or a raw vector)." All the other arguments are considered *optional*, because they have a pre-allocated value in the documentation.

Load in "students.csv" via `read_csv()` function as a dataframe variable `students` and take a look at its contents via `View()`.


```r
library(tidyverse)
```

```
## Warning: package 'tidyverse' was built under R version 4.0.3
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✔ ggplot2 3.3.2     ✔ purrr   0.3.4
## ✔ tibble  3.2.1     ✔ dplyr   1.0.2
## ✔ tidyr   1.1.2     ✔ stringr 1.4.0
## ✔ readr   1.4.0     ✔ forcats 0.5.0
```

```
## Warning: package 'purrr' was built under R version 4.0.5
```

```
## Warning: package 'stringr' was built under R version 4.0.3
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

Something looks weird here. There is only one column, and it seems that the first two entries start with "\#", and don't fit a CSV file format. These first two entries that start with "\#" likely are comments giving metadata about the file, and they should be ignore when loading in the data.

Let's try again. Take a look at the documentation for the `comment` argument and give it a character value `"#"` with this situation. Any text after the comment characters will be silently ignored.



The column names are not very consistent . Take a look at the documentation for the `col_names` argument and give it a value of [`c`](https://rdrr.io/r/base/c.html)`("student_id", "full_name", "favorite_food", "meal_plan", "age")`.



Alternatively, you could have loaded the data in without `col_names` option and modified the column names by accessing `names(students)`.

For more information on loading in data, see this chapter of [R for Data Science](https://r4ds.hadley.nz/spreadsheets).

## Part 2: Recoding data: warm-up

Consider this vector:


```r
scores = c(23, 46, -3, 5, -1)
```

Recode `scores` so that all the negative values are 0.



Let's look at the values of `students` dataframe more carefully. We will do some recoding on this small dataframe. It may feel trivial because you could do this by hand in Excel, but this is a practice on how we can scale this up with larger datasets!

Notice that some of the elements of this dataframe has proper `NA` values and also a character "N/A". We want "N/A" to be a proper `NA` value.

Recode "N/A" to `NA` in the `favorite_food` column:



Recode "five" to 5 in the `age` column:



Create a new column `age_category` so that it has value "toddler" if `age` is \< 6, and "child" if `age` is \>= 6.

(Hint: You can create a new column via `mutate`, or you can directly refer to the new column via ``` student$``age_category ```.)



Create a new column `favorite_food_numeric` so that it has value 1 if `favorite_food` is "Breakfast and lunch", 2 if "Lunch only", and 3 if "Dinner only".



## Part 3: Recoding data in State Cancer Profiles

Starting from this exercise, we will start building out an end-to-end analysis using [data from the National Cancer Institute's State Cancer Profile](https://statecancerprofiles.cancer.gov/index.html):

> [State Cancer Profile data] was developed with the idea to provide a geographic profile of cancer burden in the United States and reveal geographic disparities in cancer incidence, mortality, risk factors for cancer, and cancer screening, across different population subgroups.

In this analysis, we want to examine cancer incidence rates in state of Washington and make some comparisons between groups. The cancer incidence rate can be accessed at this [website](https://statecancerprofiles.cancer.gov/incidencerates/index.php), once you give input of what kind of incidence data you want to access. If you want to analyze this data in R, it takes a bit of work of exporting the data and loading it into R.

To access this data easier in R, DaSL staff built a R package `cancerprof` to easily load in the data. Let's look at the package's documentation to see how to get access to cancer incidence data.



Towards the bottom of the documentation are some useful examples to consider as starting point.

Load in data about the following population: **melanoma incidence in WA at the county level for males of all ages, all cancer stages, averaged in the past 5 years.** Store it as a dataframe variable named `melanoma_incidence`

(If you are stuck, you can use the first example in the documentation.)



Take a look at the data yourself and explore it.



Let's select a few columns of interest and give them column names that doesn't contain spaces. We can access column names with spaces via the backtick \` symbol.


```r
#uncomment to run!

#melanoma_incidence = select(melanoma_incidence, County, `Age Adjusted Incidence Rate`, `Recent Trend`)

#names(melanoma_incidence) = c("County", "Age_adjusted_incidence_rate", "Recent_trend")
```

Take a look at the column `Age_adjusted_incidence_rate`. It has missing data coded as "\*" (notice the space after \*). Recode "\*" as `NA`.



Finally, notice that the data type for `Age_adjusted_incidence_rate` is character, if you run the function `is.character()` or `class()` on it. Convert it to a numeric data type.


