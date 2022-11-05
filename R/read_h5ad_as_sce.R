#' @rdname read_h5ad
#'
#' @title Read 'h5ad' Files as R / Bioconductor Objects
#'
#' @description `read_h5ad_as_sce()` uses the Python h5ad module and R
#'     'anndata' package to import the `.h5ad` objects into R /
#'     Bioconductor 'SingleCellExperiment'.
#'
#' @param h5ad_file_path `character(1)` path to the `.h5ad` file.
#'
#' @return `read_h5ad_as_sce()` returns an R / Bioconductor
#'     SingleCellExperiment object. The assay data `X` is the (sparse)
#'     matrix named 'X' in the h5ad file.
#' 
#' @importFrom anndata read_h5ad
#'
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
read_h5ad_as_sce <-
    function(h5ad_file_path)
{
    h5ad <- read_h5ad(h5ad_file_path)
    SingleCellExperiment(
        assays = list(X = Matrix::t(h5ad$X)),
        colData = h5ad$obs, rowData = h5ad$var,
        metadata = h5ad$uns,
        reducedDims = h5ad$obsm,
    )
}
