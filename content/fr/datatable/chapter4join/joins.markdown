---
title: "Merge tables" 
linktitle: "Merge tables" 
slug: dt-merge
date: '2021-02-19'
type: book

weight: 20
---




## The case study

Suppose you conducted a survey, during which all respondents gave some demographic informations about their households: family name, province, house_type :


```r
library(data.table)
house <- fread("https://raw.githubusercontent.com/djourd1/dataR/main/household.csv")
house
```

```
##     hh_id hh_name province house_type
##  1:     1       A      KZN          2
##  2:     3       B        L          2
##  3:     4       C       MP          1
##  4:     5       D        L          2
##  5:     6       E       WC          2
##  6:     7       F      KZN          1
##  7:     8       G        L          2
##  8:     9       H      KZN          2
##  9:    10       I        L          2
## 10:    11       J       EC          2
```

In addition, you have collected information about each members of these households. Since the number of members per households was unknown and could vary a lot, you collected the information about members in a separate table, where one line corresponds to one member. To be able to trace the household to which a person belongs, you added a column hh_id.

You can also import the hypothetical data


```r
memb <- fread("https://raw.githubusercontent.com/djourd1/dataR/main/members.csv")
memb
```

```
##     id hh_id    name no age education income
##  1:  1     1   Liesl  1  46         5   3967
##  2:  2     1  Inyoni  2  34         4   4012
##  3:  3     2   Pietr  1  66         1   6182
##  4:  4     2  Nofoto  2  36         3   2593
##  5:  5     2    Jabu  3  39         4   9366
##  6:  6     3 Justice  1  47         2   1616
##  7:  7     3     Joe  2  50         2   4148
##  8:  8     3    Jabu  3  31         2   1718
##  9:  9     3  Ulwazi  4  52         7   8164
## 10: 10     4   Pietr  1  55         2   5039
## 11: 11     4    John  2  48         5   6805
## 12: 12     5   Liesl  1  50         1   7396
## 13: 13     5    John  2  59         2   9113
## 14: 14     6 Stephen  1  31         4   1266
## 15: 15     6  Nofoto  2  29         6   1872
## 16: 16     6  Inyoni  3  66         4   6050
## 17: 17     7   Liesl  1  39         1   9916
## 18: 18     7  Nofoto  2  67         7   2018
## 19: 19     7   Anele  3  66         7   8030
## 20: 20     8   Moses  1  61         6   4720
## 21: 21     8    John  2  28         7   7070
## 22: 22     9   Moses  1  70         7   5003
## 23: 23     9  Nofoto  2  35         1   5433
## 24: 24     9  Inyoni  3  50         3   3287
## 25: 25    12   Liesl  1  47         1   1454
## 26: 26    12    John  2  27         2   4676
## 27: 27    12    Jabu  3  28         6   9253
## 28: 28    12  Ulwazi  4  28         4   7077
##     id hh_id    name no age education income
```

## Merging the two data sets

When merging the two data sets, you can imagine several situations:

1. Your focus is on individuals and you want to bring information about households as an additional information
2. Your focus is on households and you want to bring information about members as an additional information

### Focus on individuals

If your focus is on individuals, you want to pull the information available from the household in the same line. 
In order to obtain that new merged dataset, you can use the function merge. The syntax is straightforward, the first two arguments (x, y) are the datasets you want to merge, the argument "by" is the name of the column that will establish a link between the two datasets.


```r
merge(x, y, 
      by = NULL, by.x = NULL, by.y = NULL, 
      all = FALSE, all.x = all, all.y = all, 
      sort = TRUE, suffixes = c(".x", ".y"), no.dups = TRUE,
      allow.cartesian=getOption("datatable.allow.cartesian"),  # default FALSE
```

We can use the argument `by` when the link columns have the same name in both datasets. If not, you give the column names in the `by.x` and `by.y` arguments.

The use of the argument `all`, `all.x` and `all.y` will be important when:

+ there are members that are referred to one household that does not exist
+ there are households without members

In such cases, you may want to decide to include members even if they do not have a corresponding household, and include households even if they do not have members. 

#### all = TRUE  (outer join)

When you set the argument to all= TRUE, you will include: 

+ all the members, even those that do not have a corresponding household; in such case, the household columns is set to NA. Here, it is the case of members that were give an hh_id equal to 2 or 12. there are not households with id 2 or 12 in the house dataset).
+ all the households, even when they to not have members; in such case the members columns are set to NA; This is the case of households 10 and 11 that were described in the house data set, but have not recorded members in the dataset members. 

This is often referred to as an "outer join", a vocabulary used by SQL users.


```r
merge(memb, house, by="hh_id", all = TRUE)
```

```
##     hh_id id    name no age education income hh_name province house_type
##  1:     1  1   Liesl  1  46         5   3967       A      KZN          2
##  2:     1  2  Inyoni  2  34         4   4012       A      KZN          2
##  3:     2  3   Pietr  1  66         1   6182    <NA>     <NA>         NA
##  4:     2  4  Nofoto  2  36         3   2593    <NA>     <NA>         NA
##  5:     2  5    Jabu  3  39         4   9366    <NA>     <NA>         NA
##  6:     3  6 Justice  1  47         2   1616       B        L          2
##  7:     3  7     Joe  2  50         2   4148       B        L          2
##  8:     3  8    Jabu  3  31         2   1718       B        L          2
##  9:     3  9  Ulwazi  4  52         7   8164       B        L          2
## 10:     4 10   Pietr  1  55         2   5039       C       MP          1
## 11:     4 11    John  2  48         5   6805       C       MP          1
## 12:     5 12   Liesl  1  50         1   7396       D        L          2
## 13:     5 13    John  2  59         2   9113       D        L          2
## 14:     6 14 Stephen  1  31         4   1266       E       WC          2
## 15:     6 15  Nofoto  2  29         6   1872       E       WC          2
## 16:     6 16  Inyoni  3  66         4   6050       E       WC          2
## 17:     7 17   Liesl  1  39         1   9916       F      KZN          1
## 18:     7 18  Nofoto  2  67         7   2018       F      KZN          1
## 19:     7 19   Anele  3  66         7   8030       F      KZN          1
## 20:     8 20   Moses  1  61         6   4720       G        L          2
## 21:     8 21    John  2  28         7   7070       G        L          2
## 22:     9 22   Moses  1  70         7   5003       H      KZN          2
## 23:     9 23  Nofoto  2  35         1   5433       H      KZN          2
## 24:     9 24  Inyoni  3  50         3   3287       H      KZN          2
## 25:    10 NA    <NA> NA  NA        NA     NA       I        L          2
## 26:    11 NA    <NA> NA  NA        NA     NA       J       EC          2
## 27:    12 25   Liesl  1  47         1   1454    <NA>     <NA>         NA
## 28:    12 26    John  2  27         2   4676    <NA>     <NA>         NA
## 29:    12 27    Jabu  3  28         6   9253    <NA>     <NA>         NA
## 30:    12 28  Ulwazi  4  28         4   7077    <NA>     <NA>         NA
##     hh_id id    name no age education income hh_name province house_type
```

<div class="card bg-light mb-3" style="width: 100%;">
  <div class="row no-gutters">
    <div class="col-md-4">
      <img src="/media/joins/outerjoins.svg" alt="outer joins">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h6 class="card-title"> Outer joins</h6>
        <p class="card-text"> Outer joins will include all the non-matching records</p>
      </div>
    </div>
  </div>
</div>



#### all = FALSE  (inner join)

When you set the argument `all = FALSE`, you will only include the members that have a corresponding household, and the household that have members. (Note that all is set to FALSE by default).



```r
merge(memb, house, by="hh_id", all = FALSE) 
```

```
##     hh_id id    name no age education income hh_name province house_type
##  1:     1  1   Liesl  1  46         5   3967       A      KZN          2
##  2:     1  2  Inyoni  2  34         4   4012       A      KZN          2
##  3:     3  6 Justice  1  47         2   1616       B        L          2
##  4:     3  7     Joe  2  50         2   4148       B        L          2
##  5:     3  8    Jabu  3  31         2   1718       B        L          2
##  6:     3  9  Ulwazi  4  52         7   8164       B        L          2
##  7:     4 10   Pietr  1  55         2   5039       C       MP          1
##  8:     4 11    John  2  48         5   6805       C       MP          1
##  9:     5 12   Liesl  1  50         1   7396       D        L          2
## 10:     5 13    John  2  59         2   9113       D        L          2
## 11:     6 14 Stephen  1  31         4   1266       E       WC          2
## 12:     6 15  Nofoto  2  29         6   1872       E       WC          2
## 13:     6 16  Inyoni  3  66         4   6050       E       WC          2
## 14:     7 17   Liesl  1  39         1   9916       F      KZN          1
## 15:     7 18  Nofoto  2  67         7   2018       F      KZN          1
## 16:     7 19   Anele  3  66         7   8030       F      KZN          1
## 17:     8 20   Moses  1  61         6   4720       G        L          2
## 18:     8 21    John  2  28         7   7070       G        L          2
## 19:     9 22   Moses  1  70         7   5003       H      KZN          2
## 20:     9 23  Nofoto  2  35         1   5433       H      KZN          2
## 21:     9 24  Inyoni  3  50         3   3287       H      KZN          2
##     hh_id id    name no age education income hh_name province house_type
```

<div class="card bg-light mb-3" style="width: 100%;">
  <div class="row no-gutters">
    <div class="col-md-4">
      <img src="/media/joins/innerjoins.svg" alt="outer joins">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h6 class="card-title"> Inner joins</h6>
        <p class="card-text"> Inner joins only include matching records</p>
      </div>
    </div>
  </div>
</div>



#### all.x = TRUE  (left joins)

When you set the argument `all.x = TRUE`  (and do not use the argument all and all.y), you will 

+ include all the members (the X data set) even they do not have a corresponding household
+ exclude household that do not have members


```r
merge(memb, house, by="hh_id", all.x = TRUE)
```

```
##     hh_id id    name no age education income hh_name province house_type
##  1:     1  1   Liesl  1  46         5   3967       A      KZN          2
##  2:     1  2  Inyoni  2  34         4   4012       A      KZN          2
##  3:     2  3   Pietr  1  66         1   6182    <NA>     <NA>         NA
##  4:     2  4  Nofoto  2  36         3   2593    <NA>     <NA>         NA
##  5:     2  5    Jabu  3  39         4   9366    <NA>     <NA>         NA
##  6:     3  6 Justice  1  47         2   1616       B        L          2
##  7:     3  7     Joe  2  50         2   4148       B        L          2
##  8:     3  8    Jabu  3  31         2   1718       B        L          2
##  9:     3  9  Ulwazi  4  52         7   8164       B        L          2
## 10:     4 10   Pietr  1  55         2   5039       C       MP          1
## 11:     4 11    John  2  48         5   6805       C       MP          1
## 12:     5 12   Liesl  1  50         1   7396       D        L          2
## 13:     5 13    John  2  59         2   9113       D        L          2
## 14:     6 14 Stephen  1  31         4   1266       E       WC          2
## 15:     6 15  Nofoto  2  29         6   1872       E       WC          2
## 16:     6 16  Inyoni  3  66         4   6050       E       WC          2
## 17:     7 17   Liesl  1  39         1   9916       F      KZN          1
## 18:     7 18  Nofoto  2  67         7   2018       F      KZN          1
## 19:     7 19   Anele  3  66         7   8030       F      KZN          1
## 20:     8 20   Moses  1  61         6   4720       G        L          2
## 21:     8 21    John  2  28         7   7070       G        L          2
## 22:     9 22   Moses  1  70         7   5003       H      KZN          2
## 23:     9 23  Nofoto  2  35         1   5433       H      KZN          2
## 24:     9 24  Inyoni  3  50         3   3287       H      KZN          2
## 25:    12 25   Liesl  1  47         1   1454    <NA>     <NA>         NA
## 26:    12 26    John  2  27         2   4676    <NA>     <NA>         NA
## 27:    12 27    Jabu  3  28         6   9253    <NA>     <NA>         NA
## 28:    12 28  Ulwazi  4  28         4   7077    <NA>     <NA>         NA
##     hh_id id    name no age education income hh_name province house_type
```

<div class="card bg-light mb-3" style="width: 100%;">
  <div class="row no-gutters">
    <div class="col-md-4">
      <img src="/media/joins/leftjoins.svg" alt="outer joins">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h6 class="card-title"> Left joins</h6>
        <p class="card-text"> Left joins include all the records of the left table (the first one on the list, or argument x in the merge function), and the matching records of the right table (the argument y in the merge function)</p>
      </div>
    </div>
  </div>
</div>


#### all.y = TRUE (right join)

When you set the argument `all.y = TRUE`  (and do not use the arguments `all` and `all.y`), you will 

+ include all the households even the ones that do not have members
+ exclude members (the X data set) that do not have a corresponding household


```r
merge(memb, house, by="hh_id", all.y = TRUE)
```

```
##     hh_id id    name no age education income hh_name province house_type
##  1:     1  1   Liesl  1  46         5   3967       A      KZN          2
##  2:     1  2  Inyoni  2  34         4   4012       A      KZN          2
##  3:     3  6 Justice  1  47         2   1616       B        L          2
##  4:     3  7     Joe  2  50         2   4148       B        L          2
##  5:     3  8    Jabu  3  31         2   1718       B        L          2
##  6:     3  9  Ulwazi  4  52         7   8164       B        L          2
##  7:     4 10   Pietr  1  55         2   5039       C       MP          1
##  8:     4 11    John  2  48         5   6805       C       MP          1
##  9:     5 12   Liesl  1  50         1   7396       D        L          2
## 10:     5 13    John  2  59         2   9113       D        L          2
## 11:     6 14 Stephen  1  31         4   1266       E       WC          2
## 12:     6 15  Nofoto  2  29         6   1872       E       WC          2
## 13:     6 16  Inyoni  3  66         4   6050       E       WC          2
## 14:     7 17   Liesl  1  39         1   9916       F      KZN          1
## 15:     7 18  Nofoto  2  67         7   2018       F      KZN          1
## 16:     7 19   Anele  3  66         7   8030       F      KZN          1
## 17:     8 20   Moses  1  61         6   4720       G        L          2
## 18:     8 21    John  2  28         7   7070       G        L          2
## 19:     9 22   Moses  1  70         7   5003       H      KZN          2
## 20:     9 23  Nofoto  2  35         1   5433       H      KZN          2
## 21:     9 24  Inyoni  3  50         3   3287       H      KZN          2
## 22:    10 NA    <NA> NA  NA        NA     NA       I        L          2
## 23:    11 NA    <NA> NA  NA        NA     NA       J       EC          2
##     hh_id id    name no age education income hh_name province house_type
```


### Focus on households

Instead of looking at all the members, you may be interested in the households instead. 
In such case, you swap the first two arguments (think that you merge y into x, so the arguments should reflect that)

You can still use the different arguments all, all.x and all.y.
However, in our case, we will keep the default, i.e. `all = FALSE`


```
##     hh_id hh_name province house_type id    name no age education income
##  1:     1       A      KZN          2  1   Liesl  1  46         5   3967
##  2:     1       A      KZN          2  2  Inyoni  2  34         4   4012
##  3:     3       B        L          2  6 Justice  1  47         2   1616
##  4:     3       B        L          2  7     Joe  2  50         2   4148
##  5:     3       B        L          2  8    Jabu  3  31         2   1718
##  6:     3       B        L          2  9  Ulwazi  4  52         7   8164
##  7:     4       C       MP          1 10   Pietr  1  55         2   5039
##  8:     4       C       MP          1 11    John  2  48         5   6805
##  9:     5       D        L          2 12   Liesl  1  50         1   7396
## 10:     5       D        L          2 13    John  2  59         2   9113
## 11:     6       E       WC          2 14 Stephen  1  31         4   1266
## 12:     6       E       WC          2 15  Nofoto  2  29         6   1872
## 13:     6       E       WC          2 16  Inyoni  3  66         4   6050
## 14:     7       F      KZN          1 17   Liesl  1  39         1   9916
## 15:     7       F      KZN          1 18  Nofoto  2  67         7   2018
## 16:     7       F      KZN          1 19   Anele  3  66         7   8030
## 17:     8       G        L          2 20   Moses  1  61         6   4720
## 18:     8       G        L          2 21    John  2  28         7   7070
## 19:     9       H      KZN          2 22   Moses  1  70         7   5003
## 20:     9       H      KZN          2 23  Nofoto  2  35         1   5433
## 21:     9       H      KZN          2 24  Inyoni  3  50         3   3287
##     hh_id hh_name province house_type id    name no age education income
```

You see, that we have records with matching hh_id on both tables. It is pretty much the same information that if had merged house into memb, but the order of the columns is not the same.

Note that one household may span over several rows. So if you want summarized information about the members, you can use the summary function you worked with in previous sessions.

For example, if you want one row per household with an added information about mean age of household members, you can do the following:


```
##    hh_id hh_name province house_type    age_m
## 1:     1       A      KZN          2 40.00000
## 2:     3       B        L          2 45.00000
## 3:     4       C       MP          1 51.50000
## 4:     5       D        L          2 54.50000
## 5:     6       E       WC          2 42.00000
## 6:     7       F      KZN          1 57.33333
## 7:     8       G        L          2 44.50000
## 8:     9       H      KZN          2 51.66667
```

{{<alert note>}}
Note that you could do the operations in a different order:

1. Summarize information per household in the member dataset
2. Merge with the household information


```r
memb_summary  <- memb[, .(age_m =  mean(age)), by = .(hh_id)]
merge(house, memb_summary, by = "hh_id")
```

```
##    hh_id hh_name province house_type    age_m
## 1:     1       A      KZN          2 40.00000
## 2:     3       B        L          2 45.00000
## 3:     4       C       MP          1 51.50000
## 4:     5       D        L          2 54.50000
## 5:     6       E       WC          2 42.00000
## 6:     7       F      KZN          1 57.33333
## 7:     8       G        L          2 44.50000
## 8:     9       H      KZN          2 51.66667
```
{{< /alert>}}


## Inner, Outer, Left or Right Join ? 

Most of the time, you will use the inner joins. 

However, since it takes into account the only rows that match on both tables, it will potentially drop down some information available in one of the two tables. You have to check carefully the results obtained after a join to make sure you obtained what you wanted.

The last three type of joins will be more tricky to use when creating data set usable for data analysis as it potentially creates some `NA` cells that will introduce problems for many econometric packages (at least, you need to be clear about what you want to treat those `NA`). However, the left, right, and full joins are useful because they help you identify problems in your data sets: a `NA` indicates some information went missing on one of the two tables. It should trigger a question for you: is this normal ? or did I encounter some problems in the data entry (wrong ID for example).
