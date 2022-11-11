#' @rdname cxg_dataset
#'
#' @title Summarize CxG Information About a Dataset
#'
#' @param dataset_id character(1) dataset identifier, as returned by,
#'     e.g., `datasets()`.
#'
#' @importFrom dplyr filter .data
#'
#' @importFrom rjsoncons jmespath
#'
#' @importFrom jsonlite toJSON fromJSON
#'
#' @importFrom cellxgenedp db datasets collections
#'
#' @examples
#' dataset <- "de985818-285f-4f59-9dbd-d74968fddba3"
#' ds <- cxg_dataset(dataset)
#' ds
#'
#' @export
cxg_dataset <-
    function(dataset_id)
{
    id <- dataset_id
    cellxgene_db = db()

    ## retrieve dataset and collection information
    dataset <-
        datasets(cellxgene_db) |>
        filter(.data$dataset_id == id)
    collection <-
        collections(cellxgene_db) |>
        filter(.data$collection_id == dataset$collection_id)

    ## create an object with relevant information
    json <- jsonlite::toJSON(collection, auto_unbox = TRUE)
    family <-
        jmespath(json, "[].publisher_metadata[].authors[].family") |>
        fromJSON()
    given <- 
        jmespath(json, "[].publisher_metadata[].authors[].given") |>
        fromJSON()
    authors <- paste(family, given, sep = ", ", collapse = "; ")
    journal <-
        jmespath(json, "[].publisher_metadata[].journal") |>
        fromJSON()

    dataset_assay <-
        jmespath(dataset, "[].assay[].label[]") |>
        fromJSON() |>
        paste(collapse = "; ")
    dataset_organism <-
        jmespath(dataset, "[].organism[].label[]") |>
        fromJSON() |>
        paste(collapse = "; ")
    dataset_ethnicity <-
        jmespath(dataset, "[].self_reported_ethnicity[].label[]") |>
        fromJSON() |>
        paste(collapse = "; ")
    structure(list(
        collection_name = collection$name,
        collection_description = collection$description,
        collection_authors = authors,
        collection_journal = journal,
        dataset_assay = dataset_assay,
        dataset_organism = dataset_organism,
        dataset_ethnicity = dataset_ethnicity
    ), class = "cxg_dataset")
}


.pretty <-
    function(label, ..., indent = 0, exdent = 4)
{
    x <- paste(label, paste0(...), sep = ": ")
    paste(strwrap(x, indent = indent, exdent = exdent), collapse = "\n")
}

#' @rdname cxg_dataset
#'
#' @param x A `cxg_dataset` object resulting from a call to
#'     `cxg_dataset()`.
#'
#' @param ... Additional arguments (to `print.cxg_dataset()`); ignored.
#'
#' @export
print.cxg_dataset <-
    function(x, ...)
{
    cat(
        .pretty("title", x$collection_name), "\n",
        .pretty("description", x$collection_description), "\n",
        .pretty("authors", x$collection_authors), "\n",
        .pretty("journal", x$collection_journal), "\n",
        .pretty("assays", x$dataset_assay), "\n",
        .pretty("organism", x$dataset_organism), "\n",
        .pretty("ethnicity", x$dataset_ethnicity), "\n",
        sep = ""
    )
}
