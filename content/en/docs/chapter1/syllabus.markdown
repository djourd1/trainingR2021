---
title: Syllabus
linktitle: Syllabus
type: book
date: "2019-05-05T00:00:00+01:00"

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 1
---

## Learning objectives

In this section, you will learn how to:

+ [Select a subset of rows](#subsetting-rows)
  + [using the row numbers](#subsetting-rows-by-their-indices)
  + [using logical criteria](#subsetting-rows-based-on-logical-criteria)
  + [creating random sub-samples](#taking-a-random-sub-sample-of-rows)
+ [Sort records](#sort-records)
+ [Select then order rows](#chaining-data-treatments-subsetting-and-ordering)
+ [Select a subset of columns](#subsetting-columns)
+ [Select a subset of rows and columns](#subsetting-rows-and-columns)

## The data 





```r
#load packages - create same data set
library(data.table)
set.seed(12345)
N <- 10
DT = data.table(id=rep(1:N), age = sample(30:50, N, TRUE), 
                city = sample(c("Pretoria", "Cape Town"), N, TRUE),
                ans_1=sample(3,N,TRUE),
                ans_2=sample(3,N,TRUE),
                ans_3=sample(3,N,TRUE) )
DT[2,4] <- NA   #create a missing value
```

We will still work with our artificial small data frame.


| id| age|city      | ans_1| ans_2| ans_3|
|--:|---:|:---------|-----:|-----:|-----:|
|  1|  43|Cape Town |     3|     1|     1|
|  2|  48|Cape Town |    NA|     3|     2|
|  3|  45|Pretoria  |     2|     2|     2|
|  4|  40|Cape Town |     1|     1|     3|
|  5|  31|Cape Town |     2|     1|     3|
|  6|  40|Pretoria  |     3|     3|     1|
|  7|  35|Cape Town |     2|     3|     3|
|  8|  36|Cape Town |     2|     1|     3|
|  9|  39|Cape Town |     3|     3|     1|
| 10|  46|Cape Town |     1|     1|     2|
