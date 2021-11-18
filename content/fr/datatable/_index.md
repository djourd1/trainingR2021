---
linktitle: "Manipulate data with data.table"
summary: Manipuler 
icon: book
icon_pack: fas

type: book  # Do not modify.
---



## Introduction

Dans la plupart des cas, les données que vous collecterez ne seront pas prêtes à être utilisées immédiatement. La plupart du temps, elles comporteront des valeurs manquantes, des noms de variables manquants ou des variables dispersées dans plusieurs colonnes que vous devrez synthétiser. Par conséquent, vous devez être capable de manipuler ces données. 

Dans la section "Se préparer", vous avez manipulé des vecteurs, des matrices et des data.frames en les réordonnant et en les sous-ensemblant grâce à l'indexation et à l'opérateur `[ ]`. 

Mais lorsque vous commencerez des analyses plus avancées, vous voudrez manipuler vos données avec des outils plus efficaces.

{{< figure library="true" src="OIP.jpg" >}}  

Pour ce faire, vous disposez de différentes options. Parmi elles, 3 environnements sont populaires :

+ Les outils de bases de data.frame
+ Le paquetage `data.table`
+ L'écosystème de paquetages: `tidyverse`


## Objectifs d'apprentissage

Dans ce chapitre, vous apprendrez à travailler avec le paquet `data.table`.

Après le premier chapitre, vous serez capable de manipuler vos données brutes, afin de les obtenir dans le format requis par les différents paquets économétriques. Vous pourrez notamment sélectionner les lignes et les colonnes, trier les lignes et créer de nouvelles colonnes.

Après le deuxième chapitre, vous comprendrez le concept de format large et de format long et vous serez en mesure de modifier et de remodeler vos données d'un format à l'autre.

Après le troisième chapitre, vous serez capable de fusionner des informations dispersées dans des tableaux différents mais liés par des clés.

## Les données

Dans ce chapitre, vous allez travailler avec les ensembles de données mis à disposition par le paquetage gapminder. Vous devriez maintenant être capable d'installer le paquetage par vous-même. 

Chargez le paquet `gapminder` :

```r
library(gapminder)
```

Si tout s'est bien passé, vous devriez pouvoir accéder directement aux données de gapminder.

```r
gapminder
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```


Vous êtes prêts à manipuler les données.




