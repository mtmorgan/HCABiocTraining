#' @rdname training_read_h5ad
#'
#' @title Read 'h5ad' Files as R / Bioconductor Objects
#'
#' @description `read_h5ad_as_sce()` uses the Python h5ad module and R
#'     'anndata' package to import the `.h5ad` objects into R /
#'     Bioconductor 'SingleCellExperiment'.
#'
#' @param h5ad_file_path `character(1)` path to the `.h5ad` file.
#'
#' @return `training_read_h5ad_as_sce()` returns an R / Bioconductor
#'     SingleCellExperiment object. The assay data `X` is the (sparse)
#'     matrix named 'X' in the h5ad file.
#' 
#' @importFrom anndata read_h5ad
#'
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
training_read_h5ad_as_sce <-
    function(h5ad_file_path)
{
    h5ad <- read_h5ad(h5ad_file_path)
    SingleCellExperiment(
        assays = list(
            counts = Matrix::t(h5ad$X)
            ## too much memory for github actions
            ## logcounts = log1p(Matrix::t(h5ad$X))
        ),
        colData = h5ad$obs, rowData = h5ad$var,
        metadata = h5ad$uns,
        reducedDims = h5ad$obsm,
    )
}

#' @rdname training_read_h5ad
#'
#' @export
training_read_h5ad_as_seurat <-
    function(h5ad_file_path)
{
    h5ad <- read_h5ad(h5ad_file_path)
    seurat <- Seurat::CreateSeuratObject(
        counts = Matrix::t(h5ad$X),
        meta.data = h5ad$obs
    )

    ## h5ad_reductions <- names(h5ad$obsm)
    ## seurat_reductions <- sub("X_", "", h5ad_reductions)
    ## for (i in seq_along(h5ad_reductions))
    ##     seurat[[seurat_reductions[[i]]]] <-
    ##         h5ad$obsm[[h5ad_reductions[[i]]]]

    seurat
}
