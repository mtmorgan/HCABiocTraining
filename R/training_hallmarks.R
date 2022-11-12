#' @rdname training_hallmarks
#'
#' @title Helper Functions to Process 'Hallmarks of Cancer' MSigDB Gene Sets
#'
#' @description `training_hallmarks()` retrieves the 'Hallmarks of
#'     Cancer' geen sets from MSigDB.
#'
#' @details As is often the case, the Hallmarks of Cancer gene sets
#'     use gene identifiers from the NCBI ('Entrez' gene identifiers),
#'     but our data uses gene identifiers from Ensembl; this function
#'     accomplishes the tedious task of translating between gene sets
#'     using the Bioconductor 'org.Hs.eg.db' data resource and
#'     annotation functions in the AnnotationDbi pacakge. The mapping
#'     between identifiers is not 1:1, so the number of genes in each
#'     Hallmark set differs between Ensembl and Entrez identifiers.
#'
#' @return `training_hallmarks()` creates a tibble with columns 'gene'
#'     (Ensembl identifiers), 'set', and 'description' (a link to a
#'     description of the set on the MSigDB web site).
#'
#' @importFrom utils tail
#'
#' @importFrom dplyr tibble arrange distinct mutate
#'
#' @importFrom tidyr unnest
#'
#' @importFrom AnnotationDbi mapIds
#'
#' @importFrom org.Hs.eg.db org.Hs.eg.db
#'
#' @importFrom BiocFileCache bfcrpath
#'
#' @examples
#' training_hallmarks()
#'
#' @export
training_hallmarks <-
    function()
{
    ## remind the user that MSigDB expects registration before use;
    ## `paste(strwrap(paste0(...)))` produces a message that is
    ## wrapped to the width of the user's screen
    message(paste(strwrap(paste0(
        "visit 'https://www.gsea-msigdb.org/gsea/msigdb/human/collections.jsp' ",
        "to register for use of the MSigDb 'hallmarks' dataset."
    ), exdent = 4), collapse = "\n"))

    ## download and read the data; use BiocFileCache so the data is
    ## only downloaded once. The url is from browsing the web site.
    url <- paste0(
        "https://data.broadinstitute.org/gsea-msigdb/msigdb/",
        "release/2022.1.Hs/h.all.v2022.1.Hs.entrez.gmt"
    )
    hallmarks_file_path <- bfcrpath(rnames = url)
    hallmarks <- readLines(hallmarks_file_path)

    ## parse the file -- each line is a tab-separated gene set
    gene_set_records <- strsplit(hallmarks, "\t")
    n_gene_sets <- length(gene_set_records)
    ## the first element of each line is the name of the gene set
    gene_set_names <- vapply(gene_set_records, `[[`, character(1), 1L)
    ## the second element is a link to a description of the gene set
    gene_set_description <- vapply(gene_set_records, `[[`, character(1), 2L)
    ## the remaining are the elements in the set
    gene_set_elements <- lapply(gene_set_records, tail, -2)
    n_genes_per_set <- lengths(gene_set_elements)

    ## create a tibble of genes and the sets they belong to
    tbl <-
        tibble(
            gene = unlist(gene_set_elements),
            set = rep(gene_set_names, n_genes_per_set),
            description = rep(gene_set_description, n_genes_per_set)
        )

    ## We downloaded the 'ENTREZID' version of gene sets, but the ids
    ## in our dataset are from Ensembl; map 'gene' identifiers to
    ## ENSEMBL identifiers
    mapped_ids <-
        tbl |>
        mutate(
            gene = unname(mapIds(
                org.Hs.eg.db, .data$gene, "ENSEMBL", "ENTREZID",
                ## a problem is that the mapping between ENTREZID and
                ## ENSEMBL is not 1:1 -- a single ENTREZID may map to
                ## more than 1 ENSEMBL id
                multiVals = "list"
            ))
        ) |>
        ## use tidyr::unnest() to expand the tibble so that each row
        ## is again a single ENSEMBL id
        unnest("gene") |>
        ## it's possible that this introduces duplicate entries; make
        ## sure the results are distinct
        distinct()

    ## return the result, arranged (alphabetically) by 'gene'
    mapped_ids |>
        arrange(.data$gene)
}
