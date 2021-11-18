---
title: "Add, Update Columns"
linktitle: "Add, Update Columns"
pagetitle: 
author: Damien Jourdain
date: '2019-03-04'
slug: add-columns
categories:
  - R
tags: []
type: book

weight: 40
---




## Learning objectives

In this section you will learn:

+ [How to add (calculated) columns](#add-columns)
  + [The LHS := RHS form](#the-lhs-rhs-form)
  + [The functional form](#the-functional-form)
+ [How to delete some columns](#delete-some-columns)
+ [How to columns but only for some selected rows](#update-some-rows-of-columns)

## Add columns

The most efficient way to add colum is to use the `:=` operator. It can be used in j in two ways:

1.  The LHS := RHS form
2.  The functional form


### The LHS := RHS form
#### With one column to add : DT[, colA := valA]

You may want to transform one variable, let say `year` into a categorical corresponding to year ranges. To do this, you can use the function `cut()`


```r
cut(x, breaks, labels = NULL,
    include.lowest = FALSE, right = TRUE, dig.lab = 3,
    ordered_result = FALSE, ...)
```

In our case, we create a new factor variable named `decade`, and we give our own labels.


```r
DT[, decade := cut(year, 
                   breaks=c(1950, 1960, 1970,1980,1990, 2000, 2010), 
                   labels = c("50s","60s", "70s", "80s", "90s", "00s"))]
DT
```

```
##           country continent year lifeExp      pop gdpPercap   id decade
##    1: Afghanistan      Asia 1952  28.801  8425333  779.4453    1    50s
##    2: Afghanistan      Asia 1957  30.332  9240934  820.8530    2    50s
##    3: Afghanistan      Asia 1962  31.997 10267083  853.1007    3    60s
##    4: Afghanistan      Asia 1967  34.020 11537966  836.1971    4    60s
##    5: Afghanistan      Asia 1972  36.088 13079460  739.9811    5    70s
##   ---                                                                  
## 1700:    Zimbabwe    Africa 1987  62.351  9216418  706.1573 1700    80s
## 1701:    Zimbabwe    Africa 1992  60.377 10704340  693.4208 1701    90s
## 1702:    Zimbabwe    Africa 1997  46.809 11404948  792.4500 1702    90s
## 1703:    Zimbabwe    Africa 2002  39.989 11926563  672.0386 1703    00s
## 1704:    Zimbabwe    Africa 2007  43.487 12311143  469.7093 1704    00s
```

_Note_: Contrary to what we would have done with data.frame, we did not have to assign the result back to DT. The data.table now contains one newly added column. The result is returned invisibly. Internally, the mechanism is also different and more efficiently as well, but we will not describe this process here. 

#### With several columns to add: DT[, c("colA", "colB") := list(valA, valB)]

If you want to transform two variables  the same time, you can still use the := operator, but be careful with the syntax. On the left side, you provide a vector of new colum names, on the right side you provide a list of operations.

If you want to create two new categorical variables to represent population and life expectency. You can still apply the function cut, but to these two variables:


```r
DT[, c("lifeExpC", "popC") := .(cut(lifeExp, 3), cut(pop, 3))][]
```

```
##           country continent year lifeExp      pop gdpPercap   id decade
##    1: Afghanistan      Asia 1952  28.801  8425333  779.4453    1    50s
##    2: Afghanistan      Asia 1957  30.332  9240934  820.8530    2    50s
##    3: Afghanistan      Asia 1962  31.997 10267083  853.1007    3    60s
##    4: Afghanistan      Asia 1967  34.020 11537966  836.1971    4    60s
##    5: Afghanistan      Asia 1972  36.088 13079460  739.9811    5    70s
##   ---                                                                  
## 1700:    Zimbabwe    Africa 1987  62.351  9216418  706.1573 1700    80s
## 1701:    Zimbabwe    Africa 1992  60.377 10704340  693.4208 1701    90s
## 1702:    Zimbabwe    Africa 1997  46.809 11404948  792.4500 1702    90s
## 1703:    Zimbabwe    Africa 2002  39.989 11926563  672.0386 1703    00s
## 1704:    Zimbabwe    Africa 2007  43.487 12311143  469.7093 1704    00s
##          lifeExpC                popC
##    1: (23.5,43.3] (-1.26e+06,4.4e+08]
##    2: (23.5,43.3] (-1.26e+06,4.4e+08]
##    3: (23.5,43.3] (-1.26e+06,4.4e+08]
##    4: (23.5,43.3] (-1.26e+06,4.4e+08]
##    5: (23.5,43.3] (-1.26e+06,4.4e+08]
##   ---                                
## 1700: (43.3,62.9] (-1.26e+06,4.4e+08]
## 1701: (43.3,62.9] (-1.26e+06,4.4e+08]
## 1702: (43.3,62.9] (-1.26e+06,4.4e+08]
## 1703: (23.5,43.3] (-1.26e+06,4.4e+08]
## 1704: (43.3,62.9] (-1.26e+06,4.4e+08]
```

_Notes_:

+ Again, the instruction are taking place within the braces, so there is no need to use an assignement unless you want to create a separate table.
+ Running the instruction does not create any output to the console. If you want to get an output to the console, you will need to add an empty brace (see chaining instruction), or write a new line with DT.


### The functional form


```r
DT[, `:=`(colA = valA, # valA is assigned to colA
          colB = valB, # valB is assigned to colB
          )]
```


```r
DT[, `:=`(
  popC = cut(pop, 4) ,  # Cut the population variable 
  lifeExpC = cut(lifeExp,4)  #Cut the lifeExp variable
)]
```

_Note_: The functional form allows to add comments on the side to explain what the computation does. 


## Delete some columns

You can use the syntax used to create new variables to delete unwanted variables, by assigning the NULL value to that column.


```r
DT[, lifeExpC := NULL][]
```

```
##           country continent year lifeExp      pop gdpPercap   id decade
##    1: Afghanistan      Asia 1952  28.801  8425333  779.4453    1    50s
##    2: Afghanistan      Asia 1957  30.332  9240934  820.8530    2    50s
##    3: Afghanistan      Asia 1962  31.997 10267083  853.1007    3    60s
##    4: Afghanistan      Asia 1967  34.020 11537966  836.1971    4    60s
##    5: Afghanistan      Asia 1972  36.088 13079460  739.9811    5    70s
##   ---                                                                  
## 1700:    Zimbabwe    Africa 1987  62.351  9216418  706.1573 1700    80s
## 1701:    Zimbabwe    Africa 1992  60.377 10704340  693.4208 1701    90s
## 1702:    Zimbabwe    Africa 1997  46.809 11404948  792.4500 1702    90s
## 1703:    Zimbabwe    Africa 2002  39.989 11926563  672.0386 1703    00s
## 1704:    Zimbabwe    Africa 2007  43.487 12311143  469.7093 1704    00s
##                      popC
##    1: (-1.26e+06,3.3e+08]
##    2: (-1.26e+06,3.3e+08]
##    3: (-1.26e+06,3.3e+08]
##    4: (-1.26e+06,3.3e+08]
##    5: (-1.26e+06,3.3e+08]
##   ---                    
## 1700: (-1.26e+06,3.3e+08]
## 1701: (-1.26e+06,3.3e+08]
## 1702: (-1.26e+06,3.3e+08]
## 1703: (-1.26e+06,3.3e+08]
## 1704: (-1.26e+06,3.3e+08]
```

## Update columns but only for some selected rows {#update-some-rows-of-columns}

Since `:=` is available in *j*, we can combine it with *i* . This allows you to update some colums values only for specific rows.

Let say, you want to correct the year for South Africa by adding one year. This can be done by with the two instructions, first create the variable correctedYear as a copy of the variable year. Then correct the values only for the South Africa. 


```r
DT[, correctedYear := year][country=="South Africa", correctedYear := year +1L][country %in% c("South Africa", "Namibia"), .(id, country, year, correctedYear)]
```

```
##       id      country year correctedYear
##  1: 1057      Namibia 1952          1952
##  2: 1058      Namibia 1957          1957
##  3: 1059      Namibia 1962          1962
##  4: 1060      Namibia 1967          1967
##  5: 1061      Namibia 1972          1972
##  6: 1062      Namibia 1977          1977
##  7: 1063      Namibia 1982          1982
##  8: 1064      Namibia 1987          1987
##  9: 1065      Namibia 1992          1992
## 10: 1066      Namibia 1997          1997
## 11: 1067      Namibia 2002          2002
## 12: 1068      Namibia 2007          2007
## 13: 1405 South Africa 1952          1953
## 14: 1406 South Africa 1957          1958
## 15: 1407 South Africa 1962          1963
## 16: 1408 South Africa 1967          1968
## 17: 1409 South Africa 1972          1973
## 18: 1410 South Africa 1977          1978
## 19: 1411 South Africa 1982          1983
## 20: 1412 South Africa 1987          1988
## 21: 1413 South Africa 1992          1993
## 22: 1414 South Africa 1997          1998
## 23: 1415 South Africa 2002          2003
## 24: 1416 South Africa 2007          2008
##       id      country year correctedYear
```

_Note_: 

+ We added `1L`. This is because year is an integer variable, and we want to make sure we add one as an integer. 
+ It is always a good idea to check the results of your operation. To do so, I chained another operation to verify that the corrections occured only for South Africa. 






