# Export-only recovery for the nine final three-grid metric maps.
# Save beside the Rmd and run in the session containing the existing plots:
# source("AFRI_Three_Grid_Map_Export_Fix.R")
# No data import, map reconstruction, model fit or inference is performed.
required_objects <- c("master_output_root", "export_results", "three_grid_metric_plot_objects")
missing_objects <- required_objects[!vapply(required_objects,
  function(name) exists(name, inherits = TRUE), logical(1))]
if (length(missing_objects)) stop("Existing analysis objects required: ",
  paste(missing_objects, collapse = ", "), ". Run the map construction chunk first.")
required_metrics <- c("BW_LWG", "CH4", "CO2")
required_grids <- c("ALL_PASTURE_RGP", "INSIDE_RGP", "WHOLE_SEASON")
if (!exists("three_grid_metric_plot_objects"))
  stop("Run the three-grid metric map construction chunk before final map export.")
for (metric in required_metrics) {
  if (!metric %in% names(three_grid_metric_plot_objects))
    stop("Missing metric plot collection: ", metric)
  missing <- setdiff(required_grids, names(three_grid_metric_plot_objects[[metric]]))
  if (length(missing)) stop("Missing ", metric, " grid plots: ", paste(missing, collapse = ", "))
}
final_map_root <- file.path(master_output_root, "01_Grazing_Behavior_Spatial_Aera",
                           "04_Maps", "Three_Grid_Metrics")
final_map_dirs <- list(
  BW_LWG = file.path(final_map_root, "01_LWG"),
  CH4 = file.path(final_map_root, "02_CH4"),
  CO2 = file.path(final_map_root, "03_CO2")
)
# A temporary output prevents a failed device from destroying an existing map.
# Publish a successfully written PNG; do not unlink previous analysis outputs.
save_map_png <- function(plot_object, filename, width, height, dpi = 300) {
  if (!isTRUE(export_results)) return(invisible(NULL))
  destination <- filename
  tryCatch({
    directory <- dirname(destination)
    dir.create(directory, recursive = TRUE, showWarnings = FALSE)
    if (!dir.exists(directory)) stop("Could not create PNG output directory: ", directory)
    directory <- normalizePath(directory, winslash = "/", mustWork = TRUE)
    destination <- file.path(directory, basename(filename))
    temporary_png <- tempfile("m_", tmpdir = directory, fileext = ".png")
    on.exit(if (file.exists(temporary_png)) unlink(temporary_png), add = TRUE)
    if (.Platform$OS.type == "windows" &&
        max(nchar(destination), nchar(temporary_png)) >= 260L) {
      stop("Destination or temporary PNG reaches the usual Windows 260-character limit (temporary path: ",
        nchar(temporary_png), " characters). Use a shorter project path or params$output_dir.")
    }
    device <- if (requireNamespace("ragg", quietly = TRUE)) ragg::agg_png else "png"
    export_error <- NULL
    tryCatch(ggplot2::ggsave(temporary_png, plot = plot_object, device = device,
      width = width, height = height, units = "in", dpi = dpi,
      bg = "white", limitsize = FALSE),
      error = function(e) {export_error <<- conditionMessage(e)})
    if (!is.null(export_error) && !is.character(device)) {
      message("ragg failed for ", basename(destination), "; trying the standard PNG device: ", export_error)
      ggplot2::ggsave(temporary_png, plot = plot_object, device = "png",
        width = width, height = height, units = "in", dpi = dpi,
        bg = "white", limitsize = FALSE)
    } else if (!is.null(export_error)) stop(export_error)
    bytes <- if (file.exists(temporary_png)) as.numeric(file.info(temporary_png)$size) else 0
    if (!is.finite(bytes) || bytes <= 0) stop("Map device did not create a nonempty PNG.")
    signature <- readBin(temporary_png, what = "raw", n = 8L)
    if (!identical(signature, as.raw(c(137, 80, 78, 71, 13, 10, 26, 10))))
      stop("Map device did not create a PNG file.")
    if (!file.copy(temporary_png, destination, overwrite = TRUE))
      stop("Could not publish completed map.")
  }, error = function(e) {
    stop("Final map export failed: ", destination, " (", nchar(destination),
      " characters). ", conditionMessage(e), call. = FALSE)
  })
  invisible(destination)
}
map_grid_file_tags <- c(ALL_PASTURE_RGP = "all_rgp", INSIDE_RGP = "inside_rgp",
                       WHOLE_SEASON = "season")

map_export_inventory <- list()
if (isTRUE(export_results)) {
  for (metric in required_metrics) {
    for (i in seq_along(required_grids)) {
      grid <- required_grids[i]
      filename <- file.path(final_map_dirs[[metric]],
        sprintf("%s_%02d_%s.png", metric, i, map_grid_file_tags[[grid]]))
      seasonal <- identical(grid, "WHOLE_SEASON")
      saved_file <- save_map_png(three_grid_metric_plot_objects[[metric]][[grid]],
        filename, width = if (seasonal) 12 else 16,
        height = if (seasonal) 8 else 10, dpi = 300)
      map_export_inventory[[paste(metric, grid, sep = "__")]] <- tibble::tibble(
        Metric = metric, Grid = grid, File = saved_file,
        Exists = file.exists(saved_file),
        Size_bytes = as.numeric(file.info(saved_file)$size),
        Path_length = nchar(saved_file))
    }
  }
  map_export_inventory <- dplyr::bind_rows(map_export_inventory)
  if (nrow(map_export_inventory) != 9L ||
      any(!map_export_inventory$Exists | !is.finite(map_export_inventory$Size_bytes) |
          map_export_inventory$Size_bytes <= 0))
    stop("The final inventory must contain nine successfully written PNG maps.")
  inventory_dir <- file.path(master_output_root, "01_Grazing_Behavior_Spatial_Aera", "01_Tables")
  dir.create(inventory_dir, recursive = TRUE, showWarnings = FALSE)
  inventory_file <- file.path(inventory_dir, "Three_grid_BW_CH4_CO2_map_inventory.csv")
  tryCatch({
    if (!dir.exists(inventory_dir)) stop("Inventory directory could not be created.")
    readr::write_csv(map_export_inventory, inventory_file)
  }, error = function(e) stop("Final map inventory export failed: ", inventory_file,
    ". ", conditionMessage(e), call. = FALSE))
  knitr::kable(map_export_inventory, caption = "Final BW/LWG, CH4, and CO2 three-grid map exports")
} else {
  map_export_inventory <- tibble::tibble(
    Metric = character(), Grid = character(), File = character(), Exists = logical(),
    Size_bytes = numeric(), Path_length = integer())
  message("Final map objects are available; export_results is FALSE so files were not written.")
}
