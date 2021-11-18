---
title: "Long to Wide" 
linktitle: "Long to Wide" 
slug: longtowide
date: '2021-02-19'
type: book

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 40
---


## Learning objectives


In this section, you will learn how to use the function `dcast` of the data.table package.
At the end of this section you should be able to cast a long table into a wide table.

{{< figure library="true" src="longToWide.svg" >}}





## From Long to Wide format

As a starting point, we will start with a data set that is quite similar to the last `melted` data.table that we created in the previous section. However, we added a few rows, in such a way that there might have several rows for a pair (id, year); you can think about a respondent that had two sources of income or two different capital assets.

To be able to identify the cases where there are several income or several capital assets in a year, a new column yearid was created. You can quickly sport the cases when yearid > 1 for the id=3, year = 2010 case.


```r
melted
```

```
##     id age      city year income capital yearid
##  1:  1  43    Durban 2010   1123     452      1
##  2:  1  43    Durban 2015   1471     457      1
##  3:  2  48 Cape Town 2010   1866     134      1
##  4:  2  48 Cape Town 2015   1516     350      1
##  5:  3  45    Durban 2010   1362     248      1
##  6:  3  45    Durban 2010   1853     355      2
##  7:  3  45    Durban 2015   1579     201      1
##  8:  4  55 Cape Town 2010   1376     403      1
##  9:  4  55 Cape Town 2010   1431      75      2
## 10:  4  55 Cape Town 2015   1778     395      1
## 11:  5  57 Cape Town 2010   1816     353      1
## 12:  5  57 Cape Town 2015   1322     323      1
## 13:  5  57 Cape Town 2015   1219     411      2
## 14:  6  53  Pretoria 2010   1073     418      1
## 15:  6  53  Pretoria 2015   1782     389      1
## 16:  6  53  Pretoria 2015   1144      77      2
## 17:  7  55    Durban 2010   1006     375      1
## 18:  7  55    Durban 2010   1017     403      2
## 19:  7  55    Durban 2015   1553     278      1
## 20:  7  55    Durban 2015   1566       7      2
## 21:  8  58 Cape Town 2010   1345     366      1
## 22:  8  58 Cape Town 2010   1968      91      2
## 23:  8  58 Cape Town 2015   1310     323      1
## 24:  9  40 Cape Town 2010   1899     442      1
## 25:  9  40 Cape Town 2015   1987     285      1
## 26: 10  53  Pretoria 2010   1643     433      1
## 27: 10  53  Pretoria 2010   1448      24      2
## 28: 10  53  Pretoria 2015   1620      30      1
## 29: 11  31 Cape Town 2010   1543     354      1
## 30: 11  31 Cape Town 2015   1824     231      1
## 31: 11  31 Cape Town 2015   1745     175      2
## 32: 12  51    Durban 2010   1977     220      1
## 33: 12  51    Durban 2015   1759     152      1
## 34: 12  51    Durban 2015   1002     145      2
##     id age      city year income capital yearid
```

To transform a data set from long to wide, you will use the command `dcast()`



```r
dcast(data, formula, fun.aggregate = NULL, sep = "_",
      ..., margins = NULL, subset = NULL, fill = NULL,
      drop = TRUE, value.var = guess(data),
      verbose = getOption("datatable.verbose"))
```

We need to provide information for the following attributes :
  
+ data = the data.table we want to reshape;
+ formula = a formula describing how we want to reformat the data;
+ the name of the variables that will be used to construct the new columns;
+ an aggregation function, since you can have several rows for a given combination of id variables.

Like `melt`, `dcast` is very flexible and you can obtain various shapes. You will also notice that `dcast` is able to provide an output even when you do not provide all the arguments. However, I would suggest that you pay great care to the output when you do not provide all the required attributes: `dcast` function might make some guesses for you and output  results in an expected format.

We will now review several classical cases. 

### Cast only one variable with one column per year

You can obtain this with the correct arguments in the formula and value.vars:

+ LHS of the formula will include the fixed variables
+ RHS of the formula will include the casting variable: here you want one column per year, so this is the variable `year`
+ value.vars will provide the column you will cast, here income
+ In case we have several lines income or capital we we want to sum them up 

```r
dcast(melted, id+age+city~year  , value.var = "income", fun.aggregate = sum)
```

```
##     id age      city 2010 2015
##  1:  1  43    Durban 1123 1471
##  2:  2  48 Cape Town 1866 1516
##  3:  3  45    Durban 3215 1579
##  4:  4  55 Cape Town 2807 1778
##  5:  5  57 Cape Town 1816 2541
##  6:  6  53  Pretoria 1073 2926
##  7:  7  55    Durban 2023 3119
##  8:  8  58 Cape Town 3313 1310
##  9:  9  40 Cape Town 1899 1987
## 10: 10  53  Pretoria 3091 1620
## 11: 11  31 Cape Town 1543 3569
## 12: 12  51    Durban 1977 2761
```
{{< alert warning >}}
If you do not provide an aggregation function, dcast will take the  default function length; so instead of the sum of 
income, you will get the number of income sources:


```r
dcast(melted, id+age+city~year  , value.var = "income")
```

```
## Aggregate function missing, defaulting to 'length'
```

```
##     id age      city 2010 2015
##  1:  1  43    Durban    1    1
##  2:  2  48 Cape Town    1    1
##  3:  3  45    Durban    2    1
##  4:  4  55 Cape Town    2    1
##  5:  5  57 Cape Town    1    2
##  6:  6  53  Pretoria    1    2
##  7:  7  55    Durban    2    2
##  8:  8  58 Cape Town    2    1
##  9:  9  40 Cape Town    1    1
## 10: 10  53  Pretoria    2    1
## 11: 11  31 Cape Town    1    2
## 12: 12  51    Durban    1    2
```
{{< /alert >}}

### Cast several variables each with one column per year



```r
dcast(melted, id+age+city~ year  , value.var = c("income", "capital"), fun.aggregate = sum)
```

```
##     id age      city income_2010 income_2015 capital_2010 capital_2015
##  1:  1  43    Durban        1123        1471          452          457
##  2:  2  48 Cape Town        1866        1516          134          350
##  3:  3  45    Durban        3215        1579          603          201
##  4:  4  55 Cape Town        2807        1778          478          395
##  5:  5  57 Cape Town        1816        2541          353          734
##  6:  6  53  Pretoria        1073        2926          418          466
##  7:  7  55    Durban        2023        3119          778          285
##  8:  8  58 Cape Town        3313        1310          457          323
##  9:  9  40 Cape Town        1899        1987          442          285
## 10: 10  53  Pretoria        3091        1620          457           30
## 11: 11  31 Cape Town        1543        3569          354          406
## 12: 12  51    Durban        1977        2761          220          297
```

### Cast and summarize values

Finally the following syntax using "." allows to aggregate the columns with identical start (e.g. income_2010, income_2015) while at the same time aggregating the rows with identical id+age+city.


```r
dcast(melted, id+age+city~ .  , value.var = c("income", "capital") , fun.aggregate = sum)
```

```
##     id age      city income capital
##  1:  1  43    Durban   2594     909
##  2:  2  48 Cape Town   3382     484
##  3:  3  45    Durban   4794     804
##  4:  4  55 Cape Town   4585     873
##  5:  5  57 Cape Town   4357    1087
##  6:  6  53  Pretoria   3999     884
##  7:  7  55    Durban   5142    1063
##  8:  8  58 Cape Town   4623     780
##  9:  9  40 Cape Town   3886     727
## 10: 10  53  Pretoria   4711     487
## 11: 11  31 Cape Town   5112     760
## 12: 12  51    Durban   4738     517
```
