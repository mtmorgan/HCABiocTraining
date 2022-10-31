# HCABiocTraining

<!-- badges: start -->
<!-- badges: end -->

HCABiocTraining is an introduction to Human Cell Atlas data retrieval
and analysis in _R_ / _[Bioconductor][]_. The focus is on single-cell
RNA-seq data. A wide range of material is covered, from basic _R_ to
advanced data analysis steps outlined in 'Orchestrating Single-Cell
Analysis with Bioconductor' ([OSCA][]). The treatment is very
superficial, but the hope is that it unlocks opportunities for
reproducible, sophisticated analysis.

## Installation

Install necessary software from [GitHub](https://github.com/) with:

``` r
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install("mtmorgan/HCABiocTraining")
```

## Articles

The articles in this repository cover four main topics

1. Introduction to _R_. Scripting, core functions, and contributed
   packages.

2. HCA Data Access. Using the [hca][] and [cellxgenedp][] packages for
   data retrieval.
   
3. _R_ and _Bioconductor_ Analysis of Single-Cell Expression
   Data. Introduction to key resources available for analysis of
   single-cell expression data. [Seurat][]. The
   [SingleCellExperiment][] and 'Orchestrating Single-Cell Analysis
   with Bioconductor' ([OSCA][])
   
4. Prospects for spatial and extended analysis.

[Bioconductor]: https://bioconductor.org
[hca]: https://bioconductor.org/packages/hca
[cellxgenedp]: https://bioconductor.org/packages/cellxgenedp
[Seurat]: https://satijalab.org/seurat/
[SingleCellExperiment]: https://bioconductor.org/packages/SingleCellExperiment
[OSCA]: https://bioconductor.org/books/OSCA
