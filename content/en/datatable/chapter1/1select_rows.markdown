---
title: Select Rows
linktitle: Select Rows
type: book
date: "2021-02-02T00:00:00+01:00"

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 20
---




## Learning objectives

Often when you want to understand your data or exclude some individuals that are outside the scope of the analysis you want to conduct, you will need to select subsamples of your data set.

In this section, you will learn how to take a subset of a data frame. 

At the end of the section, you should be able to select specific rows of a data set that will be selected by their row number, a logical criteria based on the different variables describing the rows, or randomly.  

## Converting the data into a data.table object

You will will convert the gapminder tibble into a data.table object; at the same time, I will give this new object a shorter name!

```r
DT <- data.table(gapminder)
```

In order to visualize better the effects of the commands you will apply, you will add a row_no variable to the data set. For the moment, you will do it using the standard syntax:


```r
DT$row_id <- 1:nrow(DT)
DT
```

```
##           country continent year lifeExp      pop gdpPercap row_id
##    1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##    2: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
##    3: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
##    4: Afghanistan      Asia 1967  34.020 11537966  836.1971      4
##    5: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
##   ---                                                             
## 1700:    Zimbabwe    Africa 1987  62.351  9216418  706.1573   1700
## 1701:    Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 1702:    Zimbabwe    Africa 1997  46.809 11404948  792.4500   1702
## 1703:    Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
## 1704:    Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
```

## Selecting by row numbers

A first way to select the rows you want to work with is to specify a vector of row numbers. 

Contrary to data.frame, if selecting the rows is the only operation you want to perform, there is no need to put a comma after the range of numbers. However, including a comma will also work. Personally, I usually keep the comma, because it reminds me that I am working on the part `i`, and for compatibility with the data.frame.


```
##        country continent year lifeExp      pop gdpPercap row_id
## 1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
## 2: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
## 3: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
## 4: Afghanistan      Asia 1967  34.020 11537966  836.1971      4
```

```
##        country continent year lifeExp      pop gdpPercap row_id
## 1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
## 2: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
## 3: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
```

### Exercise 1: Select odd rows

Show only the odd rows of the data set DT. 

Tip: Since you have 1704 rows, I am not asking you to key in all the odd numbers between 1 and 1704 ! Instead find the right function to generate that sequence

{{< spoiler text="Click to see the solution" >}} 


```r
# create a sequence of odd number 
oddrows <- seq(from= 1, to = nrow(DT) , by=2, )
DT[oddrows, ]
```

```
##          country continent year lifeExp      pop gdpPercap row_id
##   1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##   2: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
##   3: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
##   4: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
##   5: Afghanistan      Asia 1992  41.674 16317921  649.3414      9
##  ---                                                             
## 848:    Zimbabwe    Africa 1962  52.358  4277736  527.2722   1695
## 849:    Zimbabwe    Africa 1972  55.635  5861135  799.3622   1697
## 850:    Zimbabwe    Africa 1982  60.363  7636524  788.8550   1699
## 851:    Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 852:    Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
```

{{< /spoiler >}}

### Exercise 2:

Compare the results of DT[c(1,4, 5), ] and DT[c(1,5,4)]



## Eliminating some rows

Sometimes, it will make more sense to eliminate a few rows. To do this, you can put a `-` sign in front of the range or the selection of rows. Make sure you use parenthesis around the range.


```r
DT[-(1:30), ]  #eliminates the first 30 rows
```

```
##        country continent year lifeExp      pop gdpPercap row_id
##    1:  Algeria    Africa 1982  61.368 20033753 5745.1602     31
##    2:  Algeria    Africa 1987  65.799 23254956 5681.3585     32
##    3:  Algeria    Africa 1992  67.744 26298373 5023.2166     33
##    4:  Algeria    Africa 1997  69.152 29072015 4797.2951     34
##    5:  Algeria    Africa 2002  70.994 31287142 5288.0404     35
##   ---                                                          
## 1670: Zimbabwe    Africa 1987  62.351  9216418  706.1573   1700
## 1671: Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 1672: Zimbabwe    Africa 1997  46.809 11404948  792.4500   1702
## 1673: Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
## 1674: Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
```

## Taking a random sub-sample of rows

Sometimes, you just want to take a random sub-sample of your data. To do this, you can take advantage of the function `sample()`.

The following command will select five random rows out of the existing 1704. 



```r
set.seed(1234567)   # the seed is used to make sure we have the same sample selection
DT[sample(1:nrow(DT), 5, replace=FALSE) , ]
```

```
##     country continent year lifeExp      pop  gdpPercap row_id
## 1: Ethiopia    Africa 1967  42.115 27860297   516.1186    508
## 2:   Greece    Europe 1957  67.860  8096218  4916.2999    590
## 3:   Norway    Europe 1987  75.890  4186147 31540.9748   1148
## 4:     Iraq      Asia 1992  59.461 17861905  3745.6407    741
## 5: Zimbabwe    Africa 1972  55.635  5861135   799.3622   1697
```


*Note:* The command `sample(1:nrow(DT), 5, replace=FALSE)` will create a vector of five random numbers between 1 and the number of rows. So technically, you are generating a sequence of row numbers that will be used to select the rows to retain. 


### Exercise 3

1. Create a new data.table including the first 10 rows and name it `subDT`
2. Generate a subsample of `subDT` with 20 rows  (tip: understand what the argument replace is doing)

{{< spoiler text="Click to see the solution" >}} 


```r
# create a sequence of odd number 
subDT <- DT[1:10, ]
subDT[sample(1:nrow(subDT), 20, replace = TRUE)]
```

```
##         country continent year lifeExp      pop gdpPercap row_id
##  1: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
##  2: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
##  3: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
##  4: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##  5: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
##  6: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
##  7: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
##  8: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
##  9: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
## 10: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
## 11: Afghanistan      Asia 1987  40.822 13867957  852.3959      8
## 12: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
## 13: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
## 14: Afghanistan      Asia 1987  40.822 13867957  852.3959      8
## 15: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
## 16: Afghanistan      Asia 1982  39.854 12881816  978.0114      7
## 17: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
## 18: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
## 19: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
## 20: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
```
{{< /spoiler >}}


## Selecting rows based on a logical criterion

Let say, you want to look only at South Africa data. To do this, you will include a logical condition in the frame [...]. Only rows for which the condition is met will be selected.



```r
DT[country == "South Africa",]
```

```
##          country continent year lifeExp      pop gdpPercap row_id
##  1: South Africa    Africa 1952  45.009 14264935  4725.296   1405
##  2: South Africa    Africa 1957  47.985 16151549  5487.104   1406
##  3: South Africa    Africa 1962  49.951 18356657  5768.730   1407
##  4: South Africa    Africa 1967  51.927 20997321  7114.478   1408
##  5: South Africa    Africa 1972  53.696 23935810  7765.963   1409
##  6: South Africa    Africa 1977  55.527 27129932  8028.651   1410
##  7: South Africa    Africa 1982  58.161 31140029  8568.266   1411
##  8: South Africa    Africa 1987  60.834 35933379  7825.823   1412
##  9: South Africa    Africa 1992  61.888 39964159  7225.069   1413
## 10: South Africa    Africa 1997  60.236 42835005  7479.188   1414
## 11: South Africa    Africa 2002  53.365 44433622  7710.946   1415
## 12: South Africa    Africa 2007  49.339 43997828  9269.658   1416
```

Note that: 
+ An important feature of `data.table` is that within the frame of a data.table, columns can be referred to *as if they are variables*. Therefore, we simply refer to `country` as if it is a variable. We do not need to add the prefix `DT$` each time. Nevertheless, using `DT$city` would also work.

+ Only the rows that satisfy the condition `country == "South Africa"` are selected. Since there is nothing else left to do (the `j` part is empty), all columns from DT at rows corresponding to those row indices are returned as a data.table.

+ A comma after the condition is not required. Again, `DT[country == "South Africa" ]` would also work. 

### Exercise 4:

+ Select records from South Africa for years after 1995

{{< spoiler text="Click to see the solution" >}} 


```r
DT[country == "South Africa" & year > 1995, ]
```

```
##         country continent year lifeExp      pop gdpPercap row_id
## 1: South Africa    Africa 1997  60.236 42835005  7479.188   1414
## 2: South Africa    Africa 2002  53.365 44433622  7710.946   1415
## 3: South Africa    Africa 2007  49.339 43997828  9269.658   1416
```
{{< /spoiler >}}


## Advanced topic: using keys

In this section, we will look at another way of subsetting data.tables using keys.
Contrary to data.frame, data.table never use row names. Instead, in data.table you can set and use **keys**.

### Set, get and use keys on a data.table

#### Set a column as key in a data.table

To set a key, you can use the function `setkey()`. The function uses at least two arguments. The first argument is the name of the data.table. The second argument is the name of a column (column names are not quoted).


```r
setkey(DT, country) 
DT
```

```
##           country continent year lifeExp      pop gdpPercap row_id
##    1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##    2: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
##    3: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
##    4: Afghanistan      Asia 1967  34.020 11537966  836.1971      4
##    5: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
##   ---                                                             
## 1700:    Zimbabwe    Africa 1987  62.351  9216418  706.1573   1700
## 1701:    Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 1702:    Zimbabwe    Africa 1997  46.809 11404948  792.4500   1702
## 1703:    Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
## 1704:    Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
```

Note that:

+ you did not have to assign the result back to a variable. The function returns the result invisibly.

+ The data.table is now sorted by the column you provided - country. 

Once a key is established, you can use the key to subset all rows where the country matches “South Africa”


```r
DT["South Africa"]  
```

```
##          country continent year lifeExp      pop gdpPercap row_id
##  1: South Africa    Africa 1952  45.009 14264935  4725.296   1405
##  2: South Africa    Africa 1957  47.985 16151549  5487.104   1406
##  3: South Africa    Africa 1962  49.951 18356657  5768.730   1407
##  4: South Africa    Africa 1967  51.927 20997321  7114.478   1408
##  5: South Africa    Africa 1972  53.696 23935810  7765.963   1409
##  6: South Africa    Africa 1977  55.527 27129932  8028.651   1410
##  7: South Africa    Africa 1982  58.161 31140029  8568.266   1411
##  8: South Africa    Africa 1987  60.834 35933379  7825.823   1412
##  9: South Africa    Africa 1992  61.888 39964159  7225.069   1413
## 10: South Africa    Africa 1997  60.236 42835005  7479.188   1414
## 11: South Africa    Africa 2002  53.365 44433622  7710.946   1415
## 12: South Africa    Africa 2007  49.339 43997828  9269.658   1416
```

Note: 

+ You enter directly the names of the city you want to subset on. This is because a key exists already.
+ The main purpose of setting up a key is not to simplify the syntax, but is related to speed. Although you will not see the difference with our very small data.table, the subsetting will be much faster with a key.

Indeed, you can enter a vector of country names that you want to subset on:


```r
DT[c( "Zimbabwe", "Mozambique")]  
```

```
##        country continent year lifeExp      pop gdpPercap row_id
##  1:   Zimbabwe    Africa 1952  48.451  3080907  406.8841   1693
##  2:   Zimbabwe    Africa 1957  50.469  3646340  518.7643   1694
##  3:   Zimbabwe    Africa 1962  52.358  4277736  527.2722   1695
##  4:   Zimbabwe    Africa 1967  53.995  4995432  569.7951   1696
##  5:   Zimbabwe    Africa 1972  55.635  5861135  799.3622   1697
##  6:   Zimbabwe    Africa 1977  57.674  6642107  685.5877   1698
##  7:   Zimbabwe    Africa 1982  60.363  7636524  788.8550   1699
##  8:   Zimbabwe    Africa 1987  62.351  9216418  706.1573   1700
##  9:   Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 10:   Zimbabwe    Africa 1997  46.809 11404948  792.4500   1702
## 11:   Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
## 12:   Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
## 13: Mozambique    Africa 1952  31.286  6446316  468.5260   1033
## 14: Mozambique    Africa 1957  33.779  7038035  495.5868   1034
## 15: Mozambique    Africa 1962  36.161  7788944  556.6864   1035
## 16: Mozambique    Africa 1967  38.113  8680909  566.6692   1036
## 17: Mozambique    Africa 1972  40.328  9809596  724.9178   1037
## 18: Mozambique    Africa 1977  42.495 11127868  502.3197   1038
## 19: Mozambique    Africa 1982  42.795 12587223  462.2114   1039
## 20: Mozambique    Africa 1987  42.861 12891952  389.8762   1040
## 21: Mozambique    Africa 1992  44.284 13160731  410.8968   1041
## 22: Mozambique    Africa 1997  46.344 16603334  472.3461   1042
## 23: Mozambique    Africa 2002  44.026 18473780  633.6179   1043
## 24: Mozambique    Africa 2007  42.082 19951656  823.6856   1044
##        country continent year lifeExp      pop gdpPercap row_id
```

##### Exercice 5

+ Check the difference between `DT[c( "Zimbabawe", "Mozambique")]` and `DT[c("Mozambique", "Zimbabwe")]`  


#### Set several columns as key in a data.table


```r
setkey(DT, year, country)
DT
```

```
##                  country continent year lifeExp      pop gdpPercap row_id
##    1:        Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##    2:            Albania    Europe 1952  55.230  1282697 1601.0561     13
##    3:            Algeria    Africa 1952  43.077  9279525 2449.0082     25
##    4:             Angola    Africa 1952  30.015  4232095 3520.6103     37
##    5:          Argentina  Americas 1952  62.485 17876956 5911.3151     49
##   ---                                                                    
## 1700:            Vietnam      Asia 2007  74.249 85262356 2441.5764   1656
## 1701: West Bank and Gaza      Asia 2007  73.422  4018332 3025.3498   1668
## 1702:        Yemen, Rep.      Asia 2007  62.698 22211743 2280.7699   1680
## 1703:             Zambia    Africa 2007  42.384 11746035 1271.2116   1692
## 1704:           Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
```

They key will sort the data.table first by the column `year` and then by  `country`.
Once the key is established, you can again subset the data.table using the key


```r
DT[list(2002, "Mozambique")]
```

```
##       country continent year lifeExp      pop gdpPercap row_id
## 1: Mozambique    Africa 2002  44.026 18473780  633.6179   1043
```

*How does this work*: 2002 is first matched against the first key column year. And within those matching rows, “Mozambique” is matched against the second key column `country` to obtain row indices where both  `year` and `country` match the given values.

Again the main purpose of the key is speed when you have a large data.table. 



Note that 

+ the keys have to be provided as a list
+ another way to declare a list within the data.table braces is `.( )`

So you can obtain the same results if you write:


```r
DT[.(2002, "Mozambique")]
```

```
##       country continent year lifeExp      pop gdpPercap row_id
## 1: Mozambique    Africa 2002  44.026 18473780  633.6179   1043
```

Note that the different columns do not need to be of the same types


Although the key is built upon two columns, you can search on only one colum. When you search on the first column, just mention filter conditions for the first column (do not use commas here)


```r
setkey(DT, year, country)
DT[.(2002)]
```

```
##                 country continent year lifeExp      pop gdpPercap row_id
##   1:        Afghanistan      Asia 2002  42.129 25268405  726.7341     11
##   2:            Albania    Europe 2002  75.651  3508512 4604.2117     23
##   3:            Algeria    Africa 2002  70.994 31287142 5288.0404     35
##   4:             Angola    Africa 2002  41.003 10866106 2773.2873     47
##   5:          Argentina  Americas 2002  74.340 38331121 8797.6407     59
##  ---                                                                    
## 138:            Vietnam      Asia 2002  73.017 80908147 1764.4567   1655
## 139: West Bank and Gaza      Asia 2002  72.370  3389578 4515.4876   1667
## 140:        Yemen, Rep.      Asia 2002  60.308 18701257 2234.8208   1679
## 141:             Zambia    Africa 2002  39.193 10595811 1071.6139   1691
## 142:           Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
```

```r
DT[.(c(1997,2002))]
```

```
##                 country continent year lifeExp      pop  gdpPercap row_id
##   1:        Afghanistan      Asia 1997  41.763 22227415   635.3414     10
##   2:            Albania    Europe 1997  72.950  3428038  3193.0546     22
##   3:            Algeria    Africa 1997  69.152 29072015  4797.2951     34
##   4:             Angola    Africa 1997  40.963  9875024  2277.1409     46
##   5:          Argentina  Americas 1997  73.275 36203463 10967.2820     58
##  ---                                                                     
## 280:            Vietnam      Asia 2002  73.017 80908147  1764.4567   1655
## 281: West Bank and Gaza      Asia 2002  72.370  3389578  4515.4876   1667
## 282:        Yemen, Rep.      Asia 2002  60.308 18701257  2234.8208   1679
## 283:             Zambia    Africa 2002  39.193 10595811  1071.6139   1691
## 284:           Zimbabwe    Africa 2002  39.989 11926563   672.0386   1703
```

When you search on the second column, it is a bit trickier, since you cannot omit the first argument. A way around is then to use the function unique to identify all the cities mentioned in the column `city`.


```r
DT[.(unique(year), "South Africa")]
```

```
##          country continent year lifeExp      pop gdpPercap row_id
##  1: South Africa    Africa 1952  45.009 14264935  4725.296   1405
##  2: South Africa    Africa 1957  47.985 16151549  5487.104   1406
##  3: South Africa    Africa 1962  49.951 18356657  5768.730   1407
##  4: South Africa    Africa 1967  51.927 20997321  7114.478   1408
##  5: South Africa    Africa 1972  53.696 23935810  7765.963   1409
##  6: South Africa    Africa 1977  55.527 27129932  8028.651   1410
##  7: South Africa    Africa 1982  58.161 31140029  8568.266   1411
##  8: South Africa    Africa 1987  60.834 35933379  7825.823   1412
##  9: South Africa    Africa 1992  61.888 39964159  7225.069   1413
## 10: South Africa    Africa 1997  60.236 42835005  7479.188   1414
## 11: South Africa    Africa 2002  53.365 44433622  7710.946   1415
## 12: South Africa    Africa 2007  49.339 43997828  9269.658   1416
```

Not that sometimes, the combinations you are subsetting will not exist in the data.table

```r
DT[.(c(1997,2000), "South Africa")]
```

```
##         country continent year lifeExp      pop gdpPercap row_id
## 1: South Africa    Africa 1997  60.236 42835005  7479.188   1414
## 2: South Africa      <NA> 2000      NA       NA        NA     NA
```

You can actually choose if queries that do not match should return NA or be skipped altogether using the nomatch argument.


```r
DT[.(c(1997,2000), "South Africa"), nomatch = FALSE]
```

```
##         country continent year lifeExp      pop gdpPercap row_id
## 1: South Africa    Africa 1997  60.236 42835005  7479.188   1414
```

#### What is the current key?


```r
setkey(DT, "country")
key(DT)
```

```
## [1] "country"
```

```r
setkey(DT, "country", "year")
key(DT)
```

```
## [1] "country" "year"
```


#### Eliminate a key


```r
setkey(DT, NULL)
key(DT)
```

```
## NULL
```

## Advanced topics: Secondary indices

### Why do we need secondary indices ?

When using the `setkey()` command, behind the scene, you are computing the order vector for the column(s) provided and then you are reordering the entire data.table based on the order vector computed. Although this process has been optimized, this reordering can be expensive (especially with a large number of rows) and is not always the best strategy; 

In particular, unless your task involves **repeated subsetting on the same column**, fast key based subsetting could effectively be nullified by the time to reorder, depending on your data.table dimensions. 

For example, let say you want to subset on `country` then on `year`, then on `country`, and you want to use keys, you will need to :

1. calculate the order vector on country (fast)
2. reorder the data.table (slow)
3. subset using country key (super-fast)
4. calculate the order vector on year (fast)
5. reorder the data.table (slow)
6. subset using previous key (super-fast)
7. calculate the order vector on country (fast, but you have to do it again, since there is only one key at a time)
8. reorder the data.table (slow)
9. subset using country key (super-fast)

You can see that having to re-order the vector before subsetting is a wasteful under this scenario. 

When the subsetting is not always based on the same column, you are looking for a process that would not have to reorder your data.table everytime you want to subset on a new column, and you might want to keep "orderings" that was already done earlier step (in our case, you may want to keep to ordering vectors one on `city` and the other one on `previous` and use them when needed. Under this new scenario, you would:

1. calculate the order vector on country (fast)
2. subset using the ordering on country  (fast)
3. calculate the order vector on year (fast)
4. subset using year key (fast)
5. subset using country key (fast, and you do not have to recalculate the key)
...

This is what secondary indices are doing. 

Secondary indices are similar to keys in data.table, except for two major differences:

+ They only compute the order for the set of columns provided and stores that order vector in an additional attribute called index. 
+ There can be more than one secondary index for a data.table 

With these two differences, although they might not be as fast as keys in subsetting, your subsetting tasks might be faster when you need subset on different columns at different point of time of your research.

### Creating secondary indices

#### Explicit index creation

First you can create secondary indices using the command `setindex()`;


```r
setindex(DT, country)
head(DT)
```

```
##        country continent year lifeExp      pop gdpPercap row_id
## 1: Afghanistan      Asia 1952  28.801  8425333  779.4453      1
## 2: Afghanistan      Asia 1957  30.332  9240934  820.8530      2
## 3: Afghanistan      Asia 1962  31.997 10267083  853.1007      3
## 4: Afghanistan      Asia 1967  34.020 11537966  836.1971      4
## 5: Afghanistan      Asia 1972  36.088 13079460  739.9811      5
## 6: Afghanistan      Asia 1977  38.438 14880372  786.1134      6
```

Note that you do not need to save your results into a new variable. Note also that the data.table has not been reordered.
However, the index has been saved in the data.table. You can see this by either look at the structure of the data.table (for example using the `str()` command) or the command `indices()`).


```r
indices(DT)
```

```
## [1] "country"
```

```r
str(DT)
```

```
## Classes 'data.table' and 'data.frame':	1704 obs. of  7 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
##  $ row_id   : int  1 2 3 4 5 6 7 8 9 10 ...
##  - attr(*, ".internal.selfref")=<externalptr> 
##  - attr(*, "index")= int(0) 
##   ..- attr(*, "__country")= int(0)
```

#### When doing a traditional search using `==`  or `%in%`

At the moment, search using binary operators `==` and `%in%`, automatically create and save a secondary index as an attribute. 


```r
DT[country =="Zimbabwe", ]
```

```
##      country continent year lifeExp      pop gdpPercap row_id
##  1: Zimbabwe    Africa 1952  48.451  3080907  406.8841   1693
##  2: Zimbabwe    Africa 1957  50.469  3646340  518.7643   1694
##  3: Zimbabwe    Africa 1962  52.358  4277736  527.2722   1695
##  4: Zimbabwe    Africa 1967  53.995  4995432  569.7951   1696
##  5: Zimbabwe    Africa 1972  55.635  5861135  799.3622   1697
##  6: Zimbabwe    Africa 1977  57.674  6642107  685.5877   1698
##  7: Zimbabwe    Africa 1982  60.363  7636524  788.8550   1699
##  8: Zimbabwe    Africa 1987  62.351  9216418  706.1573   1700
##  9: Zimbabwe    Africa 1992  60.377 10704340  693.4208   1701
## 10: Zimbabwe    Africa 1997  46.809 11404948  792.4500   1702
## 11: Zimbabwe    Africa 2002  39.989 11926563  672.0386   1703
## 12: Zimbabwe    Africa 2007  43.487 12311143  469.7093   1704
```


```r
indices(DT)
```

```
## [1] "country"
```

Note here that although we did not create the index explicitely it has be created and added to the list of indices.

Note that auto-indexing can be disabled by setting the global argument options(datatable.auto.index = FALSE). Disabling auto indexing still allows to use indices created explicitly with setindex. You can disable indices fully by setting global argument options(datatable.use.index = FALSE). Although I do not see really a need for this !


