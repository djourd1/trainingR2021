---
title: "Binding tables" 
linktitle: "Binding tables" 
slug: binds
date: '2021-02-19'
type: book

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 10
---




## Binding rows


```r
tabA <- data.table(
  col1 = sample(letters[1:4], 3),
  col2 = sample(letters[1:4], 3)
)

tabB <- data.table(
  col1 = sample(letters[5:9], 3),
  col2 = sample(letters[5:9], 3)
)

tabC <- data.table(
  col1 = sample(letters[5:9], 3),
  col3 = sample(1:4, 3))

tabD <- data.table(
  col1 = sample(letters[5:9], 3),
  col3 = sample(1:4, 3),
  col4 = sample(5:10, 3))
```


```r
rbind(tabA, tabB)
```

```
##    col1 col2
## 1:    a    d
## 2:    b    b
## 3:    d    a
## 4:    f    f
## 5:    g    h
## 6:    i    e
```

{{< alert warning>}}
When the column names of the two tables are not identical, rbind will throw an error.


```r
rbind(tabA, tabC)
```

```
## Error in rbindlist(l, use.names, fill, idcol): Column 2 ['col3'] of item 2 is missing in item 1. Use fill=TRUE to fill with NA (NULL for list columns), or use.names=FALSE to ignore column names.
```

You can force the binding of the two tables, by adding the argument use.names=FALSE. 
However, you have to be extra careful, with what you are doing, since you are potentially binding data that are not related. 


```r
rbind(tabA, tabC, use.names=FALSE)
```

```
##    col1 col2
## 1:    a    d
## 2:    b    b
## 3:    d    a
## 4:    h    1
## 5:    g    4
## 6:    i    2
```
{{</alert>}}


{{< alert warning>}}
When the two tables to be merged do not have the same number of columns, rbind will also throw an error


```r
rbind(tabA, tabD)
```

```
## Error in rbindlist(l, use.names, fill, idcol): Item 2 has 3 columns, inconsistent with item 1 which has 2 columns. To fill missing columns use fill=TRUE.
```

You can force the binding of the two tables, by adding the argument fill = TRUE.
Some `NA` will then be created.


```r
rbind(tabA, tabD, fill=TRUE)
```

```
##    col1 col2 col3 col4
## 1:    a    d   NA   NA
## 2:    b    b   NA   NA
## 3:    d    a   NA   NA
## 4:    h <NA>    3    9
## 5:    g <NA>    1    7
## 6:    i <NA>    2    6
```
{{</alert>}}


## Binding columns
