---
linktitle: "Manipulate data with data.table"
summary: Manipulate 
icon: book
icon_pack: fas

type: book  # Do not modify.
---



## Introduction

In most real-life cases, data will not be ready for immediate use. Most of the time it has missing values, missing variable names, or variables scattered into multiple columns that you will need to synthesize. Therefore, you need to be able to manipulate these data. 

In the section "Getting ready", you have manipulated vectors, matrices and data.frames by reordering them and subsetting them through indexing and the operator `[ ]`. But once you start more advanced analyses, you will want to manipulate your data with more efficient tools.
{{< figure library="true" src="OIP.jpg" >}}  

To do so, you have different options. Among them, 3 environments are popular:

+ The original data.frame
+ The data.table package
+ The tidyverse ecosystem

## Learning objective

In this section, you will learn how to work with the package `data.table`

After the first chapter, you will be able to manipulate your raw data, in order to get them in the format required by the different econometric packages. This will include select the rows and columns, sort the rows, and create new columns.

After the second chapter, you will understand the concept of wide and long formats and you will be able to change to reshape your data from one format to another.

After the third chapter, you will be able to merge information scattered into different but related tables.


## The data set

In this chapter, you will work with the datasets made available by the package gapminder.
You should now be able to install the package on your own. 

Load the `gapminder` package:

```r
library(gapminder)
```

If everyting went ok you should be able to access the gapminder data directly

```r
gapminder
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


You are now ready to work!




