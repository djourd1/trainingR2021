---
title: Basic Data Types
author: Damien Jourdain
date: '2019-02-19'
slug: basic-data-types
categories:
  - data structure
tags: []
type: book
weight: 1
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

## Factors

With R, factors store categorical variables, i.e. variables that take on a limited number of different values. Categorical variables enter into statistical models differently than continuous variables, so R developers have created a specific data type to insure that the modeling functions will treat such data correctly. 

Practically, factors are stored as a vector of integer values with a corresponding set of character values to use when the factor is displayed. 

Use the function `factor()` to create a factor. The only required argument to factor is a vector of values which will be returned as a vector of factor values. Both numeric and character variables can be made into factors, but a factor's levels will always be character values. You can see the possible levels for a factor through the `levels()` command.


```r
# Transform character vector into a factor
data = c("a","c","b","a","a","b")
fdata = factor(data)
fdata
```

```
## [1] a c b a a b
## Levels: a b c
```

```r
# Transform numeric vector into a factor
data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata = factor(data)
fdata
```

```
##  [1] 1 2 2 3 1 2 3 3 1 2 3 3 1
## Levels: 1 2 3
```
The levels of a factor are used when displaying the factor's values. You can change these levels at the time you create a factor by passing a vector with the new values through the `labels= argument`. Note that this actually changes the internal levels of the factor, and to change the labels of a factor after it has been created, the assignment form  (`<-`) of the levels function is used. 

To convert the default factor fdata we use the assignment form of the levels function:

```r
data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)

#define specific labels when constructing the factor
fdata = factor(data, labels = c("Weak", "Mild", "Strong")) 
fdata
```

```
##  [1] Weak   Mild   Mild   Strong Weak   Mild   Strong Strong Weak   Mild  
## [11] Strong Strong Weak  
## Levels: Weak Mild Strong
```

```r
#re-define labels after construction
levels(fdata) = c('I','II','III')
fdata
```

```
##  [1] I   II  II  III I   II  III III I   II  III III I  
## Levels: I II III
```

Factors are an efficient way to store character values, because each unique character value is stored only once, and the data itself is stored as a vector of integers. 

To change the order in which the levels will be displayed from their default sorted order, the levels= argument can be given a vector of all the possible values of the variable in the order you desire. 

Consider some data consisting of the names of months:


```r
theMonths = c("March","April","January","November","January",
 "September","October","September","November","August",
 "January","November","November","February","May","August",
 "July","December","August","August","September","November",
 "February","April")
 theMonths = factor(theMonths)
```
By default, the levels will be presented using alphabetic order, which in the case of Months will make readings of results a bit difficult when summarizing information.
 
For example, the function `table()` will tell us how many times each month has appeared in our vector theMonths


```r
table(theMonths)
```

```
## theMonths
##     April    August  December  February   January      July     March       May 
##         2         4         1         2         3         1         1         1 
##  November   October September 
##         5         1         3
```
Although the months clearly have an ordering, this is not reflected in the output of the table function. 


```r
theMonths <- factor(theMonths,levels=c("January","February","March",
             "April","May","June","July","August","September",
             "October","November","December"))

table(theMonths)
```

```
## theMonths
##   January  February     March     April       May      June      July    August 
##         3         2         1         2         1         0         1         4 
## September   October  November  December 
##         3         1         5         1
```

```r
theMonths[2] > theMonths[3]
```

```
## Warning in Ops.factor(theMonths[2], theMonths[3]): '>' not meaningful for
## factors
```

```
## [1] NA
```
 
As the results of the last operation shows, the comparison operators are not supported for unordered factors. Creating an ordered factor solves this problem: 


```r
theMonths <- factor(theMonths,levels=c("January","February","March",
             "April","May","June","July","August","September",
             "October","November","December"), ordered = TRUE)

table(theMonths)
```

```
## theMonths
##   January  February     March     April       May      June      July    August 
##         3         2         1         2         1         0         1         4 
## September   October  November  December 
##         3         1         5         1
```

```r
theMonths[2] > theMonths[3]
```

```
## [1] TRUE
```

Another common way to create factors is to split a continuous variables into intervals using the `cut` function. The `breaks= argument` to cut is used to describe how ranges of numbers will be converted to factor values. If a number is provided through the `breaks= argument`, the resulting factor will be created by dividing the range of the variable into that number of equal length intervals; if a vector of values is provided, the values in the vector are used to determine the breakpoint. Note that if a vector of values is provided, the number of levels of the resultant factor will be one less than the number of values in the vector.

For example, consider the women data set, which contains height and weights for a sample of women. If we wanted to create a factor corresponding to weight, with three equally-spaced levels, we could use the following:

```r
data("women")
wfact = cut(women$height,3)
wfact
```

```
##  [1] (58,62.7]   (58,62.7]   (58,62.7]   (58,62.7]   (58,62.7]   (62.7,67.3]
##  [7] (62.7,67.3] (62.7,67.3] (62.7,67.3] (62.7,67.3] (67.3,72]   (67.3,72]  
## [13] (67.3,72]   (67.3,72]   (67.3,72]  
## Levels: (58,62.7] (62.7,67.3] (67.3,72]
```

```r
table(wfact)
```

```
## wfact
##   (58,62.7] (62.7,67.3]   (67.3,72] 
##           5           5           5
```
The `labels= argument` to cut allows you to specify the levels of the factors, instead of the intervals

```r
wfact = cut(women$height,3,labels=c('Low','Medium','High'))
table(wfact)
```

```
## wfact
##    Low Medium   High 
##      5      5      5
```




