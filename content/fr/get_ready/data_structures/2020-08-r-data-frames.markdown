---
title: "R Data Frames"
author: "Damien Jourdain"
date: '2020-08-20'
slug: r-data-frames
categories: R
tags: []
type: book
weight: 8
---

## Learning objectives

*Dataframes* allow to store data of *different types* into a single tabular structure.

Dataframes are very handy to work with survey data since they are usually stored in tabular form (with many columns (corresponding to the responses to the survey) and many rows (usually one row corresponding to one survey). 

In this section, you will learn:

+ [What is a data frame](#what-is-a-data-frame)
+ [Access the data](#how-to-retrieve-the-data)
+ [Sort the data](#how-to-sort-a-data-frame)
+ [Summarize the data](#summary-of-data-in-data-frame)
+ [Create a data.frame](#create-a-data-frame)
+ [Other classes of data frames](#other-classes-of-data-frames)
  + [Tibbles](#tibbles)
  + [data.table](#datatable)
  
## What is a data frame? 
A data frame is a *table* or a *two-dimensional array-like structure* in which each column contains values of one variable and each row contains one set of values from each column.

Following are the characteristics of a data frame.

+    The column names should be non-empty.
+    The row names should be unique.
+    The data stored in a data frame can be of numeric, factor or character type.
+    Each column should contain same number of data items.

> Data frames are particularly useful because we can combine different types into one single object and are easier to handle than lists.  

We can use built-in dataframes in R to understand this. For example, here is a built-in data frame in R, called `mtcars`. You can access it by just simplying typing its name.



```r
mtcars   #for this document we used a modified version of mtcars with only 10 rows
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
```

The top line of the table, called the *header*, contains the *column names*. Each horizontal line afterward denotes a *data row*, which begins with the name of the row, and then followed by the actual data. Each data member of a row is called a *cell*. 

You can easily interpret this as a data frame describing cars. Each row corresponds to a unique model of car, each column corresponds to the different characteristics of the cars.

If you want to know the exact structure of the object mtcars, you can use the function `str()`

```r
str(mtcars)
```

```
## 'data.frame':	10 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1
##  $ am  : num  1 1 1 0 0 0 0 0 0 0
##  $ gear: num  4 4 4 3 3 3 3 4 4 4
##  $ carb: num  4 4 1 1 2 1 4 2 2 4
```
We are learning that mtcars is an R object of type `data.frame`, that contains 10 observations (i.e. 10 rows) of 11 variables (i.e., 11 columns).


## How to retrieve the data? 
### Data in a cell
To retrieve data in a cell, we would enter its row and column coordinates in the single square bracket "[]" operator. The two coordinates are separated by a comma. In other words, the coordinates begins with row position, then followed by a comma, and ends with the column position. The order is important.

Here is the cell value from the first row, second column of mtcars.

```r
mtcars[1, 2]
```

```
## [1] 6
```
Moreover, we can use the row and column names instead of the numeric coordinates.

```r
mtcars["Mazda RX4", "cyl"] 
```

```
## [1] 6
```

### Data contained in a column

There are several ways to retrieve the data contained into the columns.

First, we can retrieve the same column with the "$" operator:

```r
mtcars$am 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```

```r
class(mtcars$am)
```

```
## [1] "numeric"
```
Note that you need to know the name of the column you want to retrieve. However, if using R Studio, if you once you have typed mtcars$ a list of possible names will be suggested to you. (yet another good reason to use R Studio instead of R)


Second, we can retrieve the same column with the single square bracket "[]" operator. To do this, we have to prepend the column name (or column number) with a comma character, which signals that we want to take consider all the rows

```r
mtcars[,"am"] 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```

```r
mtcars[,9] 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```
Note in this second case, that you do not need to remember the name of the column, but just its position in the table. 

Note that, in both cases

+ the order of the entries in the mtcars$am list preserves the order of the rows in our data table. This is important this it allows us to manipulate one variable based on the results of another.
+ the object, mtcars$am, is not one number. It's a vector containing 10 numbers.

Note that a single number is technically a vector, but that in general, they have several entries. The function `length` tells you how many.


```r
am <- mtcars$am 
class(am)
```

```
## [1] "numeric"
```

```r
length(am)
```

```
## [1] 10
```
This particular vector is a numeric vector since `am` column contains numbers.

Remember that vectors can be of different types, but all elements of one vector have to be of the same type.

### Data contained in several columns

This use of brackets is becoming especially usuful when you want to retrieve several columns in one command. Try this command:

```r
(carsub <- mtcars[,2:4])
```

```
##                   cyl  disp  hp
## Mazda RX4           6 160.0 110
## Mazda RX4 Wag       6 160.0 110
## Datsun 710          4 108.0  93
## Hornet 4 Drive      6 258.0 110
## Hornet Sportabout   8 360.0 175
## Valiant             6 225.0 105
## Duster 360          8 360.0 245
## Merc 240D           4 146.7  62
## Merc 230            4 140.8  95
## Merc 280            6 167.6 123
```

```r
str(carsub)
```

```
## 'data.frame':	10 obs. of  3 variables:
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123
```
This example shows that you can extract the columns 2, 3 and 4 of the table mtcars and store them in a new data.frame called carsub. 

Note that if you want to show several columns that are now in a sequence of numbers, you can use the R function `c()`. Remember that c() is a generic function to combine arguments (and forming a vector). So if you want to select the columns 3,7 and 11:


```r
(carsub <- mtcars[,c(3,7,11)])
```

```
##                    disp  qsec carb
## Mazda RX4         160.0 16.46    4
## Mazda RX4 Wag     160.0 17.02    4
## Datsun 710        108.0 18.61    1
## Hornet 4 Drive    258.0 19.44    1
## Hornet Sportabout 360.0 17.02    2
## Valiant           225.0 20.22    1
## Duster 360        360.0 15.84    4
## Merc 240D         146.7 20.00    2
## Merc 230          140.8 22.90    2
## Merc 280          167.6 18.30    4
```

```r
str(carsub)
```

```
## 'data.frame':	10 obs. of  3 variables:
##  $ disp: num  160 160 108 258 360 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4
```

Note that the function c() is not limited to combine numbers. It can combine many different types of objects into one vector. (as long as all the objects you want to combine are of the same type).

So you would obtain the result by typing a vector of column names:


```r
mtcars[ ,c("disp", "qsec","carb")]
```

```
##                    disp  qsec carb
## Mazda RX4         160.0 16.46    4
## Mazda RX4 Wag     160.0 17.02    4
## Datsun 710        108.0 18.61    1
## Hornet 4 Drive    258.0 19.44    1
## Hornet Sportabout 360.0 17.02    2
## Valiant           225.0 20.22    1
## Duster 360        360.0 15.84    4
## Merc 240D         146.7 20.00    2
## Merc 230          140.8 22.90    2
## Merc 280          167.6 18.30    4
```

### Data contained in the rows

We retrieve rows from a data frame with the single square bracket operator, just like what we did with columns. However, in additional to an index vector of row positions, we append an extra comma character. This is important, as the extra comma signals a wildcard match for the second coordinate for column positions. 


```r
mtcars[1:2, ] 
```

```
##               mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
```

Once you understand this syntax and what was said in the previous section about selection of columns, you should be able to select different row selections using the c() function and either row number or row names.


```r
mtcars[c(1,3,10), ] 
```

```
##             mpg cyl  disp  hp drat   wt  qsec vs am gear carb
## Mazda RX4  21.0   6 160.0 110 3.90 2.62 16.46  0  1    4    4
## Datsun 710 22.8   4 108.0  93 3.85 2.32 18.61  1  1    4    1
## Merc 280   19.2   6 167.6 123 3.92 3.44 18.30  1  0    4    4
```

### Sub set of rows and sub-set of columns


```r
mtcars[c(1,3,10), c(2, 3:5) ] 
```

```
##            cyl  disp  hp drat
## Mazda RX4    6 160.0 110 3.90
## Datsun 710   4 108.0  93 3.85
## Merc 280     6 167.6 123 3.92
```

## How to sort a data.frame?

To sort a data.frame, use the `order( )` function. By default, sorting is ASCENDING. Prepend the sorting variable by a minus sign to indicate DESCENDING order. 


```r
#order the cars using the column mpg (ascending order)
mtcars[order(mtcars$mpg),]
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
```


```r
#sort the cars using two keys
mtcars[order(mtcars$mpg, -mtcars$cyl),]
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
```

## Summary of Data in Data Frame

The statistical summary and nature of the data can be obtained by applying summary() function.


```r
summary(carsub)
```

```
##       disp            qsec            carb     
##  Min.   :108.0   Min.   :15.84   Min.   :1.00  
##  1st Qu.:150.0   1st Qu.:17.02   1st Qu.:1.25  
##  Median :163.8   Median :18.45   Median :2.00  
##  Mean   :208.6   Mean   :18.58   Mean   :2.50  
##  3rd Qu.:249.8   3rd Qu.:19.86   3rd Qu.:4.00  
##  Max.   :360.0   Max.   :22.90   Max.   :4.00
```


## Create a Data Frame


```r
new.data <- data.frame(
   emp_id = c (1:5), 
   emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
   salary = c(623.3,515.2,611.0,729.0,843.25), 
   start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
      "2015-03-27")),
   stringsAsFactors = FALSE
)

str(new.data)
```

```
## 'data.frame':	5 obs. of  4 variables:
##  $ emp_id    : int  1 2 3 4 5
##  $ emp_name  : chr  "Rick" "Dan" "Michelle" "Ryan" ...
##  $ salary    : num  623 515 611 729 843
##  $ start_date: Date, format: "2012-01-01" "2013-09-23" ...
```

## Other classes of data frames

### Tibbles

Tibble is a new class of data frames (developed by RStudio teams). They are also capturing data in tabular forms, and have internal features that make working with some packages a little easier. 

You can work with tibbles by installing the suite of packages tidyverse or the specific package tibble.


```r
# install a suite of related packages
install.packages("tidyverse")

# Alternatively, install just tibble:
install.packages("tibble")
```

Then load the package tibble

```r
library(tibble)
```

```
## Warning: package 'tibble' was built under R version 4.0.3
```


Like data.frame, you can create a new tibble from individual vectors with tibble(). 

However, there are a few improvement to facilitate the creation of the data frame. tibble() will: 
+ keep strings as characters (and not convert them automatically into factors)
+ allows you to refer to variables that you just created
+ automatically recycle inputs of length 1


```r
tibble(
  x = 1:5, 
  y = 1, 
  z = x^2 + y,
  t = letters[1:5]
)
```

```
## # A tibble: 5 x 4
##       x     y     z t    
##   <int> <dbl> <dbl> <chr>
## 1     1     1     2 a    
## 2     2     1     5 b    
## 3     3     1    10 c    
## 4     4     1    17 d    
## 5     5     1    26 e
```

It also checks that columns have the same lengths (except, as seen above for unique values)


```r
tibble(
  x = 1:5, 
  t = letters[1:3]
)
```

```
## Error: Tibble columns must have compatible sizes.
## * Size 5: Existing data.
## * Size 3: Column `t`.
## i Only values of size one are recycled.
```

#### Redefined print function

With large data frames, it will show only the first 10 rows, and all the columns that fit on screen and in addition to its name, each column reports its type.


```r
ans <- tibble(
  x = 1:50, 
  t = letters[1:50],
  x2 = x^2,
  e = sample(letters, 50, replace = TRUE)
)
ans
```

```
## # A tibble: 50 x 4
##        x t        x2 e    
##    <int> <chr> <dbl> <chr>
##  1     1 a         1 k    
##  2     2 b         4 j    
##  3     3 c         9 f    
##  4     4 d        16 j    
##  5     5 e        25 v    
##  6     6 f        36 h    
##  7     7 g        49 k    
##  8     8 h        64 w    
##  9     9 i        81 s    
## 10    10 j       100 l    
## # ... with 40 more rows
```

#### Subsetting

Compared to a data.frame, tibbles are more strict: they never do partial matching, and they will generate a warning if the column you are trying to access does not exist.

Compare the two codes


```r
df <- data.frame(
  thex = runif(5),
  they = rnorm(5)
)
df$x # Extract by name
```

```
## NULL
```

```r
df$thex
```

```
## [1] 0.9763155 0.8972236 0.5351998 0.9565277 0.1355956
```

```r
df[["x"]] 
```

```
## NULL
```

```r
df[[1]] # Extract by position
```

```
## [1] 0.9763155 0.8972236 0.5351998 0.9565277 0.1355956
```


```r
df <- tibble(
  thex = runif(5),
  they = rnorm(5)
)
df$x # Extract by name 
```

```
## Warning: Unknown or uninitialised column: `x`.
```

```
## NULL
```

```r
df[["x"]] 
```

```
## NULL
```

```r
df[[1]] # Extract by position
```

```
## [1] 0.2172816 0.3047788 0.7896311 0.8447040 0.1449138
```

#### Convert a vector to a data frame

The enframe() convert a (named) vector to a two-column data frame. 


```r
v <- 1:10
names(v) <- letters[1:10]
enframe(v)
```

```
## # A tibble: 10 x 2
##    name  value
##    <chr> <int>
##  1 a         1
##  2 b         2
##  3 c         3
##  4 d         4
##  5 e         5
##  6 f         6
##  7 g         7
##  8 h         8
##  9 i         9
## 10 j        10
```

You can also convert the vector into a one-column data frame by setting the name argument to NULL. 




```r
v <- 1:10
names(v) <- letters[1:10]
enframe(v, name=NULL)
```

```
## # A tibble: 10 x 1
##    value
##    <int>
##  1     1
##  2     2
##  3     3
##  4     4
##  5     5
##  6     6
##  7     7
##  8     8
##  9     9
## 10    10
```

### data.table

data.table is a package that extends data.frames. Two of its most notable features are speed and cleaner syntax.

