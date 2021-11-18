---
title: data.table principles
author: Damien Jourdain
date: '2020-08-20'
slug: dt-principles
categories:
  - R
tags: []

type: book
weight: 10
---

In contrast to a data.frame, you can do a lot more than just subsetting rows and selecting columns within a data.table, i.e., within [ ... ]. The general form of data.table syntax is of the form:

`DT[i, j, by]`

The way to read it (out loud) is: 

+ Take DT
+ subset/reorder rows using i
+ then calculate j, grouped by by 

There is a large set of possibilities to act upon your data set that include:

+ subsettting the data you want to see or manage
+ combining different data sets  
+ summarizing the data available

In addition, the package allow to perform some additional manipulations such as

+ merging two different tables
+ reshaping the tables 

We can learn progressively these functions using the data.table help and vignettes. In this course I will present the functions that you will be using to manipulate our data.



