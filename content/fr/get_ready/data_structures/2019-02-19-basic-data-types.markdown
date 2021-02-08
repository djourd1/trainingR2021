---
title: Les types de base
author: Damien Jourdain
date: '2019-02-19'
slug: basic-data-types
categories:
  - data structure
tags: []
type: book
weight: 1
---

## Objectifs d'apprentissage

Dans un exemple précédent, vous avez vu qu'il est possible de stocker des objets dans l'espace de travail R car vous avez créé des variables qui stockaient des nombres. 

En fait, R peut stocker de nombreux autres types de données. Nous les appellerons les *types de base* parce qu'ils peuvent être assemblés en structures de données plus complexes (vecteurs, tableaux, cadres de données, etc.) que vous étudierez plus tard.

Dans cette section, vous découvrirez les types de base que vous utiliserez dans la plupart de vos analyses. Il s'agit de:  

+ [Numériques (nombres réels) ](#numerique)
+ [Nombres entiers ](#entier)
+ [Logiques](#logique)
+ [Chaines de caractères](#caracteres)
+ [Facteurs](#facteurs)

## Numérique (*nombres réels*){id="numerique"}

Les nombres réels sont stockés en tant qu'objets *numériques* dans R. C'est le type de données de calcul par défaut. 

Si nous attribuons une valeur décimale à une variable $ x $ comme suit, $ x $ sera de type numérique. Notez que, même si nous attribuons un nombre entier à une variable $ y $, elle est toujours enregistrée, par défaut, comme une valeur numérique.


```r
(x <- 10.5) # attribuer une valeur décimale 
```

```
## [1] 10.5
```

```r
class(x) # imprimer le nom de la classe de x 
```

```
## [1] "numeric"
```

```r
y <- 1 
class(y)
```

```
## [1] "numeric"
```

Le fait que $ y $ n'est pas un entier peut être confirmé par la fonction "is.integer"


```r
is.integer(y) # est-ce que k est un nombre entier ? 
```

```
## [1] FALSE
```

## Nombres entiers {id="entier"}

Il existe plusieurs façons de créer des variables contenant des nombres entiers:


```r
(z <- 3L)  # declarer un nombre entier en ajoutant un suffix L
```

```
## [1] 3
```

```r
is.integer(z)
```

```
## [1] TRUE
```

```r
(z <- as.integer(3))  # utiliser la function as.integer( ) 
```

```
## [1] 3
```

```r
is.integer(z)
```

```
## [1] TRUE
```

La fonction `as.integer` va changer le type de la variable fournie en argument en nombre entier. Elle fonctionne pour des nombres réels (les numériques), mais également pour certaines autres variables (logique, certains caractères, etc.).

Testez les exemples suivants:


```r
(z <- as.integer(5.27))  # va prendre la valeur entière du numérique fourni
```

```
## [1] 5
```

```r
is.integer(z)
```

```
## [1] TRUE
```

```r
(z <- as.integer("1"))  # La valeur 1 est initialement entrée comme un caractère du fait des guillemets
```

```
## [1] 1
```

```r
is.integer(z)
```

```
## [1] TRUE
```

```r
# La transformation n'est pas toujours possible. 
# R envoie une alerte et retourne une valeur NA
(z <- as.integer("one"))  
```

```
## Warning: NAs introduced by coercion
```

```
## [1] NA
```

```r
is.integer(z)
```

```
## [1] TRUE
```


## Logiques {id="logique"}

Les valeurs logiques prennent deux valeurs; elles sont soit `TRUE`, soit `FALSE`.

On peut les créer directement:


```r
test <- TRUE
class(test)
```

```
## [1] "logical"
```


Mais elles sont généralement créées à partir d'un test logique, par ex. est-ce que deux variables sont identiques? Comme autre exemple, vous avez déjà abordé la fonction `is.integer()` qui retourne une variable logique:


```r
x <- 1 ; y <- 2 # valeurs d'échantillon 
(z <- x > y) # est x plus grand que y ? 
```

```
## [1] FALSE
```

```r
class(z)
```

```
## [1] "logical"
```

Les opérations logiques standards sont "&" (et), "|" (ou) et " !" (négation).


```r
u <- TRUE ; v <- FALSE 
u & v # u AND v 
```

```
## [1] FALSE
```

```r
u | v # u OR v 
```

```
## [1] TRUE
```

```r
!u # négation de u 
```

```
## [1] FALSE
```

Vous trouverez plus de détails et les opérations logiques correspondantes en tapant `help("&")`. 

 Enfin, il est parfois utile de faire de l'arithmétique sur des valeurs logiques. Il suffit de se rappeler que la valeur   logique "TRUE" est associée à la valeur 1, tandis que le "FALSE" est associée à la valeur 0.


```r
(as.integer(TRUE))  # est k un nombre entier ? 
```

```
## [1] 1
```

```r
TRUE + TRUE
```

```
## [1] 2
```

## Les chaines de caractères {id="caracteres"}

Dans R, les chaînes de caractères sont stockées sous forme d'objet "caractère". Les chaînes de caractères sont entourées de deux guillemets `"`. 


```r
(x <- "Ceci est une chaîne") 
```

```
## [1] "Ceci est une chaîne"
```

```r
class(x)
```

```
## [1] "character"
```

Si vous n'utilisez pas le `"`, R cherchera une variable au lieu d'une chaîne de caractères, et lancera très probablement un message d'erreur.  


```r
(x <- Ceci est une chaine) 
class(x)
```

```
## Error: <text>:1:12: unexpected symbol
## 1: (x <- Ceci est
##                ^
```


Nous pouvons convertir les objets en valeurs de caractères avec la fonction `as.character()` :

```r
(x = as.character(3.14)) 
```

```
## [1] "3.14"
```

Deux valeurs de caractères peuvent être concaténées avec la fonction `paste()`.

```r
fname = "Joe" ; lname = "Smith" 
paste(fname, lname) 
```

```
## [1] "Joe Smith"
```

Pour extraire une sous-chaîne, nous appliquons la fonction `substr()`. Voici un exemple montrant comment extraire la sous-chaîne entre les troisième et quatorzième positions d'une chaîne.

```r
substr("Marie a un petit agneau", start=3, stop=14) 
```

```
## [1] "rie a un pet"
```

Et pour remplacer la première occurrence du mot "petit" par un autre mot "grand" dans la chaîne, nous appliquons la fonction `sub()`


```r
sub ("petit", "grand", "Marie a un petit agneau.") 
```

```
## [1] "Marie a un grand agneau."
```

Notez qu'il existe de nombreuses autres fonctions et packages dédiés au traitement des chaines de caractères. 


## Factors {id = "facteurs"}

Les facteurs permettent de stocker des variables catégorielles, c'est-à-dire des variables qui prennent un nombre limité de valeurs différentes. Les variables catégorielles entrent dans les modèles statistiques différemment des variables continues, c'est pourquoi les développeurs de R ont créé un type de données spécifique pour s'assurer que les fonctions de modélisation traiteront ces données correctement. 

En pratique, les facteurs sont stockés sous la forme d'un vecteur de valeurs entières avec un ensemble correspondant de valeurs de caractères à utiliser lorsque le facteur est affiché. 

Utilisez la fonction `factor()` pour créer un facteur. Le seul argument nécessaire pour créer un facteur est un vecteur de valeurs qui sera renvoyé comme un vecteur de valeurs de facteur. Les variables numériques et les variables de caractères peuvent être transformées en facteurs, mais les niveaux d'un facteur seront toujours des valeurs de caractères. Vous pouvez voir les niveaux possibles pour un facteur grâce à la commande `levels()`.


```r
# Transformer un vecteur de caractères en facteur
data = c("a", "c", "b", "a", "a", "b")
fdata = factor(data)
fdata
```

```
## [1] a c b a a b
## Levels: a b c
```

```r
# Transformer un tableau numérique en facteur
data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata = factor(data)
fdata
```

```
##  [1] 1 2 2 3 1 2 3 3 1 2 3 3 1
## Levels: 1 2 3
```


Les niveaux d'un facteur sont utilisés lors de l'affichage des valeurs du facteur. Vous pouvez changer ces niveaux au moment où vous créez un facteur en passant un vecteur avec les nouvelles valeurs par l'argument "labels=". Notez que cela change en fait les niveaux internes du facteur, et pour changer les étiquettes d'un facteur après sa création, la forme d'assignation (`<-`) de la fonction niveaux est utilisée. 

Pour convertir les données par défaut du facteur fdata, nous utilisons le formulaire d'affectation de la fonction niveaux:


```r
data <- c(1,2,2,3,1,2,3,3,1,2,3,3,1)

#define specific labels when constructing the factor
fdata <- factor(data, labels = c("Weak", "Mild", "Strong")) 
fdata
```

```
##  [1] Weak   Mild   Mild   Strong Weak   Mild   Strong Strong Weak   Mild  
## [11] Strong Strong Weak  
## Levels: Weak Mild Strong
```

```r
#re-define labels after construction
levels(fdata) <- c('I','II','III')
fdata
```

```
##  [1] I   II  II  III I   II  III III I   II  III III I  
## Levels: I II III
```

Factors are an efficient way to store character values, because each unique character value is stored only once, and the data itself is stored as a vector of integers. 

To change the order in which the levels will be displayed from their default sorted order, the levels= argument can be given a vector of all the possible values of the variable in the order you desire. 

Consider some data consisting of the names of months:


```r
theMonths = c("March","April","January","November","January",
 "September","October","September","November","August",
 "January","November","November","February","May","August",
 "July","December","August","August","September","November",
 "February","April")
 theMonths = factor(theMonths)
```
By default, the levels will be presented using alphabetic order, which in the case of Months will make readings of results a bit difficult when summarizing information.
 
For example, the function `table()` will tell us how many times each month has appeared in our vector theMonths


```r
table(theMonths)
```

```
## theMonths
##     April    August  December  February   January      July     March       May 
##         2         4         1         2         3         1         1         1 
##  November   October September 
##         5         1         3
```
Although the months clearly have an ordering, this is not reflected in the output of the table function. 


```r
theMonths <- factor(theMonths,levels=c("January","February","March",
             "April","May","June","July","August","September",
             "October","November","December"))

table(theMonths)
```

```
## theMonths
##   January  February     March     April       May      June      July    August 
##         3         2         1         2         1         0         1         4 
## September   October  November  December 
##         3         1         5         1
```

```r
theMonths[2] > theMonths[3]
```

```
## Warning in Ops.factor(theMonths[2], theMonths[3]): '>' not meaningful for
## factors
```

```
## [1] NA
```
 
As the results of the last operation shows, the comparison operators are not supported for unordered factors. Creating an ordered factor solves this problem: 


```r
theMonths <- factor(theMonths,levels=c("January","February","March",
             "April","May","June","July","August","September",
             "October","November","December"), ordered = TRUE)

table(theMonths)
```

```
## theMonths
##   January  February     March     April       May      June      July    August 
##         3         2         1         2         1         0         1         4 
## September   October  November  December 
##         3         1         5         1
```

```r
theMonths[2] > theMonths[3]
```

```
## [1] TRUE
```

Another common way to create factors is to split a continuous variables into intervals using the `cut` function. The `breaks= argument` to cut is used to describe how ranges of numbers will be converted to factor values. If a number is provided through the `breaks= argument`, the resulting factor will be created by dividing the range of the variable into that number of equal length intervals; if a vector of values is provided, the values in the vector are used to determine the breakpoint. Note that if a vector of values is provided, the number of levels of the resultant factor will be one less than the number of values in the vector.

For example, consider the women data set, which contains height and weights for a sample of women. If we wanted to create a factor corresponding to weight, with three equally-spaced levels, we could use the following:

```r
data("women")
wfact = cut(women$height,3)
wfact
```

```
##  [1] (58,62.7]   (58,62.7]   (58,62.7]   (58,62.7]   (58,62.7]   (62.7,67.3]
##  [7] (62.7,67.3] (62.7,67.3] (62.7,67.3] (62.7,67.3] (67.3,72]   (67.3,72]  
## [13] (67.3,72]   (67.3,72]   (67.3,72]  
## Levels: (58,62.7] (62.7,67.3] (67.3,72]
```

```r
table(wfact)
```

```
## wfact
##   (58,62.7] (62.7,67.3]   (67.3,72] 
##           5           5           5
```
The `labels= argument` to cut allows you to specify the levels of the factors, instead of the intervals

```r
wfact = cut(women$height,3,labels=c('Low','Medium','High'))
table(wfact)
```

```
## wfact
##    Low Medium   High 
##      5      5      5
```




