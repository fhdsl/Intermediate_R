# Repetition

Suppose that you want to repeat a chunk of code many times, but changing one variable's value each time you do it. This could be modifying each element of a vector with the same operation, or analyzing a dataframe with different parameters.

There are three common strategies to go about this:

1.  Copy and paste the code chunk, and change that variable's value. Repeat. *This can be a starting point in your analysis, but will lead to errors easily.*
2.  Use a `for` loop to repeat the chunk of code, and let it loop over the changing variable's value. *This is popular for many programming languages, but the R programming culture encourages a functional way instead*.
3.  **Functionals** allow you to take a function that solves the problem for a single input and generalize it to handle any number of inputs. *This is very popular in R programming culture.*
