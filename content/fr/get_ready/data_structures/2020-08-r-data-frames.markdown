---
title: "Les data.frame"
author: "Damien Jourdain"
date: '2020-08-20'
slug: r-data-frames
categories: R
tags: []
type: book
weight: 60
---

## Objectifs d'apprentissage

Les objets "data.frame" permettent de stocker des données de *différents types* dans une seule structure tabulaire. J'utiliserai l'orthographe "data.frame" car il existe plusieurs structures tabulaires proches  qui ont été développées sur la plateforme R (data.frame, data.table, tibble), et il m'a semblé plus simple de retenir les noms que vous aurez à utiliser pour les manipuler.
 
Les data.frame sont très pratiques pour travailler avec des données d'enquête car elles sont généralement stockées sous forme de tableau, avec de nombreuses colonnes correspondant aux réponses à l'enquête et de nombreuses lignes (généralement, mais pas toujours, une ligne correspondant à une enquête). 

Dans cette section, vous apprendrez :

+ [Qu'est-ce qu'une base de données](#cquoi)
+ [Comment créer un data.frame](#creer-data-frame)
+ [Comment accéder aux données](#acceder-data-frame)
+ [Comment trier les données](#trier-data-frame)
+ [Comment résumer rapidement les données](#resume-data-frame)
+ [Quelles sont les autres structures de données proches](#autres-data-frame)
  + [Tibbles](#tibbles)
  + [data.table](#data-table)
  
## Qu'est-ce qu'un data.frame ? {#cquoi}

Un `data.frame` est une *structure bidimensionnelle semblable à un tableau* dans laquelle chaque colonne contient les valeurs d'une variable et chaque ligne contient un ensemble de valeurs de chaque colonne.

Voici les caractéristiques d'un data.frame:

+ Les noms des colonnes doivent être non vides ;
+ Les noms des lignes doivent être uniques ;
+ Les données stockées dans un cadre de données peuvent être numériques, factorielles ou de type caractère ;
+ Chaque colonne doit contenir le même nombre d'éléments de données.

> Les data.frame sont particulièrement utiles car ils permettent de combiner différents types de données en un seul objet et sont plus faciles à manipuler que les listes.  

Nous pouvons utiliser les `data.frame` fournis par défaut quand vous installez R pour comprendre cela. Par exemple, le data.frame `mtcars` peut être utilisé directement en tapant simplement son nom.



```r
mtcars # pour ce document, nous avons utilisé une version modifiée de mtcars avec seulement 10 lignes
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
```

La ligne supérieure du tableau, appelée *en-tête*, contient les *noms des colonnes*. Chaque ligne qui suit indique une *ligne de données*, qui commence par le **nom de la ligne**, puis est suivie par les données réelles. Chaque élément de données d'une ligne est appelé *cellule*. 
Vous pouvez facilement l'interpréter comme un cadre de données décrivant des voitures. Chaque ligne correspond à un modèle unique de voiture, chaque colonne correspond aux différentes caractéristiques de ce modèle.

Si vous voulez connaître la structure exacte de l'objet `mtcars`, vous pouvez utiliser la fonction `str()`.


```r
str(mtcars)
```

```
## 'data.frame':	10 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1
##  $ am  : num  1 1 1 0 0 0 0 0 0 0
##  $ gear: num  4 4 4 3 3 3 3 4 4 4
##  $ carb: num  4 4 1 1 2 1 4 2 2 4
```

Nous apprenons que `mtcars` est un objet R de type `data.frame`, qui contient 32 observations (c'est-à-dire 32 lignes) de 11 variables (c'est-à-dire 11 colonnes). Ensuite, chaque colonne est décrite (nom, type, premières valeurs stockées).

## Comment créer un data.frame {#creer-data-frame}

Souvent, vous ne créerez pas de data.frame à partir de zéro, mais vous les importerez généralement à partir d'autres programmes (voir le chapitre sur l'importation de données). 

Cependant, vous devez savoir que vous pouvez créer un data.frame par vous-même.


```r
new.data <- data.frame(
   emp_id = c (1:5), 
   emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
   salary = c(623.3, 515.2, 611.0, 729.0, 843.25), 
   start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
      "2015-03-27")),
   stringsAsFactors = FALSE   # il est possible d'éviter la conversion des vecteurs de caractères en facteurs
)

new.data
```

```
##   emp_id emp_name salary start_date
## 1      1     Rick 623.30 2012-01-01
## 2      2      Dan 515.20 2013-09-23
## 3      3 Michelle 611.00 2014-11-15
## 4      4     Ryan 729.00 2014-05-11
## 5      5     Gary 843.25 2015-03-27
```

## Comment accéder aux données {#acceder-data-frame}

### Données contenues dans dans une cellule

Pour récupérer des données dans une cellule, vous devez entrer ses coordonnées de ligne et de colonne entre des crochets simples (opérateur `[ ]`). **Les deux coordonnées sont séparées par une virgule**. En d'autres termes, les coordonnées commencent par la position de la ligne, suivie d'une virgule, et se terminent par la position de la colonne. **L'ordre est important**.

Voici la valeur de la cellule située à la première ligne et à la deuxième colonne de `mtcars`.


```r
mtcars [1, 2]
```

```
## [1] 6
```

De plus, nous pouvons utiliser les noms des lignes et des colonnes au lieu des coordonnées numériques.


```r
mtcars ["Mazda RX4", "cyl"] 
```

```
## [1] 6
```

### Données contenues dans une colonne

Il existe plusieurs façons de récupérer les données contenues dans les colonnes.

Tout d'abord, nous pouvons récupérer une seule colonne avec l'opérateur "$" :

```r
mtcars$am 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```

```r
class(mtcars$am)
```

```
## [1] "numeric"
```

Notez que vous devez connaître le nom de la colonne que vous souhaitez récupérer. Toutefois, si vous utilisez R Studio, si vous avez tapé mtcars$, une liste de noms possibles vous sera proposée (encore une bonne raison d'utiliser R Studio au lieu de R).

Ensuite, nous pouvons récupérer une colonne avec l'opérateur `[ ]`. Pour ce faire, nous devons faire précéder le nom ou le numéro de la colonne d'une virgule, ce qui indique que nous voulons prendre en compte toutes les lignes :


```r
mtcars[, "am"] 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```

```r
mtcars[,9] 
```

```
##  [1] 1 1 1 0 0 0 0 0 0 0
```

Notez que :

  + l'ordre de mtcars$am préserve l'ordre des lignes de la table de données. C'est important car cela nous permet de manipuler une variable en fonction des résultats d'une autre.
  + l'objet `mtcars$am` qui est produit est un vecteur contenant 10 nombres. 


### Données contenues dans plusieurs colonnes

Pour selectionner plusieurs colonnes, vous ne pouvez plus utiliser le `\$`, mais devez utiliser les crochets:

L'exemple suivant montre que vous pouvez extraire les colonnes 2, 3 et 4 de la table `mtcars` et les stocker dans un nouveau data.frame appelé `carsub`: 


```r
carsub <- mtcars[,2:4]
head(carsub) # la fonction head affiche les six premières lignes du tableau
```

```
##                   cyl disp  hp
## Mazda RX4           6  160 110
## Mazda RX4 Wag       6  160 110
## Datsun 710          4  108  93
## Hornet 4 Drive      6  258 110
## Hornet Sportabout   8  360 175
## Valiant             6  225 105
```

N'oubliez pas que si vous voulez afficher plusieurs colonnes qui ne sont pas dans la même séquence de chiffres, vous pouvez utiliser la fonction R `c()`. Rappelez-vous que c() est une fonction générique permettant de combiner des arguments pour former un vecteur. Donc si vous voulez sélectionner les colonnes 3, 7 et 11 :


```r
carsub <- mtcars[ , c(3,7,11)]
head(carsub)
```

```
##                   disp  qsec carb
## Mazda RX4          160 16.46    4
## Mazda RX4 Wag      160 17.02    4
## Datsun 710         108 18.61    1
## Hornet 4 Drive     258 19.44    1
## Hornet Sportabout  360 17.02    2
## Valiant            225 20.22    1
```

Notez que la fonction `c()` n'est pas limitée à la combinaison de nombres. Elle peut combiner de nombreux types d'objets différents en un seul vecteur (à condition que tous les objets que vous voulez combiner soient du même type).

Vous obtiendrez le même résultat en créant un vecteur de noms de colonnes :


```r
carsub <-mtcars[ ,c("disp", "qsec", "carb")]
head(carsub)
```

```
##                   disp  qsec carb
## Mazda RX4          160 16.46    4
## Mazda RX4 Wag      160 17.02    4
## Datsun 710         108 18.61    1
## Hornet 4 Drive     258 19.44    1
## Hornet Sportabout  360 17.02    2
## Valiant            225 20.22    1
```

### Données contenues dans les lignes

Les lignes d'un data.frame peuvent être selectionnées avec les crochets uniques, tout comme nous l'avons fait avec les colonnes. Cependant, en plus d'un vecteur d'index des positions des lignes, vous devez ajouter une virgule. *Ceci est important, car la virgule supplémentaire signale que l'on veut sélectionner toutes les colonnes*. 

Vous devriez être en mesure de sélectionner des lignes en utilisant la fonction `c()`.


```r
mtcars[1:2, ] 
```

```
##               mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
```

```r
mtcars[c(1,3,10), ] 
```

```
##             mpg cyl  disp  hp drat   wt  qsec vs am gear carb
## Mazda RX4  21.0   6 160.0 110 3.90 2.62 16.46  0  1    4    4
## Datsun 710 22.8   4 108.0  93 3.85 2.32 18.61  1  1    4    1
## Merc 280   19.2   6 167.6 123 3.92 3.44 18.30  1  0    4    4
```

```r
mtcars["Dastsun 710", ]
```

```
##    mpg cyl disp hp drat wt qsec vs am gear carb
## NA  NA  NA   NA NA   NA NA   NA NA NA   NA   NA
```

```r
mtcars[c("Datsun 710", "Fiat X1-9"), ]
```

```
##             mpg cyl disp hp drat   wt  qsec vs am gear carb
## Datsun 710 22.8   4  108 93 3.85 2.32 18.61  1  1    4    1
## NA           NA  NA   NA NA   NA   NA    NA NA NA   NA   NA
```

### Sous-ensemble de lignes et de colonnes

Si vous avez compris la mécanique de sélection des columnes et des lignes, vous pouvez faire une sélection combinée de lignes et de colonnes que vous voulez traiter.


```r
mtcars [c(1,3,10), c(2, 3:5) ] 
```

```
##            cyl  disp  hp drat
## Mazda RX4    6 160.0 110 3.90
## Datsun 710   4 108.0  93 3.85
## Merc 280     6 167.6 123 3.92
```


## Comment trier les données {#trier-data-frame}

Pour trier un data.frame, utilisez la fonction `order( )`. Par défaut, le tri se fait par order croissant. Si la variable de tri est précédées d'un signe moins, l'ordre sera alors décroissant. 


```r
# ordonnez les voitures en utilisant la colonne mpg (ordre croissant)
mtcars[order(mtcars$mpg),]
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
```


```r
#trier les voitures à l'aide de deux clés
mtcars[order(mtcars$mpg, -mtcars$cyl),]
```

```
##                    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Duster 360        14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Valiant           18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Merc 280          19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Mazda RX4         21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive    21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Datsun 710        22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Merc 230          22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 240D         24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
```

{{% callout note %}}

Notez que vous devez répéter la partie mtcars$ dans la fonction order() ; ne pas le faire produira une erreur, car la fonction order() cherchera une variable mpg qui (normalement) n'existe pas.


```r
mtcars[order(mpg),]
```

```
## Error in order(mpg): object 'mpg' not found
```

{{% /callout %}}

## Comment résumer rapidement les données {#resume-data-frame}

Vous pouvez obtenir un résumé statistique des données contenus dans le data.frame en appliquant la fonction `summary()`.


```r
summary(carsub)
```

```
##       disp            qsec            carb     
##  Min.   :108.0   Min.   :15.84   Min.   :1.00  
##  1st Qu.:150.0   1st Qu.:17.02   1st Qu.:1.25  
##  Median :163.8   Median :18.45   Median :2.00  
##  Mean   :208.6   Mean   :18.58   Mean   :2.50  
##  3rd Qu.:249.8   3rd Qu.:19.86   3rd Qu.:4.00  
##  Max.   :360.0   Max.   :22.90   Max.   :4.00
```


## Quelles sont les autres structures tabulaires {#autres-data-frame}

### tibble

`tibble` est une structure tabulaire de données développée plus récemment par les équipes de RStudio. Les tibble permettent également de saisir des données de types différents et possèdent des caractéristiques internes qui facilitent le travail avec certains progiciels. 

Vous pouvez travailler avec tibble en installant la suite de paquets `tidyverse` ou plus simplement le paquet `tibble`.


```r
# install a suite of related packages
install.packages("tidyverse")

# Alternatively, install just tibble:
install.packages("tibble")
```

Une fois installé, vous devrez charger le paquet tibble à chaque session:


```r
library(tibble)
```

#### Creation d'un tibble

Comme pour les data.frame, vous pouvez créer un nouveau tibble à partir de vecteurs individuels avec tibble(). 

La fonction tibble() permet de:
+ se référer à des variables que vous venez de créer au sein de la fonction
+ recycler automatiquement les entrées de longueur 1
+ conserver les chaînes de caractères en tant que caractères (et ne pas les convertir automatiquement en facteurs)


```r
tibble(
  x = 1:5, 
  y = 1, # ce sera automatiquement transformé en un vecteur de longueur 5
  z = x^2 + y, # il reconnaîtra x et y qui viennent d'être créés
  t = letters[1:5] # les chaînes de caractères ne seront pas converties en facteurs
)
```

```
## # A tibble: 5 x 4
##       x     y     z t    
##   <int> <dbl> <dbl> <chr>
## 1     1     1     2 a    
## 2     2     1     5 b    
## 3     3     1    10 c    
## 4     4     1    17 d    
## 5     5     1    26 e
```

Elle vérifie également que les colonnes soient de la même longueur (sauf, comme on l'a vu plus haut pour les valeurs uniques)


```r
tibble(
  x = 1:5, 
  t = letters[1:3]
)
```

```
## Error: Tibble columns must have compatible sizes.
## * Size 5: Existing data.
## * Size 3: Column `t`.
## i Only values of size one are recycled.
```


#### Affichage des données 

Quand vous avez un grand nombre de lignes, seules les 10 premières lignes et les colonnes qui tiennent à l'écran seront affichées. Sous la ligne des noms, les types de données sont également affichées:


```r
ans <- tibble(
  x = 1:50, 
  t = letters[1:50],
  x2 = x^2,
  e = sample(letters, 50, replace = TRUE)
)
ans
```

```
## # A tibble: 50 x 4
##        x t        x2 e    
##    <int> <chr> <dbl> <chr>
##  1     1 a         1 g    
##  2     2 b         4 t    
##  3     3 c         9 l    
##  4     4 d        16 w    
##  5     5 e        25 x    
##  6     6 f        36 a    
##  7     7 g        49 u    
##  8     8 h        64 e    
##  9     9 i        81 a    
## 10    10 j       100 s    
## # ... with 40 more rows
```


#### Subsetting

tibble est plus strict que data.frame pour signaler les erreurs; par exemple, ils génèrent un avertissement si la colonne à laquelle vous essayez d'accéder n'existe pas.

Comparez les deux codes :


```r
df <- data.frame(
  thex = runif(5),
  they = rnorm(5)
)
df$x # Extract by name
```

```
## NULL
```

```r
df$thex
```

```
## [1] 0.6949710 0.7144547 0.5185774 0.4659353 0.1942903
```

```r
df[["x"]] 
```

```
## NULL
```

```r
df[[1]] # Extract by position
```

```
## [1] 0.6949710 0.7144547 0.5185774 0.4659353 0.1942903
```


```r
df <- tibble(
  thex = runif(5),
  they = rnorm(5)
)
df$x # Extract by name 
```

```
## Warning: Unknown or uninitialised column: `x`.
```

```
## NULL
```

```r
df[["x"]] 
```

```
## NULL
```

```r
df[[1]] # Extract by position
```

```
## [1] 0.0777215 0.9170838 0.6790047 0.9916079 0.1642457
```

### data.table

`data.table` est un paquet qui étend `data.frame`. Plus concrètement, quand vous convertissez un data.frame en data.table, il garde la classe `data.frame`, mais sera également de la classe `data.table`. C'est une caractéristique utile quand vous devez travailler avec des paquets qui n'acceptent que des data.frame.

Deux de ses caractéristiques les plus remarquables sont la vitesse et une syntaxe "simplifiée". Je donnerai beaucoup plus de détails sur data.table dans une section séparée.

