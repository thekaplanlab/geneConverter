
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
#install.packages("devtools)
library(devtools)
install_github("thekaplanlab/geneConverter")
```

## Example `orthoConverter`

Here is an example data frame including gene names in one column:

| gene_names | Ensembl_ID     |
|:-----------|:---------------|
| aat-1      | WBGene00000003 |
| bicd-1     | WBGene00016611 |
| gtl-2      | WBGene00001795 |
| CG12320    | FBgn0038590    |

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
df<-orthoConverter(example, "gene_names", ctype = celeg)
```

| converted_genes | Ensembl_ID     |
|:----------------|:---------------|
| SLC7A6          | WBGene00000003 |
| SLC7A7          | WBGene00000003 |
| SLC7A10         | WBGene00000003 |
| SLC7A5          | WBGene00000003 |
| SLC7A8          | WBGene00000003 |
| BICD1           | WBGene00016611 |
| BICD2           | WBGene00016611 |
| CG12320         | FBgn0038590    |
| TRPM1           | WBGene00001795 |
| TRPM3           | WBGene00001795 |
| TRPM7           | WBGene00001795 |

If `drop = TRUE` argument used, result will be like this:

``` r
df<-orthoConverter(example, "gene_names", ctype = celeg, drop = TRUE)
```

|     | converted_genes | Ensembl_ID     |
|-----|:----------------|:---------------|
| 1   | SLC7A6          | WBGene00000003 |
| 2   | SLC7A7          | WBGene00000003 |
| 3   | SLC7A10         | WBGene00000003 |
| 4   | SLC7A5          | WBGene00000003 |
| 5   | SLC7A8          | WBGene00000003 |
| 6   | BICD1           | WBGene00016611 |
| 7   | BICD2           | WBGene00016611 |
| 9   | TRPM1           | WBGene00001795 |
| 10  | TRPM3           | WBGene00001795 |
| 11  | TRPM7           | WBGene00001795 |
