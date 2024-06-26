# Data Cleaning, Part 1



It is often said that 80% of data analysis is spent on the cleaning and preparing data *for* the analysis. Today we will start looking at common data cleaning tasks, in particular data recoding.

In the process, we will be learning a handful of new functions. You already use functions on a regular basis, but for this course, you will be learning how to use other people's custom functions more independently. Therefore, we start with a review and deeper dive on how to use other people's custom functions, then we will look at new functions for recoding.

## Interpreting functions, carefully

As you become more independent R programmers, you will spend time learning about new functions on your own. We have gone over the basic anatomy of a function call back in Intro to R, but now let's go a bit deeper to understand how a function is built and how to call them.

Recall that a function has a **function name**, **input arguments**, and a **return value**.

*Function definition consists of assigning a **function name** with a "function" statement that has a comma-separated list of named **function arguments**, and a **return expression**. The function name is stored as a variable in the global environment.*

In order to use the function, one defines or import it, then one calls it.

Example:

```         
addFunction = function(num1, num2) {
  result = num1 + num2 
  return(result)
}
result = addFunction(3, 4)
```

When the function is called in line 5, the variables for the arguments are reassigned to function arguments to be used within the function and helps with the modular form.

*What do you think are some valid inputs for this function?*

To see why we need the variables of the arguments to be reassigned, consider the following function that is *not* modular:

```         
x = 3
y = 4
addFunction = function(num1, num2) {
  result = x + y 
  return(result)
}
result = addFunction(10, -10)
```

Some syntax equivalents on calling the function:

```         
addFunction(3, 4)
addFunction(num1 = 3, num2 = 4)
addFunction(num2 = 4, num1 = 3)
```

but this *could* be different:

```         
addFunction(4, 3)
```

With a deeper knowledge of how functions are built, when you encounter a foreign function, you can look up its help page to understand how to use it. For example, let's look at `mean()`:

```         
?mean

Arithmetic Mean

Description:

     Generic function for the (trimmed) arithmetic mean.

Usage:

     mean(x, ...)
     
     ## Default S3 method:
     mean(x, trim = 0, na.rm = FALSE, ...)
     
Arguments:

       x: An R object.  Currently there are methods for numeric/logical
          vectors and date, date-time and time interval objects.
          Complex vectors are allowed for ‘trim = 0’, only.

    trim: the fraction (0 to 0.5) of observations to be trimmed from
          each end of ‘x’ before the mean is computed.  Values of trim
          outside that range are taken as the nearest endpoint.

   na.rm: a logical evaluating to ‘TRUE’ or ‘FALSE’ indicating whether
          ‘NA’ values should be stripped before the computation
          proceeds.

     ...: further arguments passed to or from other methods.
```

Notice that the arguments `trim = 0`, `na.rm = FALSE` have default values. This means that these arguments are *optional* - you should provide it only if you want to. With this understanding, you can use `mean()` in a new way:


``` r
numbers = c(1, 2, NA, 4)
mean(x = numbers, na.rm = TRUE)
```

```
## [1] 2.333333
```

The use of `. . .` (dot-dot-dot): This is a special argument that allows a function to *take any number of arguments*. This isn't very useful for the `mean()` function, but it makes sense for function such as `select()` and `filter()`, and `mutate()`. For instance, in `select()`, once you provide your dataframe for the argument `.data`, you can pile on as many columns to select in the rest of the argument.

```         
Usage:

     select(.data, ...)
     
Arguments:

   .data: A data frame, data frame extension (e.g. a tibble), or a lazy
          data frame (e.g. from dbplyr or dtplyr). See _Methods_,
          below, for more details.

     ...: <‘tidy-select’> One or more unquoted expressions separated by
          commas. Variable names can be used as if they were positions
          in the data frame, so expressions like ‘x:y’ can be used to
          select a range of variables.
```

You will look at the function documentation on your own to see how to deal with more complex cases.

## Recoding Data / Conditionals

Suppose that you have a column in your data that needs to be recoded. Since a dataframe's column, when selected via `$`, is a vector, let's start talking about recoding vectors. If we have a numeric vector, then maybe you want to have certain values to be out of bounds, or assign a range of values to a character category. If we have a character vector, then maybe you want to reassign it to a different value.

Here are popular recoding logical scenarios:

1.  If: "If elements of the vector meets *condition*, then they are assigned *value*."

2.  If-else: "If elements of the vector meets *condition*, then they are assigned *value X*. Otherwise, they are assigned *value Y*."

3.  If-else_if-else: "If elements of the vector meets *condition A*, then they are assigned *value X*. Else, if the elements of the vector meets *condition B*, they are assigned *value Y*. Otherwise, they are assigned *value Z*."

Let's look at a vector of grade values, as an example:


``` r
grade = c(90, 78, 95, 74, 56, 81, 102)
```

1.  If

Instead of having the bracket `[ ]` notation on the right hand side of the equation, if it is on the left hand side of the equation, then we can modify a subset of the vector.


``` r
grade1 = grade
grade1[grade1 > 100] = 100
```

2.  If-else


``` r
grade2 = if_else(grade > 60, TRUE, FALSE)
```

3.  If-else_if-else

```         
grade3 = case_when(grade >= 90 ~ "A",
                   grade >= 80 ~ "B",
                   grade >= 70 ~ "C", 
                   grade >= 60 ~ "D",
                   .default = "F")
```

Let's do it for dataframes now.


``` r
simple_df = data.frame(grade = c(90, 78, 95, 74, 56, 81, 102),
                       status = c("case", " ", "Control", "control", "Control", "Case", "case"))
```

1.  If


``` r
simple_df1 = simple_df
simple_df1$grade[simple_df1$grade > 100] = 100
```

2.  If-else


``` r
simple_df2 = simple_df
simple_df2$grade = ifelse(simple_df2$grade > 60, TRUE, FALSE)
```

or


``` r
simple_df2 = mutate(simple_df, grade = ifelse(grade > 60, TRUE, FALSE))
```

3.  If-else_if-else

```         
simple_df3 = simple_df

simple_df3$grade = case_when(simple_df3$grade >= 90 ~ "A",
                             simple_df3$grade >= 80 ~ "B",
                             simple_df3$grade >= 70 ~ "C", 
                             simple_df3$grade >= 60 ~ "D",
                             .default = "F")
```

or

```         
simple_df3 = simple_df

simple_df3 = mutate(simple_df3, grade = case_when(grade >= 90 ~ "A",
                                                 grade >= 80 ~ "B",
                                                 grade >= 70 ~ "C", 
                                                 grade >= 60 ~ "D",
                                                 .default = "F"))
```

## Conditionals

The 3 common scenarios we looked at for recoding data is closely tied to the concept of **conditionals** in programming: *given certain conditions, you run a specific code chunk.* Given a vector's value, assign it a different value. Or, given a value, run the following hundred lines of code. Here is what it looks like:

1.  If:

```         
if(expression_is_TRUE) {
  #code goes here
}
```

2.  If-else:

```         
if(expression_is_TRUE) {
  #code goes here
}else {
  #other code goes here
}
```

3.  If-else_if-else:

```         
if(expression_A_is_TRUE) {
  #code goes here
}else if(expression_B_is_TRUE) {
  #other code goes here
}else {
  #some other code goes here
}
```

The expression that is being tested whether it is `TRUE` **must be a singular logical value**, and not a logical vector. If the latter, see the recoding section for now.

Example:


``` r
nuc = "A"

if(nuc == "A") {
  nuc = "T"
}else if(nuc == "T") {
  nuc = "A"
}else if(nuc == "C") {
  nuc = "C"
}else if(nuc == "G") {
  nuc = "C"
}else {
  nuc = NA
}

nuc
```

```
## [1] "T"
```

Example:


``` r
my_input = c(1, 3, 5, 7, 9)
#my_input = c("e", "e", "a", "i", "o")

if(is.numeric(my_input)) {
  result = mean(my_input)
}else if(is.character(my_input)) {
  result = table(my_input)
}

result
```

```
## [1] 5
```

This introduction to conditionals will be more useful when we start writing our functions.

## Exercises

You can find [exercises and solutions on Posit Cloud](https://posit.cloud/content/8236252), or on [GitHub](https://github.com/fhdsl/Intermediate_R_Exercises).
