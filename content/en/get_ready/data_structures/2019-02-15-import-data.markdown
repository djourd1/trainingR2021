---
title: Import Data
author: Damien Jourdain
date: '2020-08-20'
slug: import-data
categories:
  - R
tags: []
type: book
weight: 70
---


## Learning objectives

The data we will analyse are usually coming from surveys and found in tabular format. Although R could be used for keying in data from these surveys, you will find it more efficient to enter data into a Excel type of software and then import the data to R for data analysis.  

In this section you will learn how to import and export data coming from different formats:

+ [Text file](#importing-data-from-a-text-file)
+ [Excel files (xls & xlsx formats)](#importing-data-from-an-excel-file)

There are many more formats that can be imported. 

If you have other types of data (e.g. coming from other statistical softwares such as Stata), you can either find the right package to import the data (by browsing the web, you will rapidly find what will be the most adequate one to do so), or you can transform your data into text or excel formats and use the methods provided here.

## Importing data from a Text File

Text files can easily be imported provided the different columns are separated by a common separator. The separator can be a comma, a semi-column, or even a tab.

Here is an example of comma delimited information.


```
## "id","weight","age", "village"
## 1,72.12,48, vilA
## 2,59.62,33, vilB
## 3,71.44,46, vilA
## 4,70.50,27, vilC
## 5,67.51,45, vilB
```

To import these data, you have at least three solutions at hand. Since we will be using the tidyverse family of packages, I will only present the related packages. Indeed there are many more ways to import data and feel free to explore the web to find-out what solution fits your needs best.

### Use functions of the `readr` package

If you haven't done so, you will first need to install the `readr` package

```r
install.packages("readr")
```

To be able to use it, we then need to load it

```r
library(readr)
```

To read a dataset with `readr` you combine two pieces: 

+ a function that parses the overall file and, 
+ a column specification. The column specification describes how each column should be converted from a character vector to the most appropriate data type. In most cases the column specification is not necessary because `readr` will guess it for you automatically.

`readr` supports seven file formats with seven read_ functions:

+    read_csv(): comma separated (CSV) files
+    read_tsv(): tab separated files
+    read_delim(): general delimited files
+    read_fwf(): fixed width files
+    read_table(): tabular files where columns are separated by white-space.
+    read_log(): web log files

For example, to import the data of mydata.csv, you can use the read_csv() function as follows:

```r
ans <- read_csv("myPath/mydata.csv")
str(ans)
```


```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   id = col_double(),
##   weight = col_double(),
##   age = col_double(),
##   village = col_character()
## )
```

```
## # A tibble: 6 x 4
##      id weight   age village
##   <dbl>  <dbl> <dbl> <chr>  
## 1     1   72.1    48 vilA   
## 2     2   59.6    33 vilB   
## 3     3   71.4    46 vilA   
## 4     4   70.5    27 vilC   
## 5     5   67.5    45 vilB   
## 6     6   67.0    26 vilD
```

Notes: 

+ It returns a tibble. 
+ After parsing the text file, it also indicates the name and type of data that was selected for each column. 
+ The village column was not transformed into a factor, and there are no row names. 

{{% alert note %}}
Some packages require the use of the original R data.frame format. In such case, you can always convert 
the tibble into R data.frames. For this, you can use the command data.frame()


```r
ans_df <- data.frame(ans)
str(ans_df) ## ans_df is now a native R data.frame
```

```
## 'data.frame':	6 obs. of  4 variables:
##  $ id     : num  1 2 3 4 5 6
##  $ weight : num  72.1 59.6 71.4 70.5 67.5 ...
##  $ age    : num  48 33 46 27 45 26
##  $ village: chr  "vilA" "vilB" "vilA" "vilC" ...
```

{{% /alert %}}


## Importing data from an Excel file

Again several solutions are available. For this course, we suggest to use the 
readxl package. `readxl` supports both the .xls and .xlsx format. 

As usual, if you haven't done so, you first need to install it on your computer:

```r
install.packages("readxl")
```
and then load it:

```r
library(readxl)
```

To test this function, you will first need to download the file datasets.xls
[download here](/files/datasets.xlsx). 

**Save the file where you can retrieve it, because you will need to remember the full path to reach that file to import it.**

You can do this with any excel file you have on your computer. Here we will use the datasets.xlsx file that you have just downloaded. You will need to give the exact path of your file, and the exact name of the file (including its extension).


```r
data <- read_excel("mypath/datasets.xlsx")
```


```
## # A tibble: 150 x 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # ... with 140 more rows
```

Notes: 

+ The output is a tibble. 

+ The string columns are not automatically transformed into factors

+ Unless otherwise specified, it will read the first worksheet  

To identify the worksheets available:

```r
excel_sheets("datasets.xlsx")
```

```
## [1] "iris"     "mtcars"   "chickwts" "quakes"
```

Then decide which sheets you want to import:

```r
read_excel("datasets.xlsx", sheet = "quakes")
```

```
## # A tibble: 1,000 x 5
##      lat  long depth   mag stations
##    <dbl> <dbl> <dbl> <dbl>    <dbl>
##  1 -20.4  182.   562   4.8       41
##  2 -20.6  181.   650   4.2       15
##  3 -26    184.    42   5.4       43
##  4 -18.0  182.   626   4.1       19
##  5 -20.4  182.   649   4         11
##  6 -19.7  184.   195   4         12
##  7 -11.7  166.    82   4.8       43
##  8 -28.1  182.   194   4.4       15
##  9 -28.7  182.   211   4.7       35
## 10 -17.5  180.   622   4.3       19
## # ... with 990 more rows
```

You have many different options to import specific data sections. 

Just as an example, if you want to read specific rows, you can use:

```r
read_excel("datasets.xlsx", range = cell_rows(1:5))
```

```
## # A tibble: 4 x 5
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##          <dbl>       <dbl>        <dbl>       <dbl> <chr>  
## 1          5.1         3.5          1.4         0.2 setosa 
## 2          4.9         3            1.4         0.2 setosa 
## 3          4.7         3.2          1.3         0.2 setosa 
## 4          4.6         3.1          1.5         0.2 setosa
```


