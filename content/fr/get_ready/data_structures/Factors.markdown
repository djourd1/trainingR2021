---
title: Les facteurs
author: Damien Jourdain
date: '2021-02-09'
slug: factors
categories:
  - data structure
tags: []
type: book
weight: 30
---

## Objectifs d'apprentissage

Les facteurs permettent de stocker des variables catégorielles, c'est-à-dire des variables qui prennent un nombre limité de valeurs différentes. Les variables catégorielles entrent dans les modèles statistiques différemment des variables continues, c'est pourquoi les développeurs de R ont créé un type de données spécifique pour s'assurer que les fonctions de modélisation traiteront ces données correctement. 

Vous apprendrez ici à créer et manipuler les facteurs. 

## Les facteurs {id = "facteurs"}



En pratique, les facteurs sont stockés sous la forme d'un vecteur de valeurs entières avec un ensemble correspondant de valeurs de caractères à utiliser lorsque le facteur est affiché (pensez à un dictionnaire).

### Transformation d'un vecteur 

Utilisez la fonction `factor()` pour créer un facteur. Le seul argument indispensable pour créer un facteur est un vecteur de valeurs. Les variables numériques et les variables de caractères peuvent être transformées en facteurs, mais les niveaux d'un facteur seront toujours des valeurs de caractères. Vous pouvez voir les niveaux possibles d'un facteur grâce à la commande `levels()`.


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


### Définir les niveaux

Les niveaux d'un facteur sont utilisés lors de l'affichage des valeurs du facteur. Vous pouvez changer ces niveaux au moment où vous créez un facteur en passant un vecteur avec les nouvelles valeurs par l'argument `labels= `. Notez que cela change en fait les niveaux internes du facteur, et pour changer les étiquettes d'un facteur après sa création, la forme d'assignation (`<-`) de la fonction niveaux est utilisée. 

Pour convertir les données par défaut du facteur fdata, utilisez l'argument `labels = `


```r
data <- c(1,2,2,3,1,2,3,3,1,2,3,3,1)

#Definition des labels lors de la construction du facteur
fdata <- factor(data, labels = c("Weak", "Mild", "Strong")) 
fdata
```

```
##  [1] Weak   Mild   Mild   Strong Weak   Mild   Strong Strong Weak   Mild  
## [11] Strong Strong Weak  
## Levels: Weak Mild Strong
```

```r
#Redéfinition des labels après la construction
levels(fdata) <- c('I','II','III')
fdata
```

```
##  [1] I   II  II  III I   II  III III I   II  III III I  
## Levels: I II III
```

Les facteurs sont un moyen efficace de stocker des valeurs de caractères, car chaque chaine de caractère unique n'est stockée qu'une seule fois, et les données elles-mêmes sont stockées sous forme de vecteur d'entiers. 

Pour modifier l'ordre dans lequel les niveaux seront affichés par rapport à leur ordre de tri par défaut, l'argument `levels=` doit recevoir un vecteur de toutes les valeurs possibles de la variable dans l'ordre souhaité. 

Considérons quelques données constituées des noms de mois :


```r
lesMois <- c("Mars", "Avril", "Janvier", "Novembre", "Janvier",
 "Septembre", "Octobre", "Septembre", "Novembre", "Août",
 "Janvier", "Novembre", "Novembre", "Février", "Mai", "Août",
 "Juillet", "Décembre", "Août", "Septembre", "Novembre",
 "Février", "Avril")
 lesMois <- factor(lesMois)
```
Par défaut, les niveaux seront présentés par ordre alphabétique, ce qui, dans le cas des mois, rendra la lecture des résultats un peu difficile lors de la synthèse des informations.
 
Par exemple, la fonction `table()` nous dira combien de fois chaque mois est apparu dans notre vecteur lesMois


```r
table(lesMois)
```

```
## lesMois
##      Août     Avril  Décembre   Février   Janvier   Juillet       Mai      Mars 
##         3         2         1         2         3         1         1         1 
##  Novembre   Octobre Septembre 
##         5         1         3
```

Bien que les mois aient clairement un ordre, cela ne se reflète pas dans le résultat de la fonction de tableau. On peut donc déclarer l'ordre d'apparition des mois en utilisant l'argument `levels = `


```r
lesMois <- factor(lesMois,levels=c("Janvier","Fevrier","MarS",
             "Avril","Mai","Juin","Juillet","Aout","Septembre",
             "Octobre","Novembre","Decembre"))

table(lesMois)
```

```
## lesMois
##   Janvier   Fevrier      MarS     Avril       Mai      Juin   Juillet      Aout 
##         3         0         0         2         1         0         1         0 
## Septembre   Octobre  Novembre  Decembre 
##         3         1         5         0
```

### Facteurs ordonnés

Dans notre déclaration des facteurs, nous n'avons pas indiqué de notion d'ordre entre les mois. De ce fait, les opérateurs de comparaison ne vont pas fonctionner. 


```r
lesMois[2] > lesMois[3]
```

```
## Warning in Ops.factor(lesMois[2], lesMois[3]): '>' not meaningful for factors
```

```
## [1] NA
```

La création d'un facteur ordonné résout ce problème:


```r
lesMois <- factor(lesMois,levels=c("Janvier","Fevrier","MarS",
             "Avril","Mai","Juin","Juillet","Aout","Septembre",
             "Octobre","Novembre","Decembre"), ordered = TRUE)

table(lesMois)
```

```
## lesMois
##   Janvier   Fevrier      MarS     Avril       Mai      Juin   Juillet      Aout 
##         3         0         0         2         1         0         1         0 
## Septembre   Octobre  Novembre  Decembre 
##         3         1         5         0
```

```r
lesMois[2] > lesMois[3]
```

```
## [1] TRUE
```

Une autre façon couremment utilisée pour créer des facteurs est de diviser une variable numérique continue en intervalles en utilisant la fonction  `cut()`. L'argument `break= ` est utilisé pour décrire comment des plages de nombres seront converties en valeurs de facteurs. Si un nombre est fourni par l'argument `breaks=`, le facteur résultant sera créé en divisant la plage de la variable en ce nombre d'intervalles de longueur égale ; si un vecteur de valeurs est fourni, les valeurs du vecteur sont utilisées pour déterminer les points de rupture. Notez que si un vecteur de valeurs est fourni, le nombre de niveaux du facteur résultant sera inférieur de un au nombre de valeurs du vecteur.

Prenons par exemple l'ensemble de données sur les femmes, qui contient la taille et le poids d'un échantillon de femmes. Si vous voulez créer un facteur correspondant au poids, avec trois niveaux également espacés :


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
L'argument `labels= argument` permet de donner des noms aux intervalles plutôt que la représentation standard en intervalle.


```r
wfact = cut(women$height,3,labels=c('Low','Medium','High'))
table(wfact)
```

```
## wfact
##    Low Medium   High 
##      5      5      5
```


