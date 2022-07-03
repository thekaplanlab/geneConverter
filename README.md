
<!-- README.md is generated from README.Rmd. Please edit that file -->

# geneConverter

<!-- badges: start -->
<!-- badges: end -->

The goal of geneConverter is to provides functions to convert gene
synonyms to gene names and homologous gene names of several organism
includes human.

## Installation

You can install the development version of geneConverter like so:

``` r
if(!require(geneConverter)){
  library(devtools)
  install_github("FurkanKepenek/geneConverter")
```

## Example

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
Output is the same data table with all other columns preserved.

## Usage

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
