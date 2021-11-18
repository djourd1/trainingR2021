---
title: "Wide or long format" 
linktitle: "Wide or long format" 
slug: wide-long
type: book

weight: 10
---


## Learning objectives


{{< figure library="true" src="whatLongWide.svg" >}}

In this section, you will learn to distinguish between long and wide formats;





## Wide or Long format ? 

Wide and Long formats are generic terms to express how data are stored when you have repeated measurement for one observed unit.



### Wide format
With a wide format, an object's repeated indicators over the years or a respondent's repeated answers will be in a __single row__, and each response is in a separate column. 

In the following table, the countries HDI indicators for the last nine years are reported in different columns.

It is a wide format since each row corresponds to one country, each column corresponds to a specific year where this HDI indicator was measured. 


```
##                Country  2011  2012  2013  2014  2015  2016  2017  2018  2019
## 1:         Afghanistan 0.477 0.489 0.496 0.500 0.500 0.502 0.506 0.509 0.511
## 2:             Albania 0.764 0.775 0.782 0.787 0.788 0.788 0.790 0.792 0.795
## 3:             Algeria 0.728 0.728 0.729 0.736 0.740 0.743 0.745 0.746 0.748
## 4:             Andorra 0.836 0.858 0.856 0.863 0.862 0.866 0.863 0.867 0.868
## 5:              Angola 0.533 0.544 0.555 0.565 0.572 0.578 0.582 0.582 0.581
## 6: Antigua and Barbuda 0.755 0.759 0.760 0.760 0.762 0.765 0.768 0.772 0.778
```

### Long format

With a long format, __each row correspond to one response__. So each respondent will have data in multiple rows. 

Any variables that do not change across responses will have the same value in all the rows. This leads to some repetitions, but may be useful when conducting data analysis. 


```
##         Country year   HDI
##  1: Afghanistan 2011 0.477
##  2: Afghanistan 2012 0.489
##  3: Afghanistan 2013 0.496
##  4: Afghanistan 2014 0.500
##  5: Afghanistan 2015 0.500
##  6: Afghanistan 2016 0.502
##  7: Afghanistan 2017 0.506
##  8: Afghanistan 2018 0.509
##  9: Afghanistan 2019 0.511
## 10:     Albania 2011 0.764
## 11:     Albania 2012 0.775
## 12:     Albania 2013 0.782
## 13:     Albania 2014 0.787
## 14:     Albania 2015 0.788
## 15:     Albania 2016 0.788
## 16:     Albania 2017 0.790
## 17:     Albania 2018 0.792
## 18:     Albania 2019 0.795
## 19:     Algeria 2011 0.728
## 20:     Algeria 2012 0.728
```

Depending on data analysis needs, you will have to change from one format to another. Therefore, it is important that you master the two functions to reshape data that are coming with the `data.table` package. 

The two functions are `melt` and `dcast`.
