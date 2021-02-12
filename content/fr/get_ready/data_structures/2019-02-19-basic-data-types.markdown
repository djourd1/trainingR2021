---
title: Les types de base
author: Damien Jourdain
date: '2019-02-19'
slug: basic-data-types
categories:
  - data structure
tags: []
type: book
weight: 10
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

{{% callout note %}}
Une variable logique peut prendre les valeurs "TRUE" et "FALSE". Vous les trouverez parfois sous une forme abrégée comme  "T" et "F", respectivement. Notez cependant que "T" et "F" ne sont que des variables qui sont réglées par défaut sur TRUE et FALSE, mais ne sont pas des mots réservés et peuvent donc être écrasés par l'utilisateur. **Il est donc préférable de toujours utiliser TRUE et FALSE.**
{{% /callout %}}



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


## Des variables spéciales

R prédéfini des variables spéciales qu'il est utile de connaitre pour la définition des données manquantes et l'interpretation des résultats de certaines functions. 

### NA

NA est une valeur logique qui indique si une valeur est manquante:


```r
class(NA)
```

```
## [1] "logical"
```

### NULL

NULL represent un object null (l'objet n'existe pas !). NULL est produit par des expressions ou des functions dont la valeur est indeterminée. Au contraire de NA, ce n'est pas une valeur logique.


```r
class(NULL)
```

```
## [1] "NULL"
```

### Inf

`Inf` et `-Inf` correspondent aux valeurs infinies. Ce sont des variables numériques.

```r
1+ Inf 
```

```
## [1] Inf
```

```r
class(Inf)
```

```
## [1] "numeric"
```

### NaN
NaN est un mot réservé dans R et veut dire "Not a Number".


```r
class(NaN)
```

```
## [1] "numeric"
```

```r
# See the difference between the two expressions
3 / 0 ## = Inf a non-zero number divided by zero creates infinity
```

```
## [1] Inf
```

```r
0 / 0  ## =  NaN
```

```
## [1] NaN
```




