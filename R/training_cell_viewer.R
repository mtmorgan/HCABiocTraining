#' @importFrom miniUI miniPage miniContentPanel gadgetTitleBar
#'
#' @importFrom shiny selectInput
#'
#' @importFrom plotly plotlyOutput
.cell_viewer_ui <-
    function(umap)
{
    choices <- setdiff(names(umap), c("V1", "V2", "colnames"))
    miniPage(
        miniContentPanel(
            ## The brush="brush" argument means we can listen for
            ## brush events on the plot using input$brush.
            selectInput(
                "color", "Color by",
                choices = choices, selected = NULL
            ),
            plotlyOutput("umap_plot")
        ),
        gadgetTitleBar("Drag to select points")
    )
}

#' @importFrom plotly renderPlotly plot_ly event_data layout
#'
#' @importFrom shiny observeEvent stopApp
#'
#' @importFrom dplyr filter
.cell_viewer_server <-
    function(umap)
{
    force(umap)
    function(input, output, session) {
        output$umap_plot <- renderPlotly({
            selected_columns <- event_data("plotly_selected")$customdata
            if (is.null(selected_columns))
                selected_columns <- umap$colname

            plot_ly(
                umap |> filter(.data$colname %in% selected_columns),
                x = ~ V1, y = ~ V2, color = ~ get(input$color),
                type = 'scatter', mode = 'markers', opacity = .5,
                customdata = ~ colname
            ) |> layout(dragmode = "select")
        })

        observeEvent(input$done, {
            selected_columns <- event_data("plotly_selected")$customdata
            if (is.null(selected_columns))
                selected_columns <- umap$colname

            stopApp(
                umap |>
                filter(.data$colname %in% selected_columns)
            )
        })
    }
}

#' @rdname training_cell_viewer
#'
#' @title Interactively Visualize and Subset UMAPs
#'
#' @param umap a `tibble()` with
#'
#' @importFrom shiny runGadget
#'
#' @export
training_cell_viewer <-
    function(umap)
{
    stopifnot(
        inherits(umap, "tbl"),
        c("V1", "V2", "colname") %in% colnames(umap)
    )

    suppressMessages({
        runGadget(.cell_viewer_ui(umap), .cell_viewer_server(umap))
    })
}
