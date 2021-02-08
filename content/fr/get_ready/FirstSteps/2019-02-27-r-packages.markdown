---
title: Les Packages (paquets)
author: Damien Jourdain
date: '2019-02-27'
slug: r-packages
categories:
  - R
tags: []
type: book
weight: 9

---

## Objectifs d'apprentissage

Les paquets R sont des ensembles de fonctions et de données. Ils augmentent la puissance de R en améliorant ou en en ajoutant des fonctionnalités à l'application de base.

Dans cette section, nous passerons en revue plusieurs aspects sur les paquets:

+ Qu'est-ce qu'un paquet ? 
+ Où trouver le paquet qui vous interesse ?
+ Comment installer un paquet ?
+ Quelles sont les fonctions liées à install.packages() ? 
+ Comment pouvez-vous utiliser l'interface utilisateur pour installer des paquets ? 
+ Comment charger des paquets ? 
+ Comment se renseigner sur ces paquets ?

## Qu'est-ce qu'un paquet ?

Un paquet comprend généralement du code (pas seulement du code R !), de la documentation sur le paquet et les fonctions qu'il contient, des tests pour vérifier que tout fonctionne comme il faut et parfois des données.

Les informations de base sur un paquet sont fournies dans le fichier DESCRIPTION, où vous pouvez trouver ce que fait le paquet, qui en est l'auteur, à quelle version appartient la documentation, la date, le type de licence d'utilisation et les dépendances du paquet.

## Que sont les dépôts ?

Un dépôt est un endroit où se trouvent les paquets afin que vous puissiez les installer à partir de celui-ci. En général, ils sont en ligne et accessibles à tous. Le dépôt le plus populaire pour les paquets R est **CRAN**. 

CRAN est le dépôt officiel, c'est un réseau de serveurs web géré par la communauté R dans le monde entier. Il est coordonné par la fondation R, et pour qu'un paquet soit publié ici, il doit passer plusieurs tests qui garantissent que le paquet suit les règles du CRAN. 

## Installation d'un paquet

La méthode pour installer un paquet dépend de l'endroit où il se trouve. Ainsi, pour les paquets accessibles au public, cela signifie dans quel dépôt est stocké. 

Tous les paquets que nous utiliserons sont disponibles sur le dépôt du CRAN.

Au cours de la formation, nous utiliserons largement le paquet `data.table`. Vous devrez installer ce paquet sur votre ordinateur avant de pouvoir l'utiliser. 

Pour installer ce paquet, vous pouvez soit le faire "manuellement", soit utiliser l'interface R-Studio. 

Si vous voulez le faire directement à partir de la console, vous pouvez utiliser la commande 


```r
install.packages("data.table")
```
Après l'avoir lancé, vous recevrez quelques messages sur la console. Ils dépendront du système d'exploitation que vous utilisez, des dépendances et de la réussite de l'installation du paquet.

Avec R-Studio, vous pouvez également utiliser le menu. Suivez Outils -> Installer les paquets... et vous obtiendrez une fenêtre pop-up pour sélectionner le paquet que vous voulez installer :

{{< figure library="true" src="installpackages/installpackages.png" title="Tapez le nom du paquet que vous voulez installer" numbered="true">}}


Normalement, lorsque vous tapez les premières lettres, on vous propose une liste de noms de paquets parmi lesquels vous pouvez choisir. 

Une fois que vous avez sélectionné le paquet à installer, il vous suffit de cliquer sur le bouton "Installer". Vous recevrez quelques messages à l'écran. Ils dépendront du système d'exploitation que vous utilisez, des dépendances et de la réussite de l'installation du paquet.


## Comment vérifier les paquets installés et les mettre à jour

Les paquets R sont souvent mis à jour par leurs développeurs. Il est possible que vous deviez tôt ou tard mettre à jour ou remplacer certains de ces paquets. 

Avec R Studio, vous pouvez garder une trace des paquets déjà installés sur votre ordinateur, en cliquant sur l'onglet Paquets du volet Fichiers, Tracés, Paquets, Aide, Visualisation.

{{< figure library="true" src="installpackages/update-packages.png" title="Mise à jour des paquets avec R Studio" numbered="true">}}

Une fois que vous aurez fait cela, vous verrez une liste des paquets installés, et vous aurez la possibilité de les mettre à jour. C'est une bonne idée de mettre à jour les paquets une fois par mois. 

## Comment charger les colis

Une fois qu'un paquet est installé, vous êtes prêt à utiliser ses fonctionnalités. 
Pour ce faire, vous devez le charger dans la mémoire de l'ordinateur. La façon la plus simple de le faire est d'utiliser la commande `library()`.

Le paquet est chargé dans la mémoire, et quelques messages sont envoyés pour confirmer que le paquet est chargé, ainsi que quelques messages supplémentaires.  

*Notez que ces messages seront de couleur rouge même si tout s'est bien passé !  *


```r
library(data.table)
```

```
## Warning: package 'data.table' was built under R version 4.0.3
```

Notez également que l'entrée de `install.packages()` est un vecteur de caractères et nécessite que le nom soit entre guillemets, alors que `library()` accepte soit le caractère soit le nom et vous permet d'écrire le nom du paquet sans les guillemets.

## Comment décharger un paquet

Pour décharger un colis donné, vous pouvez utiliser la fonction detach(). L'utilisation sera :

```r
detach("package:data.table", unload=TRUE)
```

## Comment obtenir de l'aide concernant le paquet

### Fichiers d'aide

Comme pour le R de base, les commandes `?` et `help()` sont la première source de documentation lorsque vous débutez avec un paquet. 

Vous pouvez obtenir un aperçu général du paquet en utilisant help(package = "NomDuPaquet"). En outre, chaque fonction peut être explorée individuellement par help("nom de la fonction") ou help(fonction, package = "NomDuPaquet") si le paquet n'a pas été chargé, où vous trouverez généralement la description de la fonction et de ses paramètres ainsi qu'un exemple d'application.

Conseil : vous pouvez également utiliser une autre méthode pour voir ce qui se trouve à l'intérieur d'un paquet chargé. Utilisez la commande `ls()` de cette façon :


```r
library(data.table)
```

```
## Warning: package 'data.table' was built under R version 4.0.3
```

```r
ls("package:data.table")
```

```
##   [1] "%between%"          "%chin%"             "%flike%"           
##   [4] "%ilike%"            "%inrange%"          "%like%"            
##   [7] ":="                 "address"            "alloc.col"         
##  [10] "as.data.table"      "as.IDate"           "as.ITime"          
##  [13] "as.xts.data.table"  "between"            "chgroup"           
##  [16] "chmatch"            "chorder"            "CJ"                
##  [19] "copy"               "cube"               "data.table"        
##  [22] "dcast"              "dcast.data.table"   "fcase"             
##  [25] "fcoalesce"          "fifelse"            "fintersect"        
##  [28] "first"              "foverlaps"          "frank"             
##  [31] "frankv"             "fread"              "frollapply"        
##  [34] "frollmean"          "frollsum"           "fsetdiff"          
##  [37] "fsetequal"          "fsort"              "funion"            
##  [40] "fwrite"             "getDTthreads"       "getNumericRounding"
##  [43] "groupingsets"       "haskey"             "hour"              
##  [46] "IDateTime"          "indices"            "inrange"           
##  [49] "is.data.table"      "isoweek"            "key"               
##  [52] "key<-"              "last"               "like"              
##  [55] "mday"               "melt"               "melt.data.table"   
##  [58] "merge.data.table"   "minute"             "month"             
##  [61] "nafill"             "quarter"            "rbindlist"         
##  [64] "rleid"              "rleidv"             "rollup"            
##  [67] "rowid"              "rowidv"             "second"            
##  [70] "set"                "setalloccol"        "setattr"           
##  [73] "setcolorder"        "setDF"              "setDT"             
##  [76] "setDTthreads"       "setindex"           "setindexv"         
##  [79] "setkey"             "setkeyv"            "setnafill"         
##  [82] "setnames"           "setNumericRounding" "setorder"          
##  [85] "setorderv"          "shift"              "shouldPrint"       
##  [88] "SJ"                 "tables"             "test.data.table"   
##  [91] "timetaken"          "transpose"          "truelength"        
##  [94] "tstrsplit"          "uniqueN"            "update.dev.pkg"    
##  [97] "wday"               "week"               "yday"              
## [100] "year"
```

### Vignettes

Les vignettes sont des documents dans lesquels les auteurs montrent certaines fonctionnalités de leur paquet de manière plus détaillée. Suivre les vignettes est une excellente façon de commencer à travailler avec un paquet avant de faire sa propre analyse.

Elles sont généralement accessibles en haut du fichier d'aide du paquet.


{{< figure library="true" src="installpackages/vignettes.png" title="Les vignettes" numbered="true">}}

Vous pouvez également parcourir directement les vignettes disponibles en utilisant :


```r
browseVignettes(package="data.table")
```
Une fenêtre de navigateur s'ouvrira pour que vous puissiez facilement explorer et cliquer sur la vignette préférée pour l'ouvrir.
