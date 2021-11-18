---
linktitle: "Chapter 4: Combine datasets"
summary: 
weight: 5
icon: book-reader
icon_pack: fas

# Page metadata.
title: "Chapter 4: Combine datasets"
slug: dt-combine
date: "2021-02-22"
type: book  
---

Data analysis often involve more than one table of data. In many cases, you will have many tables that you will need to combine. 

To combine, we will say "join" or "merge", the two tables, they will need to be related, i.e. they must have something in common. A typical example in the field of agricultural economics will be a table `Household` containing all the households you have surveyed, each household having a unique `household_ID`. Each household cultivates different plots for which you have collected various information. A plot will be described by a unique `plot_ID` but will be cultivated by one household identified by an `household_ID`. These informations are in two different tables, that you may want to combine for analysis. In order to do so, you will join them by their common field (here the `household_ID`).  

You may encounter the same situation when you have detailed information about all the members of the household.

{{< figure library="true" src="relationalDBS.jpg">}}

Relational tables are usually found in Relational Database Management Systems (or RDBMS). If you’ve used a database before, you've almost certainly used SQL. If so, you should find the concepts in this chapter familiar. If not, do not worry, the package data.table is providing a simple syntax adapted for most our needs without you to learn SQL.

