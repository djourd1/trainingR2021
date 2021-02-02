---
title: Select Rows
linktitle: Select Rows
type: book
date: "2021-02-02T00:00:00+01:00"

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 2
---





## Selecting by row numbers

A first way to select the lines you want to work with is to specify a range of line numbers. If selecting the rows is the only operation you want to perform, there is no need to put a comma after the range of numbers. However, including a comma will also work. Personally, I usually keep the comma, because it reminds me that I am working on the part `i`



```r
ans <- DT[1:3, ]
ans
```


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  1|  43|Cape Town |     3|     1|     1|
|  2|  48|Cape Town |    NA|     3|     2|
|  3|  45|Pretoria  |     2|     2|     2|

If the rows you want to work with are not in a continuous range, you can declare them in a more precise ways, for example, using the `c()` command to enumerate the row numbers


```r
ans <- DT[c(2, 5, 7), ]
ans
```


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  2|  48|Cape Town |    NA|     3|     2|
|  5|  31|Cape Town |     2|     1|     3|
|  7|  35|Cape Town |     2|     3|     3|

## Eliminating some rows

Sometimes, it will make more sense to eliminate a few rows. To do this, you can put a `-` sign in front of the range or the selection of rows. Make sure you use parenthesis around the range.


```r
ans <- DT[-(1:5), ]
ans
```


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  6|  40|Pretoria  |     3|     3|     1|
|  7|  35|Cape Town |     2|     3|     3|
|  8|  36|Cape Town |     2|     1|     3|
|  9|  39|Cape Town |     3|     3|     1|
| 10|  46|Cape Town |     1|     1|     2|


## Taking a random sub-sample of rows

Sometimes, you just want to take a random sub-sample of your data. To do this, you can take advantage of the function `sample()` and the function `nrow()`.

The following command will select three random rows out of the existing 10. 



```r
set.seed(1234567)
DT[sample(1:nrow(DT), 3, replace=FALSE) , ]
```


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  1|  43|Cape Town |     3|     1|     1|
|  5|  31|Cape Town |     2|     1|     3|
| 10|  46|Cape Town |     1|     1|     2|

*Note:* The command `sample(1:nrow(DT), 3, replace=FALSE)` will create a vector of three random numbers between 1 and the number of rows. So technically, you are generating a sequence of row numbers that will be used to select the rows to retain. 


## Exercise

+ Eliminate the rows 2, 5, and 9 
+ Compare the results of DT[c(1,4, 5), ] and DT[c(1,5,4)]
+ Can you make a random sample of DT that would include 20 rows ?


## Selecting rows based on a logical criterion

Let say, you want to look only at the respondents living in Cape Town. To do this, you will include a logical condition in the frame [...]. Only rows that corresponds for which the condition is met will be selected.



```r
ans <- DT[city=="Cape Town",]
ans
```


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  1|  43|Cape Town |     3|     1|     1|
|  2|  48|Cape Town |    NA|     3|     2|
|  4|  40|Cape Town |     1|     1|     3|
|  5|  31|Cape Town |     2|     1|     3|
|  7|  35|Cape Town |     2|     3|     3|
|  8|  36|Cape Town |     2|     1|     3|
|  9|  39|Cape Town |     3|     3|     1|
| 10|  46|Cape Town |     1|     1|     2|

Note that: 
+ An important feature of `data.table` is that within the frame of a data.table, columns can be referred to *as if they are variables*. Therefore, we simply refer to `city` as if it is a variable. We do not need to add the prefix `DT$` each time. Nevertheless, using `DT$city` would work just fine.

+ Only the rows that satisfy the condition `city=="Cape Town"` are selected. Since there is nothing else left to do (the `j` part is empty), all columns from DT at rows corresponding to those row indices are returned as a data.table.

+ A comma after the condition is not required. Again, `DT[city=="Cape Town" ]` would also work. 

## Exercise

+ Select respondants from Cape Town whose age is greater or equal to 35
