---
title: Factors
author: Damien Jourdain
date: '2019-02-19'
slug: factors
categories:
  - data structure
tags: []
type: book
weight: 30
---

## Learning objectives

Factors are used to store categorical variables, i.e. variables that take a limited number of different values. Categorical variables enter statistical models differently than continuous variables, which is why R developers have created a specific type of data to ensure that the modeling functions will handle this data correctly. 

Here you will learn how to create and manipulate factors. 


## Factors

Practically, factors are stored as a vector of integer values with a corresponding set of character values to use when the factor is displayed. 

### Convert a vector 

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

### Define the levels and labels

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

### Ordered vs. Unordered Factors

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


