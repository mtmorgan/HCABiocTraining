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
