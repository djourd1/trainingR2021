---
title: Summary over groups
linktitle: Summary over groups
slug: summary-group
type: book
date: "2021-02-02T00:00:00+01:00"

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 30
---




## Learning objectives

## Grouping using by

In our previous section we calculated the percentage of countries for which the GDP per capita was above a given threshold and for a specific year. But you might be interested how this percentage evolved over time? 

So what you need is that summary information, but summarized for each recorded years. This is where the *by* component becomes useful:


```r
DT[ , .(no_in_year = .N, percRich = sum(gdpPercap > 10000)*100/.N), by = .(year)]
```

```
##     year no_in_year  percRich
##  1: 1952        142  4.929577
##  2: 1957        142  8.450704
##  3: 1962        142 13.380282
##  4: 1967        142 15.492958
##  5: 1972        142 22.535211
##  6: 1977        142 28.873239
##  7: 1982        142 28.873239
##  8: 1987        142 28.873239
##  9: 1992        142 26.056338
## 10: 1997        142 29.577465
## 11: 2002        142 30.985915
## 12: 2007        142 38.028169
```

The figures for GDP have been adjusted for inflation. So the good news is that the proportion of countries above 10000 USD / capita is increasing over time. 

However, you might be interested in the relative positionning of countries. One of the possible measures is to count the proportion of countries that are below a value corresponding to 25% of the median GDP of all of the countries for that year.

Using chained command, you can easily obtain this kind of information:


```r
DT[ , medianGDP := median(gdpPercap), by = .(year)
    ][ , .(below25 =  sum(gdpPercap < 0.25 * medianGDP)/.N, 
           above25 =  sum(gdpPercap > 1.25 * medianGDP)/.N), by = .(year)]
```

```
##     year    below25   above25
##  1: 1952 0.09859155 0.4225352
##  2: 1957 0.09859155 0.4436620
##  3: 1962 0.09154930 0.4577465
##  4: 1967 0.09154930 0.4507042
##  5: 1972 0.15492958 0.4507042
##  6: 1977 0.17605634 0.4507042
##  7: 1982 0.21126761 0.4225352
##  8: 1987 0.20422535 0.4436620
##  9: 1992 0.21830986 0.4577465
## 10: 1997 0.22535211 0.4507042
## 11: 2002 0.23943662 0.4225352
## 12: 2007 0.22535211 0.4436620
```

You can see that the proportion of countries whose GDP/capita is below a value of 25% of the medianGDP for that year is increasing over time, while the proportion of those whose GDP is above 125% of the median GDP for that year is more stable. 

I let you conclude what this means in terms of shape of the distribution of GDP per capita among countries.


## Applying the same function to many columns

`.SD` is another special symbol that will be very useful when you want to compute the same function over many different columns.
It stands for **S**ubset of **D**ata. Internally, it is a data.table that holds the data for the current group defined using by.

Recall that a data.table is internally a list as well with all its columns of equal length.

As a first example, here is a way to select only the first row of each country (and display all the columns)

```r
DT[, first(.SD), by = country]
```

```
##                 country continent year lifeExp      pop gdpPercap row_id
##   1:        Afghanistan      Asia 1952  28.801  8425333  779.4453      1
##   2:            Albania    Europe 1952  55.230  1282697 1601.0561     13
##   3:            Algeria    Africa 1952  43.077  9279525 2449.0082     25
##   4:             Angola    Africa 1952  30.015  4232095 3520.6103     37
##   5:          Argentina  Americas 1952  62.485 17876956 5911.3151     49
##  ---                                                                    
## 138:            Vietnam      Asia 1952  40.412 26246839  605.0665   1645
## 139: West Bank and Gaza      Asia 1952  43.160  1030585 1515.5923   1657
## 140:        Yemen, Rep.      Asia 1952  32.548  4963829  781.7176   1669
## 141:             Zambia    Africa 1952  42.038  2672000 1147.3888   1681
## 142:           Zimbabwe    Africa 1952  48.451  3080907  406.8841   1693
##      medianGDP
##   1:  1968.528
##   2:  1968.528
##   3:  1968.528
##   4:  1968.528
##   5:  1968.528
##  ---          
## 138:  1968.528
## 139:  1968.528
## 140:  1968.528
## 141:  1968.528
## 142:  1968.528
```

Note that: 
+ `.SD` contains all the columns except the grouping columns by default.
+ It preserves the original column order

To compute on (multiple) columns, we can then simply use the base R function `lapply()`; Let say, you want to compute the mean GDP per capita and mean life Expectancy per continent. One way to do this is to first select the columns you want to summarize and chain command the summary function. 


```r
DT[, .(lifeExp, gdpPercap, continent)    ## Retain only the numeric variables + country
   ][, lapply(.SD,  mean), by = continent]  ## then calculate mean over all the columns (except the key)
```

```
##    continent  lifeExp gdpPercap
## 1:      Asia 60.06490  7902.150
## 2:    Europe 71.90369 14469.476
## 3:    Africa 48.86533  2193.755
## 4:  Americas 64.65874  7136.110
## 5:   Oceania 74.32621 18621.609
```

Another more efficient way is to use the argument `.SDcols`. It accepts either column names or column indices. For example, .SDcols = c("gdpPercap", "lifeExp") ensures that .SD contains only these two columns for each group.


```r
DT[, lapply(.SD,  mean), by = continent,      
        .SDcols = c("lifeExp", "gdpPercap")] ## for just those specified in .SDcols
```

```
##    continent  lifeExp gdpPercap
## 1:      Asia 60.06490  7902.150
## 2:    Europe 71.90369 14469.476
## 3:    Africa 48.86533  2193.755
## 4:  Americas 64.65874  7136.110
## 5:   Oceania 74.32621 18621.609
```

## Exercises

1.  Write a command to output the first two years for each country?

{{< spoiler text= "Click to see the solution">}}

```r
DT[, head(.SD, 2), by = continent] 
```

```
##     continent     country year lifeExp      pop  gdpPercap row_id medianGDP
##  1:      Asia Afghanistan 1952  28.801  8425333   779.4453      1  1968.528
##  2:      Asia Afghanistan 1957  30.332  9240934   820.8530      2  2173.220
##  3:    Europe     Albania 1952  55.230  1282697  1601.0561     13  1968.528
##  4:    Europe     Albania 1957  59.280  1476505  1942.2842     14  2173.220
##  5:    Africa     Algeria 1952  43.077  9279525  2449.0082     25  1968.528
##  6:    Africa     Algeria 1957  45.685 10270856  3013.9760     26  2173.220
##  7:  Americas   Argentina 1952  62.485 17876956  5911.3151     49  1968.528
##  8:  Americas   Argentina 1957  64.399 19610538  6856.8562     50  2173.220
##  9:   Oceania   Australia 1952  69.120  8691212 10039.5956     61  1968.528
## 10:   Oceania   Australia 1957  70.330  9712569 10949.6496     62  2173.220
```
{{< /spoiler>}}

2.  Write a command to output the first two countries with data per continent?

{{< spoiler text= "Click to see the solution">}}


```r
# You can use the function unique to select the unique continent - country pairs
unique(DT[, .(continent, country)])[, head(.SD, 3), by = continent] 
```

```
##     continent     country
##  1:      Asia Afghanistan
##  2:      Asia     Bahrain
##  3:      Asia  Bangladesh
##  4:    Europe     Albania
##  5:    Europe     Austria
##  6:    Europe     Belgium
##  7:    Africa     Algeria
##  8:    Africa      Angola
##  9:    Africa       Benin
## 10:  Americas   Argentina
## 11:  Americas     Bolivia
## 12:  Americas      Brazil
## 13:   Oceania   Australia
## 14:   Oceania New Zealand
```
{{< /spoiler>}}



3.  Write a command to output the mean and the median GDP per capita and population per country


{{< spoiler text= "Click to see the solution">}}


```r
DT[, unlist(lapply(.SD, function(x) list(mean = mean(x), median = median(x))), recursive  =FALSE),
   .SDcols = c("lifeExp", "gdpPercap")]
```

```
##    lifeExp.mean lifeExp.median gdpPercap.mean gdpPercap.median
## 1:     59.47444        60.7125       7215.327         3531.847
```


{{< /spoiler>}}
