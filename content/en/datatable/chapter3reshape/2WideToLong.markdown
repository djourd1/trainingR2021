---
title: "Wide to Long" 
linktitle: "Wide to Long" 
slug: widetolong
date: '2021-02-19'
type: book

weight: 20
---


## Learning objectives



When  entering data from surveys or when you are working with time series, you will very often use the wide format.
However, many packages require data in the long format, because the data are more tidy. 

{{< figure library="true" src="wideToLong.svg" >}}

In this section, you will learn how to use the function melt of the data.table package.
At the end of this section you should be able to melt several columns into one column, or when needed melt several columns into several columns.

## The original data set

Let's imagine that you collected respondents' income and financial capital in 2010 and in 2015.
If you decided to capture that information using a wide format, the data set will be organized as follows:

+ one line per respondent
+ one column per repeated answer, let's names the columns inc_2010, inc_2015, cap_2010, and cap_2015
+ additional columns to describe the respondents, imagine you recorded the city of residence and the age

Let's create an artificial table corresponding to this situation:


```r
set.seed(12345) #use set.seed to get a reproducible result
N <- 12
DT = data.table(id=rep(1:N), age = sample(30:60, N, TRUE), 
                city = sample(c("Pretoria", "Cape Town", "Durban"), N, TRUE),
                inc_2010 =sample(1000:2000,N,TRUE),
                inc_2015 =sample(1000:2000,N,TRUE),
                cap_2010 = sample(0:500, N, TRUE),
                cap_2015 = sample(0:500, N, TRUE))
DT[3,5] <- NA   #create a missing value

DT
```

```
##     id age      city inc_2010 inc_2015 cap_2010 cap_2015
##  1:  1  43    Durban     1392     1499      462       66
##  2:  2  48 Cape Town     1013     1634      210      432
##  3:  3  45    Durban     1652       NA      144       73
##  4:  4  55 Cape Town     1703     1872      382       55
##  5:  5  57 Cape Town     1147     1799      144      362
##  6:  6  53  Pretoria     1617     1536      164      376
##  7:  7  55    Durban     1886     1035       57       90
##  8:  8  58 Cape Town     1527     1743      105      115
##  9:  9  40 Cape Town     1591     1970      450       33
## 10: 10  53  Pretoria     1061     1165      210      427
## 11: 11  31 Cape Town     1479     1648       12      162
## 12: 12  51    Durban     1353     1900      222      108
```

## One column to melt

### What do you want to obtain?

If you want to reshape your table as a long format for the variable income, you want to obtain:

+ one line per respondent and per year
+ one column corresponding to the income of that year
+ additional columns to describe the respondents

### Use `melt()`

To do so, you will use the function `melt` that is function that comes with the `data.table` package.


```r
melt(data, id.vars, measure.vars,
    variable.name = "variable", value.name = "value",
    ..., na.rm = FALSE, variable.factor = TRUE,
    value.factor = FALSE,
    verbose = getOption("datatable.verbose"))
```

In our case, we will use the following syntax:


```r
melted <- melt(data = DT, 
               id.vars = c("id", "age", "city"),   
               measure.vars = c("inc_2010", "inc_2015"),  
               value.name="income", 
               variable.name = "year",  
               na.rm = TRUE)
melted
```

```
##     id age      city     year income
##  1:  1  43    Durban inc_2010   1392
##  2:  2  48 Cape Town inc_2010   1013
##  3:  3  45    Durban inc_2010   1652
##  4:  4  55 Cape Town inc_2010   1703
##  5:  5  57 Cape Town inc_2010   1147
##  6:  6  53  Pretoria inc_2010   1617
##  7:  7  55    Durban inc_2010   1886
##  8:  8  58 Cape Town inc_2010   1527
##  9:  9  40 Cape Town inc_2010   1591
## 10: 10  53  Pretoria inc_2010   1061
## 11: 11  31 Cape Town inc_2010   1479
## 12: 12  51    Durban inc_2010   1353
## 13:  1  43    Durban inc_2015   1499
## 14:  2  48 Cape Town inc_2015   1634
## 15:  4  55 Cape Town inc_2015   1872
## 16:  5  57 Cape Town inc_2015   1799
## 17:  6  53  Pretoria inc_2015   1536
## 18:  7  55    Durban inc_2015   1035
## 19:  8  58 Cape Town inc_2015   1743
## 20:  9  40 Cape Town inc_2015   1970
## 21: 10  53  Pretoria inc_2015   1165
## 22: 11  31 Cape Town inc_2015   1648
## 23: 12  51    Durban inc_2015   1900
##     id age      city     year income
```

{{< alert note >}}
Note:
+ for the id.vars, we chose a vector of column names; but it is possible to use a vector of column numbers
+ for the mesure.vars, we declared the column names that we want to "melt" into different lines, so we chose only the columns starting with "inc_"
+ We gave meaningful names for the variable and value columns (if we do not, melt will chose generic names)
+ By default, the variable (here year) is created as a factor;
+ By default, the data set is ordered by the newly created variable (here year); 
+ The na.rm = TRUE option  elmininated the lines where the value of the answer was not available. If you want the full set of lines, just change the na.rm parameter to FALSE.
+ The columns cap_2010 and cap_2015 are not identified as id or measure, they are not considered by melt
{{< /alert >}}



```r
melted <- melt(DT, id=1:2, measure=patterns("inc_"), na.rm=TRUE)
melted[order(id)]
```

```
##     id age variable value
##  1:  1  43 inc_2010  1392
##  2:  1  43 inc_2015  1499
##  3:  2  48 inc_2010  1013
##  4:  2  48 inc_2015  1634
##  5:  3  45 inc_2010  1652
##  6:  4  55 inc_2010  1703
##  7:  4  55 inc_2015  1872
##  8:  5  57 inc_2010  1147
##  9:  5  57 inc_2015  1799
## 10:  6  53 inc_2010  1617
## 11:  6  53 inc_2015  1536
## 12:  7  55 inc_2010  1886
## 13:  7  55 inc_2015  1035
## 14:  8  58 inc_2010  1527
## 15:  8  58 inc_2015  1743
## 16:  9  40 inc_2010  1591
## 17:  9  40 inc_2015  1970
## 18: 10  53 inc_2010  1061
## 19: 10  53 inc_2015  1165
## 20: 11  31 inc_2010  1479
## 21: 11  31 inc_2015  1648
## 22: 12  51 inc_2010  1353
## 23: 12  51 inc_2015  1900
##     id age variable value
```

{{< alert note >}}
Notes:
+ you can use `id` and `measure` instead of `id.vars` and `measure.vars`
+ you can use the function `patterns()` when you have series of columns starting with the same name
{{< /alert >}}


{{< alert warning >}}
  
+ It is always a good idea to check that the operation gave the expected results by checking a few results randomly 
+ The new data set is sorted by `variable`. So you may want to sort your data according to `id` to get a better feeling at what actually happened.  

{{< /alert >}}



## Several columns to melt

### All under one new value variable

We can decide to melt different columns. For example, if you want to melt of the numeric variables, you can just omit the `measure` attribute.
If only one of `id.vars` or `measure.vars` is supplied, the rest of the columns will be assigned to the other. 


```r
melted <- melt(DT, id=1:3)
melted[order(id)]
```

```
##     id age      city variable value
##  1:  1  43    Durban inc_2010  1392
##  2:  1  43    Durban inc_2015  1499
##  3:  1  43    Durban cap_2010   462
##  4:  1  43    Durban cap_2015    66
##  5:  2  48 Cape Town inc_2010  1013
##  6:  2  48 Cape Town inc_2015  1634
##  7:  2  48 Cape Town cap_2010   210
##  8:  2  48 Cape Town cap_2015   432
##  9:  3  45    Durban inc_2010  1652
## 10:  3  45    Durban inc_2015    NA
## 11:  3  45    Durban cap_2010   144
## 12:  3  45    Durban cap_2015    73
## 13:  4  55 Cape Town inc_2010  1703
## 14:  4  55 Cape Town inc_2015  1872
## 15:  4  55 Cape Town cap_2010   382
## 16:  4  55 Cape Town cap_2015    55
## 17:  5  57 Cape Town inc_2010  1147
## 18:  5  57 Cape Town inc_2015  1799
## 19:  5  57 Cape Town cap_2010   144
## 20:  5  57 Cape Town cap_2015   362
## 21:  6  53  Pretoria inc_2010  1617
## 22:  6  53  Pretoria inc_2015  1536
## 23:  6  53  Pretoria cap_2010   164
## 24:  6  53  Pretoria cap_2015   376
## 25:  7  55    Durban inc_2010  1886
## 26:  7  55    Durban inc_2015  1035
## 27:  7  55    Durban cap_2010    57
## 28:  7  55    Durban cap_2015    90
## 29:  8  58 Cape Town inc_2010  1527
## 30:  8  58 Cape Town inc_2015  1743
## 31:  8  58 Cape Town cap_2010   105
## 32:  8  58 Cape Town cap_2015   115
## 33:  9  40 Cape Town inc_2010  1591
## 34:  9  40 Cape Town inc_2015  1970
## 35:  9  40 Cape Town cap_2010   450
## 36:  9  40 Cape Town cap_2015    33
## 37: 10  53  Pretoria inc_2010  1061
## 38: 10  53  Pretoria inc_2015  1165
## 39: 10  53  Pretoria cap_2010   210
## 40: 10  53  Pretoria cap_2015   427
## 41: 11  31 Cape Town inc_2010  1479
## 42: 11  31 Cape Town inc_2015  1648
## 43: 11  31 Cape Town cap_2010    12
## 44: 11  31 Cape Town cap_2015   162
## 45: 12  51    Durban inc_2010  1353
## 46: 12  51    Durban inc_2015  1900
## 47: 12  51    Durban cap_2010   222
## 48: 12  51    Durban cap_2015   108
##     id age      city variable value
```

Note that with this syntax, the variable column include either some income or some capital data. It may not be what you are looking for.

### Create several values variables

In order to avoid this, the attribute measure should take the form of list:


```r
melted <- melt(DT, id=1:3, measure = list(c("inc_2010", "inc_2015"), c("cap_2010", "cap_2015") ))
melted[variable == 1, year := "2010"][variable == 2, year := "2015"]
melted[order(id)]
```

```
##     id age      city variable value1 value2 year
##  1:  1  43    Durban        1   1392    462 2010
##  2:  1  43    Durban        2   1499     66 2015
##  3:  2  48 Cape Town        1   1013    210 2010
##  4:  2  48 Cape Town        2   1634    432 2015
##  5:  3  45    Durban        1   1652    144 2010
##  6:  3  45    Durban        2     NA     73 2015
##  7:  4  55 Cape Town        1   1703    382 2010
##  8:  4  55 Cape Town        2   1872     55 2015
##  9:  5  57 Cape Town        1   1147    144 2010
## 10:  5  57 Cape Town        2   1799    362 2015
## 11:  6  53  Pretoria        1   1617    164 2010
## 12:  6  53  Pretoria        2   1536    376 2015
## 13:  7  55    Durban        1   1886     57 2010
## 14:  7  55    Durban        2   1035     90 2015
## 15:  8  58 Cape Town        1   1527    105 2010
## 16:  8  58 Cape Town        2   1743    115 2015
## 17:  9  40 Cape Town        1   1591    450 2010
## 18:  9  40 Cape Town        2   1970     33 2015
## 19: 10  53  Pretoria        1   1061    210 2010
## 20: 10  53  Pretoria        2   1165    427 2015
## 21: 11  31 Cape Town        1   1479     12 2010
## 22: 11  31 Cape Town        2   1648    162 2015
## 23: 12  51    Durban        1   1353    222 2010
## 24: 12  51    Durban        2   1900    108 2015
##     id age      city variable value1 value2 year
```

{{< alert warning >}}
  
+ If order is important, make sure the vectors inside the list maintain this order (here 2010, 2015)
+ Note that the new variable is a factor with two labels 1 and 2
+ As shown in the example, it is easy to create an additional column `year`

{{< /alert >}}

In this case, the function patterns become very useful:


```r
melted <- melt(DT, id=1:3, measure=patterns("inc_", "cap_"))
melted[order(id)]
```

```
##     id age      city variable value1 value2
##  1:  1  43    Durban        1   1392    462
##  2:  1  43    Durban        2   1499     66
##  3:  2  48 Cape Town        1   1013    210
##  4:  2  48 Cape Town        2   1634    432
##  5:  3  45    Durban        1   1652    144
##  6:  3  45    Durban        2     NA     73
##  7:  4  55 Cape Town        1   1703    382
##  8:  4  55 Cape Town        2   1872     55
##  9:  5  57 Cape Town        1   1147    144
## 10:  5  57 Cape Town        2   1799    362
## 11:  6  53  Pretoria        1   1617    164
## 12:  6  53  Pretoria        2   1536    376
## 13:  7  55    Durban        1   1886     57
## 14:  7  55    Durban        2   1035     90
## 15:  8  58 Cape Town        1   1527    105
## 16:  8  58 Cape Town        2   1743    115
## 17:  9  40 Cape Town        1   1591    450
## 18:  9  40 Cape Town        2   1970     33
## 19: 10  53  Pretoria        1   1061    210
## 20: 10  53  Pretoria        2   1165    427
## 21: 11  31 Cape Town        1   1479     12
## 22: 11  31 Cape Town        2   1648    162
## 23: 12  51    Durban        1   1353    222
## 24: 12  51    Durban        2   1900    108
##     id age      city variable value1 value2
```
