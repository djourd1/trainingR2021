---
title: Les principes de fonctionnement de data.table
author: Damien Jourdain
date: '2020-08-20'
slug: dt-principles
categories:
  - R
tags: []

type: book
weight: 10
---

La syntaxe générale pour utiliser data.table est de la forme :

`DT[i, j, by]`

que l'on lira comme:

+ Prendre DT
+ selectionnons/réorganisons des lignes en utilisant $i$
+ puis calculez $j$, groupé par $by$

Il existe un large éventail de possibilités pour agir sur votre ensemble de données, notamment

+ creer un sous-ensemble des données
+ combiner différents ensembles de données
+ résumer un ensemble de données

En outre, le paquetage permet d'effectuer des manipulations supplémentaires telles que:

+ fusionner deux ensemble de données
+ remodeler les données

Vous apprendrez progressivement ces fonctions en utilisant l'aide et les vignettes de `data.table`.
Dans ce cours, je présenterai seulement les principales fonctions que vous utiliserez pour manipuler nos données.

