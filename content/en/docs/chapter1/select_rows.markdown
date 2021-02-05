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


| id| age|city      |previous | ans_1| ans_2| ans_3|
|--:|---:|:---------|:--------|-----:|-----:|-----:|
|  1|  43|Cape Town |Pretoria |     2|     3|     2|
|  2|  48|Durban    |Durban   |     3|     3|     3|
|  3|  45|Pretoria  |Durban   |    NA|     3|     3|
|  4|  40|Cape Town |Pretoria |     3|     1|     2|

If the rows you want to work with are not in a continuous range, you can declare them in a more precise ways, for example, using the `c()` command to enumerate the row numbers


```r
ans <- DT[c(2, 5, 7), ]
ans
```


| id| age|city     |previous | ans_1| ans_2| ans_3|
|--:|---:|:--------|:--------|-----:|-----:|-----:|
|  2|  48|Durban   |Durban   |     3|     3|     3|
|  5|  31|Pretoria |Durban   |     2|     2|     2|
|  7|  35|Durban   |Pretoria |     1|     2|     2|

## Eliminating some rows

Sometimes, it will make more sense to eliminate a few rows. To do this, you can put a `-` sign in front of the range or the selection of rows. Make sure you use parenthesis around the range.


```r
ans <- DT[-(1:5), ]
ans
```


| id| age|city      |previous  | ans_1| ans_2| ans_3|
|--:|---:|:---------|:---------|-----:|-----:|-----:|
|  6|  40|Cape Town |Pretoria  |     3|     3|     3|
|  7|  35|Durban    |Pretoria  |     1|     2|     2|
|  8|  36|Cape Town |Cape Town |     2|     1|     1|
|  9|  39|Cape Town |Cape Town |     3|     3|     1|
| 10|  46|Durban    |Durban    |     3|     1|     2|
| 11|  37|Pretoria  |Durban    |     2|     3|     2|
| 12|  36|Pretoria  |Pretoria  |     3|     1|     1|
| 13|  35|Durban    |Durban    |     3|     3|     1|
| 14|  30|Cape Town |Durban    |     3|     1|     2|
| 15|  41|Pretoria  |Pretoria  |     2|     3|     3|


## Taking a random sub-sample of rows

Sometimes, you just want to take a random sub-sample of your data. To do this, you can take advantage of the function `sample()` and the function `nrow()`.

The following command will select three random rows out of the existing 10. 



```r
set.seed(1234567)
DT[sample(1:nrow(DT), 3, replace=FALSE) , ]
```


| id| age|city      |previous | ans_1| ans_2| ans_3|
|--:|---:|:---------|:--------|-----:|-----:|-----:|
|  1|  43|Cape Town |Pretoria |     2|     3|     2|
| 12|  36|Pretoria  |Pretoria |     3|     1|     1|
| 11|  37|Pretoria  |Durban   |     2|     3|     2|

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


| id| age|city      |previous  | ans_1| ans_2| ans_3|
|--:|---:|:---------|:---------|-----:|-----:|-----:|
|  1|  43|Cape Town |Pretoria  |     2|     3|     2|
|  4|  40|Cape Town |Pretoria  |     3|     1|     2|
|  6|  40|Cape Town |Pretoria  |     3|     3|     3|
|  8|  36|Cape Town |Cape Town |     2|     1|     1|
|  9|  39|Cape Town |Cape Town |     3|     3|     1|
| 14|  30|Cape Town |Durban    |     3|     1|     2|

Note that: 
+ An important feature of `data.table` is that within the frame of a data.table, columns can be referred to *as if they are variables*. Therefore, we simply refer to `city` as if it is a variable. We do not need to add the prefix `DT$` each time. Nevertheless, using `DT$city` would work just fine.

+ Only the rows that satisfy the condition `city=="Cape Town"` are selected. Since there is nothing else left to do (the `j` part is empty), all columns from DT at rows corresponding to those row indices are returned as a data.table.

+ A comma after the condition is not required. Again, `DT[city=="Cape Town" ]` would also work. 

## Exercise

+ Select respondants from Cape Town whose age is greater or equal to 38

## Advanced topic: using keys

In this section, we will look at another way of subsetting data.tables using keys.

Contrary to data.frames, data.tables never use row names. Instead, in data.tables you can set and use **keys**.

### Set, get and use keys on a data.table

#### Set a column as key in a data.table

To set a key, you can use the function `setkey()`. The function uses at least two arguments. The first argument is the name of the data.table. The second argument is the name of a column (column names are not quoted).


```r
setkey(DT, city) 
head(DT)
```

```
##    id age      city  previous ans_1 ans_2 ans_3
## 1:  1  43 Cape Town  Pretoria     2     3     2
## 2:  4  40 Cape Town  Pretoria     3     1     2
## 3:  6  40 Cape Town  Pretoria     3     3     3
## 4:  8  36 Cape Town Cape Town     2     1     1
## 5:  9  39 Cape Town Cape Town     3     3     1
## 6: 14  30 Cape Town    Durban     3     1     2
```

Note that:

+ you did not have to assign the result back to a variable. The function returns the result invisibly.

+ The data.table is now sorted by the column we provided - city. 

Once a key is established, you can use the key to subset all rows where the city matches “Pretoria”


```r
DT["Pretoria"]  
```

```
##    id age     city previous ans_1 ans_2 ans_3
## 1:  3  45 Pretoria   Durban    NA     3     3
## 2:  5  31 Pretoria   Durban     2     2     2
## 3: 11  37 Pretoria   Durban     2     3     2
## 4: 12  36 Pretoria Pretoria     3     1     1
## 5: 15  41 Pretoria Pretoria     2     3     3
```

Note that:

+ You enter directly the names of the city you want to subset on. This is because a key exist already.
+ The main purpose of setting up a key is not to simplify the syntax, but is related to speed. Although you will not see the difference with our very small data.table, the subsetting will be much faster with a key.

Indeed, you can enter a vector of city names that you want to subset on:


```r
DT[c( "Cape Town", "Pretoria")]  
```

```
##     id age      city  previous ans_1 ans_2 ans_3
##  1:  1  43 Cape Town  Pretoria     2     3     2
##  2:  4  40 Cape Town  Pretoria     3     1     2
##  3:  6  40 Cape Town  Pretoria     3     3     3
##  4:  8  36 Cape Town Cape Town     2     1     1
##  5:  9  39 Cape Town Cape Town     3     3     1
##  6: 14  30 Cape Town    Durban     3     1     2
##  7:  3  45  Pretoria    Durban    NA     3     3
##  8:  5  31  Pretoria    Durban     2     2     2
##  9: 11  37  Pretoria    Durban     2     3     2
## 10: 12  36  Pretoria  Pretoria     3     1     1
## 11: 15  41  Pretoria  Pretoria     2     3     3
```

Note:

+ Check the difference between `DT[c( "Cape Town", "Pretoria")]` and `DT[c("Pretoria", "Cape Town")]`  


#### Set several columns as key in a data.table


```r
setkey(DT, city, previous)
head(DT)
```

```
##    id age      city  previous ans_1 ans_2 ans_3
## 1:  8  36 Cape Town Cape Town     2     1     1
## 2:  9  39 Cape Town Cape Town     3     3     1
## 3: 14  30 Cape Town    Durban     3     1     2
## 4:  1  43 Cape Town  Pretoria     2     3     2
## 5:  4  40 Cape Town  Pretoria     3     1     2
## 6:  6  40 Cape Town  Pretoria     3     3     3
```

They key will sort the data.table first by the column `city` and then by  `previous`.

Once the key is established, you can again subset the data.table using the key


```r
DT[list("Durban", "Pretoria")]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  7  35 Durban Pretoria     1     2     2
```

*How does this work*: “Durban” is first matched against the first key column city. And within those matching rows, “Pretoria” is matched against the second key column `previous` to obtain row indices where both  `city` and `previous` match the given values.

Again the main purpose of the key is speed when you have a large data.table. 


Note that another way to declare a list within the data.table braces is `.( )`
So you can obtain the same results if you write:


```r
DT[.("Durban", "Pretoria")]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  7  35 Durban Pretoria     1     2     2
```

Note that the different columns do not need to be of the same types: city is a string, age is an integer variable. 


```r
setkey(DT, city, ans_1)
DT[.("Durban", 1)]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  7  35 Durban Pretoria     1     2     2
```

Note: Although the key is built upon two columns, you can search on only one colum

When you search on the first column, just mention filter conditions for the first column (do not use commas here)

```r
setkey(DT, city, previous)
DT[.("Durban")]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  2  48 Durban   Durban     3     3     3
## 2: 10  46 Durban   Durban     3     1     2
## 3: 13  35 Durban   Durban     3     3     1
## 4:  7  35 Durban Pretoria     1     2     2
```

```r
DT[.(c("Durban", "Pretoria"))]
```

```
##    id age     city previous ans_1 ans_2 ans_3
## 1:  2  48   Durban   Durban     3     3     3
## 2: 10  46   Durban   Durban     3     1     2
## 3: 13  35   Durban   Durban     3     3     1
## 4:  7  35   Durban Pretoria     1     2     2
## 5:  3  45 Pretoria   Durban    NA     3     3
## 6:  5  31 Pretoria   Durban     2     2     2
## 7: 11  37 Pretoria   Durban     2     3     2
## 8: 15  41 Pretoria Pretoria     2     3     3
## 9: 12  36 Pretoria Pretoria     3     1     1
```

When you search on the second column, it is a bit trickier, since you cannot omit the first argument. A way around is then to use the function unique to identify all the cities mentioned in the column `city`.


```r
DT[.(unique(city), "Durban")]
```

```
##    id age      city previous ans_1 ans_2 ans_3
## 1: 14  30 Cape Town   Durban     3     1     2
## 2:  2  48    Durban   Durban     3     3     3
## 3: 10  46    Durban   Durban     3     1     2
## 4: 13  35    Durban   Durban     3     3     1
## 5:  3  45  Pretoria   Durban    NA     3     3
## 6:  5  31  Pretoria   Durban     2     2     2
## 7: 11  37  Pretoria   Durban     2     3     2
```

Not that sometimes, the combinations you are subsetting will not exist in the data.table

```r
setkey(DT, city, ans_1)
DT[.(unique(city), 1)]
```

```
##    id age      city previous ans_1 ans_2 ans_3
## 1: NA  NA Cape Town     <NA>     1    NA    NA
## 2:  7  35    Durban Pretoria     1     2     2
## 3: NA  NA  Pretoria     <NA>     1    NA    NA
```

You can actually choose if queries that do not match should return NA or be skipped altogether using the nomatch argument.


```r
DT[.(unique(city), 1), nomatch=NULL]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  7  35 Durban Pretoria     1     2     2
```


#### What is the current key?


```r
setkey(DT, "city")
key(DT)
```

```
## [1] "city"
```

```r
setkey(DT, "city", "previous")
key(DT)
```

```
## [1] "city"     "previous"
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

### Why do we need secondary indices

When using the `setkey()` command, behind the scene, you are computing the order vector for the column(s) provided and then you are reordering the entire data.table based on the order vector computed. Although this process has been optimized, this reordering can be expensive (especially with a large number of rows) and not always the best strategy; 

In particular, unless your task involves **repeated subsetting on the same column**, fast key based subsetting could effectively be nullified by the time to reorder, depending on your data.table dimensions. 

For example, let say you want to subset on `city` then on `previous`, then on `city`, and you want to use keys, you will need to :

1. calculate the order vector on city (fast)
2. reorder the data.table (slow)
3. subset using city key (super-fast)
4. calculate the order vector on previous (fast)
5. reorder the data.table (slow)
6. subset using previous key (super-fast)
7. calculate the order vector on city (fast) (you have to do it again, since there is only one key at a time)
8. reorder the data.table (slow)
9. subset using city key (super-fast)

You can see that having to re-order the vector before subsetting is a wasteful under this scenario. 

When the subsetting is not always based on the same column, you are looking for a process that would not have to reorder your data.table everytime you want to subset on a new column, and you might want to keep "orderings" that was already done earlier step (in our case, you may want to keep to ordering vectors one on `city` and the other one on `previous` and use them when needed. Under this new scenario, you would:

1. calculate the order vector on city (fast)
2. subset using the ordering on city  (fast)
3. calculate the order vector on previous (fast)
4. subset using previous key (fast)
5. subset using city key (fast)
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
setindex(DT, previous)
head(DT)
```

```
##    id age      city  previous ans_1 ans_2 ans_3
## 1:  8  36 Cape Town Cape Town     2     1     1
## 2:  9  39 Cape Town Cape Town     3     3     1
## 3: 14  30 Cape Town    Durban     3     1     2
## 4:  1  43 Cape Town  Pretoria     2     3     2
## 5:  4  40 Cape Town  Pretoria     3     1     2
## 6:  6  40 Cape Town  Pretoria     3     3     3
```

Note that you do not need to save your results into a new variable. Note also that the data.table has not been reordered.
However, the index has been saved in the data.table. You can see this by either look at the structure of the data.table (for example using the `str()` command) or the command `indices()`).


```r
indices(DT)
```

```
## [1] "previous"
```

```r
str(DT)
```

```
## Classes 'data.table' and 'data.frame':	15 obs. of  7 variables:
##  $ id      : int  8 9 14 1 4 6 2 10 13 7 ...
##  $ age     : int  36 39 30 43 40 40 48 46 35 35 ...
##  $ city    : chr  "Cape Town" "Cape Town" "Cape Town" "Cape Town" ...
##  $ previous: chr  "Cape Town" "Cape Town" "Durban" "Pretoria" ...
##  $ ans_1   : int  2 3 3 2 3 3 3 3 3 1 ...
##  $ ans_2   : int  1 3 1 3 1 3 3 1 3 2 ...
##  $ ans_3   : int  1 1 2 2 2 3 3 2 1 2 ...
##  - attr(*, ".internal.selfref")=<externalptr> 
##  - attr(*, "index")= int(0) 
##   ..- attr(*, "__previous")= int [1:15] 1 2 3 7 8 9 11 12 13 4 ...
```

#### When doing a traditional search using `==`  or `%in%`

At the moment, search using binary operators `==` and `%in%`, automatically create and save a secondary index as an attribute. 


```r
DT[city =="Durban", ]
```

```
##    id age   city previous ans_1 ans_2 ans_3
## 1:  2  48 Durban   Durban     3     3     3
## 2: 10  46 Durban   Durban     3     1     2
## 3: 13  35 Durban   Durban     3     3     1
## 4:  7  35 Durban Pretoria     1     2     2
```


```r
indices(DT)
```

```
## [1] "previous" "city"
```
You note here that although we did not create the index explicitely it has be created and added to the list of indices.

Note that auto-indexing can be disabled by setting the global argument options(datatable.auto.index = FALSE). Disabling auto indexing still allows to use indices created explicitly with setindex. You can disable indices fully by setting global argument options(datatable.use.index = FALSE). Although I do not see really a need for this !


## Fast subsetting using `on` argument 


```r
DT[ .(c(1,2)) , on = "ans_1"]
```

```
##    id age      city  previous ans_1 ans_2 ans_3
## 1:  7  35    Durban  Pretoria     1     2     2
## 2:  8  36 Cape Town Cape Town     2     1     1
## 3:  1  43 Cape Town  Pretoria     2     3     2
## 4:  5  31  Pretoria    Durban     2     2     2
## 5: 11  37  Pretoria    Durban     2     3     2
## 6: 15  41  Pretoria  Pretoria     2     3     3
```

```r
indices(DT)
```

```
## [1] "previous" "city"
```

Notes: 

+ This statement computes the index on the fly. However, note it doesn't save the index as an attribute automatically. 
+ If we had already created a secondary index, then on would reuse it instead of (re)computing it. 

