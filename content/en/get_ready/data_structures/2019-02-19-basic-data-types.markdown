---
title: Basic Data Types
author: Damien Jourdain
date: '2019-02-19'
slug: basic-data-types
categories:
  - data structure
tags: []
type: book
weight: 10
---

## Learning objectives

We have seen that we can store objects in the R workspace. In our earlier example, we created variables that would store one piece of information, i.e. a number.  

As you would expect, R can store many different types of data. We call them R basic *data types*. We call them "basic" because they can be assembled into more complex data structures (vectors, arrays, dataframes, etc.) that we will study later.

In this section you will learn about the basic data types you will be using for our analyses.  

+ [Numerics (real numbers) ](#numeric)
+ [Integers ](#integers)
+ [Logicals](#logicals)
+ [Characters](#characters)
+ [Factors](#factors)

## Numeric  (*real numbers*)
Real numbers are stored as *numerics* in R. It is the default computational data type. 

If we assign a decimal value to a variable $ x $ as follows, $ x $ will be of numeric type. Note that, even if we assign an integer to a variable $ y $, it is still being saved as a numeric value.


```r
(x <-  10.5)   # assign a decimal value 
```

```
## [1] 10.5
```

```r
class(x)       # print the class name of x 
```

```
## [1] "numeric"
```

```r
y <- 1 
class(y)
```

```
## [1] "numeric"
```

The fact that $ y $ is not an integer can be confirmed with the `is.integer` function


```r
is.integer(y)  # is k an integer? 
```

```
## [1] FALSE
```

Note two specific objects belong to the class numeric

+ `Inf` represents an infinite value
+ `NaN` despite its meaning "Not a Numeric" belongs also the class numeric


```r
class(Inf)
```

```
## [1] "numeric"
```

```r
class(NaN)
```

```
## [1] "numeric"
```


## Integers

There are several ways to create an integer variable in R

```r
(z <- 3L)  # declare an integer by appending an L suffix
```

```
## [1] 3
```

```r
is.integer(z)
```

```
## [1] TRUE
```

```r
(z <- as.integer(3))  # use the as.integer( ) function
```

```
## [1] 3
```

```r
is.integer(z)
```

```
## [1] TRUE
```

Note that the function `as.integer` can coerce a numeric value (or even some character variable) into an integer value.

```r
(z <- as.integer(3.14))
```

```
## [1] 3
```

```r
is.integer(z)
```

```
## [1] TRUE
```

```r
(z <- as.integer("5.27"))  # coerce a decimal string 
```

```
## [1] 5
```

```r
is.integer(z)
```

```
## [1] TRUE
```


## Logicals

A logical value is either `TRUE` or `FALSE`

A logical is often created via comparison between variables.


```r
x <- 1; y <- 2   # sample values 
(z <-  x > y)      # is x larger than y? 
```

```
## [1] FALSE
```

```r
class(z)
```

```
## [1] "logical"
```

Standard logical operations are "&" (and), "|" (or), and "!" (negation).


```r
u <- TRUE; v <- FALSE 
u & v          # u AND v 
```

```
## [1] FALSE
```

```r
u | v          # u OR v 
```

```
## [1] TRUE
```

```r
!u             # negation of u 
```

```
## [1] FALSE
```

Further details and related logical operations can be found when typing `help("&")` 

Finally, it is often useful to perform arithmetic on logical values. You just have to remember that the `TRUE` has the value 1, while `FALSE` has value 0.

```r
(as.integer(TRUE))  # is k an integer? 
```

```
## [1] 1
```

```r
TRUE + TRUE
```

```
## [1] 2
```

{{% callout note %}}
A logical variable can take the values "TRUE" et "FALSE". You will sometimes find them in their abbreviated form as  "T" and "F". However, you need to know that  "T" and "F" are  variables pre-defined as TRUE and FALSE, but are not reserved names and therefore are not protected; as a result you can change their values and this may lead to confusions. . **Therefore, it will always be preferable to use  TRUE and FALSE.**
{{% /callout %}}


## Characters

In R, strings are stored as a `character` object. Strings are surrounded by two `"`.   

```r
(x <- "This is a string") 
```

```
## [1] "This is a string"
```

```r
class(x)
```

```
## [1] "character"
```

If you do not use the `"`, R will look for a variable instead of a string of characters, and will most likely throw an error message.  


```r
(x <- This is a string) 
class(x)
```

```
## Error: <text>:1:12: unexpected symbol
## 1: (x <- This is
##                ^
```


We can convert objects into character values with the `as.character()` function:

```r
(x = as.character(3.14)) 
```

```
## [1] "3.14"
```

Two character values can be concatenated with the `paste()` function.

```r
fname = "Joe"; lname ="Smith" 
paste(fname, lname) 
```

```
## [1] "Joe Smith"
```

To extract a substring, we apply the `substr()` function. Here is an example showing how to extract the substring between the third and fourteenth positions in a string.

```r
substr("Mary has a little lamb.", start=3, stop=14) 
```

```
## [1] "ry has a lit"
```

And to replace the first occurrence of the word "little" by another word "big" in the string, we apply the `sub()` function.

```r
sub("little", "big", "Mary has a little lamb.") 
```

```
## [1] "Mary has a big lamb."
```

## Other Objects

R also provides special objects that are useful for missing data, or for specific number like Infinity. 

NA is in fact a logical constant of length 1 which contains a missing value indicator. It will appear in your datasets and answers, when a value is missing

```r
class(NA)
```

```
## [1] "logical"
```

NULL represents the null object in R. NULL is returned by expressions and functions whose value is undefined.
Contrary to NA, it is not a logical variable.


```r
class(NULL)
```

```
## [1] "NULL"
```

`Inf` and `-Inf` are positive and negative infinity. Their class is numeric

```r
1+ Inf 
```

```
## [1] Inf
```

```r
class(Inf)
```

```
## [1] "numeric"
```

NaN is a reserved word in R and means ‘Not a Number’.


```r
class(NaN)
```

```
## [1] "numeric"
```

```r
# See the difference between the two expressions
3 / 0 ## = Inf a non-zero number divided by zero creates infinity
```

```
## [1] Inf
```

```r
0 / 0  ## =  NaN
```

```
## [1] NaN
```



