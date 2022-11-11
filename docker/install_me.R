BiocManager::install('reticulate')
## reticulate::virtualenv_create(packages = 'anndata')

## default installation seems to link to invalid libicui18n.so.66
## install.packages('stringi', repos = BiocManager::repositories()[-1])

## BiocManager::install(ask=FALSE)

## devtools::install(
##     '/home/rstudio',
##     dependencies=TRUE,
##     repos = BiocManager::repositories()
## )
