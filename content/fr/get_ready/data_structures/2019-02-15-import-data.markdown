---
title: Importer des données
author: Damien Jourdain
date: '2020-08-20'
slug: import-data
categories:
  - R
tags: []
type: book
weight: 70
---
## Objectifs d'apprentissage

Les données que vous allez analyser proviennent généralement d'enquêtes et se présentent sous forme de tableaux. Bien que R puisse être utilisé pour saisir les données provenant de ces enquêtes, vous trouverez plus efficace de saisir les données dans un logiciel de type Excel et de les importer ensuite dans R pour l'analyse des données.  

Dans cette section, vous apprendrez comment importer et exporter des données provenant de différents formats :
  
+ [Fichier texte](#fichier-texte)
+ [Fichiers Excel (formats xls & xlsx)](#fichier-excel)
      
Il existe de nombreux autres formats qui peuvent être importés. 
      
Si vous disposez d'autres types de données (provenant par exemple d'autres logiciels statistiques tels que Stata), vous pouvez soit trouver le paquet adéquat pour importer les données (en naviguant sur le web, vous trouverez rapidement celui qui sera le plus adéquat pour le faire), soit transformer vos données en format texte ou excel et utiliser les méthodes fournies ici.
    
## Importer des données à partir d'un fichier texte {#fichier-texte}
    
Les fichiers texte peuvent facilement être importés à condition que les différentes colonnes soient séparées par un séparateur commun. Le séparateur peut être une virgule, une demi-colonne ou même une tabulation.
    
Voici un exemple d'information délimitée par des virgules.


```
## "id","weight","age", "village"
## 1,72.12,48, vilA
## 2,59.62,33, vilB
## 3,71.44,46, vilA
## 4,70.50,27, vilC
## 5,67.51,45, vilB
```


Pour importer ces données, vous avez de nombreuses solutions sous la main. J'en présente une ici qui me semble très facile d'accès. 

Notez cependant qu'il existe de nombreuses autres façons d'importer des données et n'hésitez pas à explorer le web pour trouver la solution qui répond le mieux à vos besoins.

### Utiliser les fonctions du paquet `readr` 

Si vous ne l'avez pas encore fait, installez le paquet `readr`

```r
install.packages("readr")
```
    
Et chargez le:

```r
library(readr)
```
    
Pour lire un ensemble de données avec `readr`, vous combinez deux objets : 
      
+ une fonction qui analyse l'ensemble du fichier et, 
+ une spécification de colonne. La spécification de colonne décrit comment chaque colonne doit être convertie d'un vecteur de caractères au type de données le plus approprié. 
    
Dans la plupart des cas, la spécification de colonne n'est pas nécessaire car `readr` la devinera pour vous automatiquement.

Le paquet `readr` permet d'importer directement sept formats de fichiers avec sept fonctions `read_xxx()` :

+ read_csv() : fichiers séparés par des virgules (CSV)
+ read_tsv() : fichiers séparés par des tabulations
+ read_delim() : fichiers généraux délimités
+ read_fwf() : fichiers à largeur fixe
+ read_table() : fichiers tabulaires où les colonnes sont séparées par des espaces.
+ read_log() : fichiers journaux du web

Par exemple, pour importer les données de mydata.csv, vous pouvez utiliser la fonction read_csv() comme suit :


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

Notes : 

+ Les données sont importées sous forme de tibble
+ Après avoir analysé le fichier texte, il indique également le nom et le type de données qui ont été sélectionnées pour chaque colonne. 
+ La colonne "village" n'a pas été transformée en facteur, et il n'y a pas de noms de lignes. 

{{% alert note %}}

Certains paquets nécessitent l'utilisation d'un data.frame et pas d'un tibble. Dans ce cas, vous pouvez toujours convertir 
le tibble en data.frame. Pour cela, vous pouvez utiliser la commande data.frame():
      

```r
ans_df <- data.frame(ans)
str(ans_df) ## ans_df est maintenant un R data.frame natif
```

```
## 'data.frame':	6 obs. of  4 variables:
##  $ id     : num  1 2 3 4 5 6
##  $ weight : num  72.1 59.6 71.4 70.5 67.5 ...
##  $ age    : num  48 33 46 27 45 26
##  $ village: chr  "vilA" "vilB" "vilA" "vilC" ...
```
    
{{% /alert %}}
    


## Importer des données d'un fichier Excel {#fichier-excel}

Là encore, plusieurs solutions sont possibles. Pour ce cours, je suggère d'utiliser le paquet `readxl`. Il permet d'importer des fichiers qui ont le format .xls ou .xlsx. 

Comme d'habitude, si vous ne l'avez pas fait, vous devez d'abord installer le paquet sur votre ordinateur :

```r
install.packages("readxl")
```

Et le charger:

```r
library(readxl)
```

Pour tester cette fonction, vous devez d'abord télécharger le fichier datasets.xls
[Clicker ici pour télécharger le fichier de données](/files/datasets.xlsx). 

{{% alert warning %}}

Enregistrez le fichier à un endroit où vous pourrez le récupérer facilement, car vous **devrez vous souvenir du chemin complet pour atteindre ce fichier afin de l'importer.**

{{% /alert %}}

Vous pouvez le faire avec n'importe quel fichier Excel que vous avez sur votre ordinateur. Nous utiliserons ici le fichier datasets.xlsx que vous venez de télécharger. Vous devrez indiquer le chemin exact de votre fichier, et le nom exact du fichier (y compris son extension).


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

Notes : 

+ On obtient un tibble. 
+ Les colonnes de chaînes de caractères ne sont pas automatiquement transformées en facteurs
+ Sauf indication contraire, il lira la première feuille de travail  

Pour identifier les fiches de travail disponibles :

```r
excel_sheets("datasets.xlsx")
```

```
## [1] "iris"     "mtcars"   "chickwts" "quakes"
```

Vous pouvez selectionner la feuille que vous voulez importer:

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

Vous disposez de nombreuses options pour importer des sections de données spécifiques. 
Par exemple, si vous voulez lire des lignes spécifiques, vous pouvez utiliser:


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


