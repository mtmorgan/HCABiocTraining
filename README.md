# HCABiocTraining

<!-- badges: start -->
[![Check, build, and push image](https://github.com/mtmorgan/HCABiocTraining/actions/workflows/basic_checks.yaml/badge.svg)](https://github.com/mtmorgan/HCABiocTraining/actions/workflows/basic_checks.yaml)
<!-- badges: end -->

HCABiocTraining is an introduction to Human Cell Atlas data retrieval
and analysis in _R_ / _[Bioconductor][]_. The focus is on single-cell
RNA-seq data. A wide range of material is covered, from basic _R_ to
advanced data analysis steps outlined in 'Orchestrating Single-Cell
Analysis with Bioconductor' ([OSCA][]). The treatment is very
superficial, but the hope is that it unlocks opportunities for
reproducible, sophisticated analysis.

## Installation

This resource includes

- A web site https://mtmorgan.github.io/HCABiocTraining.
- An 'Orchestra' resource for interactive computation.
- `ghcr.io/mtmorgan/hcabioctraining`, a pre-build docker image.
- The source code for this package at
  https://github.com/mtmorgan/HCABiocTraining.

Install necessary software from [GitHub](https://github.com/) with:

``` r
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
BiocManager::install("mtmorgan/HCABiocTraining", dependencies = TRUE)
```

The software makes use of the [anndata][] Python module through the
*R* package [reticulate][]. Install *anndata* following *reticulate*
best practices, e.g., by creating and using a virtual environment.

``` r
library(reticulate)
reticulate::virtualenv_create('HCABiocTraining', packages = 'anndata')
use_virtualenv('HCABiocTraining')
```

[anndata]: https://anndata.readthedocs.io/en/latest/index.html
[reticulate]: https://cran.r-project.org/package=reticulate

## Articles

The articles in this repository cover four main topics

1. Introduction to _R_. Scripting, core functions, and contributed
   packages.

2. HCA Data Access. Using the [hca][] and [cellxgenedp][] packages for
   data retrieval.

3. Single Cell Sequence Analysis. Explores the [Seurat][] and
   [SingleCellExperiment][] frameworks for well-established single
   cell analysis work flows such as the *Seurat* documentation and *R*
   / *Bioconductor* 'Orchestrating Single-Cell Analysis with
   Bioconductor' ([OSCA][]).

4. Integrating single cell data into _R_ and _Bioconductor_ workflows


5. Prospects for multimodal, spatial and extended analysis.

[Bioconductor]: https://bioconductor.org
[hca]: https://bioconductor.org/packages/hca
[cellxgenedp]: https://bioconductor.org/packages/cellxgenedp
[Seurat]: https://satijalab.org/seurat/
[SingleCellExperiment]: https://bioconductor.org/packages/SingleCellExperiment
[OSCA]: https://bioconductor.org/books/OSCA
