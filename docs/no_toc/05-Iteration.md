# Iteration

Suppose that you want to repeat a chunk of code many times, but changing one variable's value each time you do it. This could be modifying each element of a vector with the same operation, or analyzing a dataframe with different parameters.

There are three common strategies to go about this:

1.  Copy and paste the code chunk, and change that variable's value. Repeat. *This can be a starting point in your analysis, but will lead to errors easily.*
2.  Use a `for` loop to repeat the chunk of code, and let it loop over the changing variable's value. *This is popular for many programming languages, but the R programming culture encourages a functional way instead*.
3.  **Functionals** allow you to take a function that solves the problem for a single input and generalize it to handle any number of inputs. *This is very popular in R programming culture.*

## For loops

A `for` loop repeats a chunk of code many times, once for each element of an input vector.

```         
for (my_element in my_vector) {
  chunk of code
}
```

Most often, the "chunk of code" will make use of `my_element`.

#### We can loop through the indicies of a vector

The function `seq_along()` creates the indicies of a vector. It has almost the same properties as `1:length(my_vector)`, but avoids issues when the vector length is 0.


``` r
my_vector = c(1, 3, 5, 7)

for(i in seq_along(my_vector)) {
  print(my_vector[i])
}
```

```
## [1] 1
## [1] 3
## [1] 5
## [1] 7
```

#### Alternatively, we can loop through the elements of a vector


``` r
for(vec_i in my_vector) {
  print(vec_i)
}
```

```
## [1] 1
## [1] 3
## [1] 5
## [1] 7
```

#### Another example via indicies


``` r
result = rep(NA, length(my_vector))
for(i in seq_along(my_vector)) {
  result[i] = log(my_vector[i])
}
```

## Functionals

A **functional** is a function that takes in a data structure and function as inputs and applies the function on the data structure, element by element. It *maps* your input data structure to an output data structure based on the function. It encourages the usage of modular functions in your code.

![](https://upload.wikimedia.org/wikipedia/commons/0/06/Mapping-steps-loillibe-new.gif)

Or,

![](https://d33wubrfki0l68.cloudfront.net/f0494d020aa517ae7b1011cea4c4a9f21702df8b/2577b/diagrams/functionals/map.png){width="250"}

We will use the `purrr` package in `tidyverse` to use functionals. There is another set of functionals in Base-R called the `apply` family of functions that work very similarly. You can see the comparision of both tools [here](https://purrr.tidyverse.org/articles/base.html) and [here](https://jtr13.github.io/spring19/ss5593&fq2150.html).

`map()` takes in a vector or a list, and then applies the function on each element of it. The output is *always* a list.




``` r
my_vector = c(1, 3, 5, 7)
map(my_vector, log)
```

```
## [[1]]
## [1] 0
## 
## [[2]]
## [1] 1.098612
## 
## [[3]]
## [1] 1.609438
## 
## [[4]]
## [1] 1.94591
```

Lists are useful if what you are using it on requires a flexible data structure.

To be more specific about the output type, you can do this via the `map_*` function, where `*` specifies the output type: `map_lgl()`, `map_chr()`, and `map_dbl()` functions return vectors of logical values, strings, or numbers respectively.

For example, to make sure your output is a double (numeric):


``` r
map_dbl(my_vector, log)
```

```
## [1] 0.000000 1.098612 1.609438 1.945910
```

All of these are toy examples that gets us familiar with the syntax, but we already have built-in functions to solve these problems, such as `log(my_vector)`. Let's see some real-life case studies.

## Case studies

### 1. Loading in multiple files.

Suppose that we want to load in a few dataframes, and store them in a list of dataframes for analysis downstream.

We start with the filepaths we want to load in as dataframes.


``` r
paths = c("classroom_data/students.csv", "classroom_data/CCLE_metadata.csv")
```

The function we want to use to load the data in will be `read_csv()`.

Let's practice writing out one iteration:


``` r
result = read_csv(paths[1])
```

#### To do this functionally, we think about:

-   What variable we need to loop through: `paths`

-   The repeated task as a function: `read_csv()`

-   The looping mechanism, and its output: `map()` outputs lists.


``` r
loaded_dfs = map(paths, read_csv)
```

#### To do this with a for loop, we think about:

-   What variable we need to loop through: `paths`.

-   Do we need to store the outcome of this loop in a data structure? Yes, a list.

-   At each iteration, what are we doing? Use `read_csv()` on the current element, and store it in the output list.


``` r
paths = c("classroom_data/students.csv", "classroom_data/CCLE_metadata.csv")
loaded_dfs = vector(mode = "list", length = length(paths))
for(i in seq_along(paths)) {
  df = read_csv(paths[i])
  loaded_dfs[[i]] = df
}
```

### 2. Analyze a dataframe with different parameters.

Suppose you are working with the `penguins` dataframe:


``` r
library(palmerpenguins)
head(penguins)
```

```
## # A tibble: 6 × 8
##   species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
##   <fct>   <fct>              <dbl>         <dbl>             <int>       <int>
## 1 Adelie  Torgersen           39.1          18.7               181        3750
## 2 Adelie  Torgersen           39.5          17.4               186        3800
## 3 Adelie  Torgersen           40.3          18                 195        3250
## 4 Adelie  Torgersen           NA            NA                  NA          NA
## 5 Adelie  Torgersen           36.7          19.3               193        3450
## 6 Adelie  Torgersen           39.3          20.6               190        3650
## # ℹ 2 more variables: sex <fct>, year <int>
```

and you want to look at the mean `bill_length_mm` for each of the three species (Adelie, Chinstrap, Gentoo).

Let's practice writing out one iteration:


``` r
species_to_analyze = c("Adelie", "Chinstrap", "Gentoo")
penguins_subset = filter(penguins, species == species_to_analyze[1])
mean(penguins_subset$bill_length_mm, na.rm = TRUE)
```

```
## [1] 38.79139
```

#### To do this functionally, we think about:

-   What variable we need to loop through: `c("Adelie", "Chinstrap", "Gentoo")`

-   The repeated task as a function: a custom function that takes in a specie of interest. The function filters the rows of `penguins` to the species of interest, and compute the mean of `bill_length_mm`.

-   The looping mechanism, and its output: `map_dbl()` outputs (double) numeric vectors.


``` r
analysis = function(current_species) {
  penguins_subset = dplyr::filter(penguins, species == current_species)
  return(mean(penguins_subset$bill_length_mm, na.rm=TRUE))
}

map_dbl(c("Adelie", "Chinstrap", "Gentoo"), analysis)
```

```
## [1] 38.79139 48.83382 47.50488
```

#### To do this with a for loop, we think about:

-   What variable we need to loop through: `c("Adelie", "Chinstrap", "Gentoo")`.

-   Do we need to store the outcome of this loop in a data structure? Yes, a numeric vector.

-   At each iteration, what are we doing? Filter the rows of `penguins` to the species of interest, and compute the mean of `bill_length_mm`.


``` r
outcome = rep(NA, length(species_to_analyze))
for(i in seq_along(species_to_analyze)) {
  penguins_subset = filter(penguins, species == species_to_analyze[i])
  outcome[i] = mean(penguins_subset$bill_length_mm, na.rm=TRUE)
}
outcome
```

```
## [1] 38.79139 48.83382 47.50488
```

### 3. Calculate summary statistics on columns of a dataframe.

Suppose that you are interested in the numeric columns of the `penguins` dataframe.


``` r
penguins_numeric = penguins %>% select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g)
```

and you are interested to look at the mean of each column. It is very helpful to interpret the dataframe `penguins_numeric` as a *list*, iterating through each column as an element of a list.

Let's practice writing out one iteration:


``` r
mean(penguins_numeric[[1]], na.rm = TRUE)
```

```
## [1] 43.92193
```

#### To do this functionally, we think about:

-   What variable we need to loop through: the list `penguins_numeric`

-   The repeated task as a function: `mean()` with the argument `na.rm = TRUE`.

-   The looping mechanism, and its output: `map_dbl()` outputs (double) numeric vectors.


``` r
map_dbl(penguins_numeric, mean, na.rm = TRUE)
```

```
##    bill_length_mm     bill_depth_mm flipper_length_mm       body_mass_g 
##          43.92193          17.15117         200.91520        4201.75439
```

Here, R is interpreting the dataframe `penguins_numeric` as a *list*, iterating through each column as an element of a list:

![](https://d33wubrfki0l68.cloudfront.net/12f6af8404d9723dff9cc665028a35f07759299d/d0d9a/diagrams/functionals/map-list.png){width="300"}

#### To do this with a for loop, we think about:

-   What variable we need to loop through: the elements of `penguins_numeric` as a list.

-   Do we need to store the outcome of this loop in a data structure? Yes, a numeric vector.

-   At each iteration, what are we doing? Compute the mean of an element of `penguins_numeric`.


``` r
result = rep(NA, ncol(penguins_numeric))
for(i in seq_along(penguins_numeric)) {
  result[i] = mean(penguins_numeric[[i]], na.rm = TRUE)
}
result
```

```
## [1]   43.92193   17.15117  200.91520 4201.75439
```

## Exercises

You can find [exercises and solutions on Posit Cloud](https://posit.cloud/content/8236252), or on [GitHub](https://github.com/fhdsl/Intermediate_R_Exercises).
