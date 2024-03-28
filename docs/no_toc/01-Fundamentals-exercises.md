# Fundamentals Exercises

## Part 1: Vectors

How do you subset the following vector to the first three elements?


```r
measurements = c(2, 4, -1, -3, 2, -1, 10)
```



How do you subset the original vector so that it only has negative values?



How do you subset the following vector so that it has no NA values?


```r
vec_with_NA = c(2, 4, NA, NA, 3, NA)
```



Consider the following logical vector `some_logicals`. Convert Logical vector -\> Numeric vector -\> Character vector in two steps. Check that you are doing this correctly along the way by using the `class()` function, or `is.numeric()` and `is.character()`, on the converted data.


```r
some_logicals = c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)
```



## Part 2: Lists

Consider the following lists with names.


```r
patient = list(
  name = " ", 
  age =  34, 
  pronouns = c("he", "him", "/", "they", "them"),
  vaccines = c("hep-B", "chickenpox", "HPV"),
  visits = NA
)

visit1 = list(
  symptoms = c("runny nose", "sore throat", "frustration"),
  prescription = "recommended time off from work, rest.",
  date = "1/1/2000"
)

visit2 = list(
  symptoms = c("fainted", "pale complexion"),
  prescription = "drink water and take time off work.",
  date = "1/1/2001"
)
```

Access the first element of `patient` via double brackets [[ ]] and modify it to a value of your choice.



Access the named element "pronouns" of `patient` via double bracket [[ ]] or \$ and modify its value so that it doesn't contain the "/" element. (Use your vector subsetting skills here after you access the appropriate element from the list.)



Create a new list `all_visits` with elements `visit1` and `visit2`. Yes, we're making lists within lists!



Suppose you want to use `all_visits` to access visit 1's symptoms. You would continue the double brackets [[ ]] or \$ notation: `all_visits[[1]]` returns a list, so we access the first element of *that* list via `all_visits[[1]][[1]]`.


```r
#all_visits[[1]][[1]]

#or

#ll_visits[[1]][["symptoms"]]

#or

#ll_visits[[1]]$symptoms
```

How would you use `all_visits` to access visit 2's prescription?



How would you use `all_visits` to access visit 2's symptom element "pale complexion"? Remember, once you access a vector, you would go back to the single bracket [ ] to access its elements.



Finally, assign `all_visits` to `patient`'s visits.



### Part 3: Dataframes (Lists)

A dataframe is just a named list of vectors of same length with **attributes** of (column) `names` and `row.names`.


```r
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

Access the `body_mass_g` column vector of `penguins` via the double bracket [[ ]], treating `penguins` like a list, and compute the mean. Remember to use na.rm = TRUE to remove any `NA` values: `mean(x, na.rm = TRUE)`



Create a new dataframe `penguins_clean`, which has no `NA` values in the `body_mass_g` column. You need to filter out rows that have `NA`s in the column `bill_length_mm`:



Now, subset `penguins_clean` to each of the three species and compute their respective mean value of `body_mass_g`. Because you already got rid of `NA`s in `body_mass_g`, you can just use `mean(x)` without the extra option. How do they compare?



Finally, make a box plot of `species` (x-axis) vs. `body_mass_g` (y-axis) via `penguins_clean` dataframe. I'll get you started...


```r
#ggplot(penguins_clean) + aes(x = , y = ) + geom_boxplot()
```
