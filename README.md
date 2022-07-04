
<!-- README.md is generated from README.Rmd. Please edit that file -->

# geneConverter

<!-- badges: start -->
<!-- badges: end -->

The goal of geneConverter package is to provide an easy R function to convert gene
synonyms to gene names and orthologous gene names to human gene counterparts. 


## Installation

You can install the development version of geneConverter like so:

``` r
#install.packages("devtools)
library(devtools)
install_github("FurkanKepenek/geneConverter")
```

## Example `orthoConverter`

Here is an example data frame including gene names in one column:

| c.elegans_genes | asdf |
|:----------------|:-----|
| abt-2           | a    |
| pgp-1           | b    |
| wht-1           | c    |
| furkan          | d    |

`orthoConverter` function converts gene synonyms (if any) in the
selected column to gene names. This makes it easier to transform gene
synonyms to gene names even when the column contains a mixture of gene
synonyms and gene names. This function can also be used to be sure all
elements are gene names and there is no gene synonym in the table.
Output is the same data table with all other columns preserved. If given
data completely consisist of Ensembl ID’s, please choose Ensembl version
of that organism while using `ctype` argument. If you want there is a
table which explains the abbreviation and creatures for `ctype`
argument. You can examine it with `View(cre_table)`.

## Usage `orthoConverter`

``` r
df<-orthoConverter(example, "c.elegans_genes", ctype = celeg)
```

| c.elegans_genes | asdf |
|:----------------|:-----|
| ABCA1           | a    |
| ABCA12          | a    |
| ABCA13          | a    |
| ABCA2           | a    |
| ABCA4           | a    |
| ABCA7           | a    |
| furkan          | d    |
| ABCB1           | b    |
| ABCB11          | b    |
| ABCB4           | b    |
| ABCB5           | b    |
| ABCG1           | c    |
| ABCG2           | c    |
| ABCG4           | c    |

If `drop = TRUE` argument used, result will be like this:

``` r
df<-orthoConverter(example, "c.elegans_genes", ctype = celeg, drop = TRUE)
```

|     | c.elegans_genes | asdf |
|-----|:----------------|:-----|
| 1   | ABCA1           | a    |
| 2   | ABCA12          | a    |
| 3   | ABCA13          | a    |
| 4   | ABCA2           | a    |
| 5   | ABCA4           | a    |
| 6   | ABCA7           | a    |
| 8   | ABCB1           | b    |
| 9   | ABCB11          | b    |
| 10  | ABCB4           | b    |
| 11  | ABCB5           | b    |
| 12  | ABCG1           | c    |
| 13  | ABCG2           | c    |
| 14  | ABCG4           | c    |
