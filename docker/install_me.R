BiocManager::install('reticulate')

BiocManager::install(ask=FALSE)

devtools::install(
    "/home/rstudio/",
    dependencies=TRUE,
    build_vignettes=TRUE,
    repos = BiocManager::repositories()
)
