# Data Cleaning, Part 1 Exercises



Suppose that you want to load in some data, and you don't know what tools to use. You decide to see whether the package "readr" can be useful to solve your problem. Where should you look? All R packages must be stored on CRAN (Comprehensive R Archive Network), and all packages have a website that points to the reference manual (what is pulled up using the `?` command), source code, vignettes examples, and dependencies on other packages. Here is [the website](https://cran.r-project.org/web/packages/readr/) for "readr".

In the package, you find some potential functions for importing your data:

-   `read_csv("file.csv")` for comma-separated files

-   `read_tsv("file.tsv")` for tab-deliminated files

-   `read_excel("example.xlsx")` for excel files

-   `read_excel("example.xlsx", sheet = "sheet1")` for excel files with a sheet name

-   `read_delim()` for general-deliminated files, such as: `read_delim("file.csv", sep = ",")`.

After looking at the vignettes, it seems that `read_delim()` is a function to try.

Let's look at the `read_delim()` function documentation.

```         
Usage:

     read_delim(
       file,
       delim = NULL,
       quote = "\"",
       escape_backslash = FALSE,
       escape_double = TRUE,
       col_names = TRUE,
       col_types = NULL,
       col_select = NULL,
       id = NULL,
       locale = default_locale(),
       na = c("", "NA"),
       quoted_na = TRUE,
       comment = "",
       trim_ws = FALSE,
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

https://r4ds.hadley.nz/spreadsheets
