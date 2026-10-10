# AFRI export-only recovery for the two-scale productivity chunk.
# Place this script beside the revised Rmd, then run:
# source("AFRI_Two_Scale_Export_Fix.R")
# It uses existing model/results objects. Data imports, model fits, EMM
# grids, omnibus tests and residual diagnostics are not rerun.
# export_results is respected. Full model IDs and model objects are preserved.
required_objects <- c("master_output_root", "export_results", "productivity_models",
  "productivity_diagnostics", "productivity_model_audit", "productivity_effects",
  "productivity_emmeans", "productivity_diagnostic_table")
missing_objects <- required_objects[!vapply(required_objects,
  function(name) exists(name, inherits = TRUE), logical(1))]
if (length(missing_objects)) stop("Existing analysis objects required: ",
  paste(missing_objects, collapse = ", "), ". Run the revised productivity chunk first.")
analysis_out <- file.path(master_output_root, "05_Two_Scale_Analysis_maps")
two_scale_dirs <- list(
  tables = file.path(analysis_out, "01_Tables"),
  models = file.path(analysis_out, "02_Model_Results"),
  figures = file.path(analysis_out, "03_Figures"),
  maps = file.path(analysis_out, "04_Maps"),
  spatial = file.path(analysis_out, "05_Spatial_Data")
)
# Include the destination in errors even when the chunk suppresses warnings.
two_scale_write_file <- function(directory, filename, writer) {
  if (!isTRUE(export_results)) return(invisible(NULL))
  destination <- file.path(directory, filename)
  tryCatch({
    parent <- dirname(destination)
    dir.create(parent, recursive = TRUE, showWarnings = FALSE)
    if (!dir.exists(parent)) stop("Output directory could not be created: ", parent)
    destination <- file.path(normalizePath(parent, winslash = "/", mustWork = TRUE),
      basename(destination))
    if (.Platform$OS.type == "windows" && nchar(destination) >= 260L) {
      stop("Path reaches the usual Windows 260-character limit. Move the project to a shorter path or use a shorter params$output_dir.")
    }
    writer(destination)
    if (!file.exists(destination) || is.na(file.info(destination)$size) ||
        file.info(destination)$size <= 0) stop("Writer did not create a nonempty output file.")
  }, error = function(e) {
    stop("Two-scale export failed: ", destination, " (", nchar(destination),
      " characters). ", conditionMessage(e), call. = FALSE)
  })
  invisible(destination)
}
two_scale_write_table <- function(x, filename) {
  if (!isTRUE(export_results)) return(invisible(NULL))
  if (!ncol(x)) {
    message("No tabular result available for ", filename, "; see the model status audit.")
    return(invisible(NULL))
  }
  two_scale_write_file(two_scale_dirs$tables, filename,
    function(destination) readr::write_csv(x, destination))
}
two_scale_save_figure <- function(filename, plot, ...) {
  two_scale_write_file(two_scale_dirs$figures, filename,
    function(destination) ggplot2::ggsave(destination, plot = plot, ...))
}
# Full model IDs stay in memory and in the audit; only disk basenames shorten.
two_scale_model_file_stem <- function(id) {
  substitutions <- c("two_scale__" = "", "ALL_PASTURE_GRAZING" = "all",
    "INSIDE_RGP_GRAZING" = "in", "WHOLE_SEASON_GRAZING" = "whole",
    "Percent_pasture_active" = "use", "Gain_kg_per_active_ha" = "gain",
    "synchronized_window_sensitivity" = "sync",
    "contiguous_endpoint_sensitivity" = "end", "RGP" = "rgp", "Season" = "season")
  stem <- id
  for (from in names(substitutions)) stem <- gsub(from, substitutions[[from]], stem, fixed = TRUE)
  stem <- gsub("__", "_", stem, fixed = TRUE)
  if (!grepl("^[A-Za-z0-9_]+$", stem) || nchar(stem) > 40L)
    stop("No compact export filename is defined for model: ", id)
  stem
}
two_scale_diagnostic_file_suffix <- function(plot_name) {
  suffixes <- c(residual_fitted = "resid", qq = "qq", scale_location = "scale")
  if (!plot_name %in% names(suffixes)) stop("Unknown diagnostic plot: ", plot_name)
  unname(suffixes[[plot_name]])
}
two_scale_productivity_file_manifest <- function(models, diagnostics) {
  ids <- as.character(names(models))
  stems <- vapply(ids, two_scale_model_file_stem, character(1))
  if (anyDuplicated(stems)) stop("Productivity export filenames are not unique.")
  data.frame(Model = ids, Export_stem = unname(stems),
    Summary_file = if (length(ids)) file.path("02_Model_Results", paste0(stems, "_summary.txt")) else character(),
    Diagnostic_files = vapply(ids, function(id) {
      plots <- names(diagnostics[[id]]$plots)
      files <- vapply(plots, function(plot_name) paste0(stems[[id]], "_",
        two_scale_diagnostic_file_suffix(plot_name), ".png"), character(1))
      paste(file.path("03_Figures", "Diagnostics", files), collapse = "; ")
    }, character(1)), stringsAsFactors = FALSE)
}


# The model audit owns the full-ID-to-filename index; it is exported only once.
productivity_export_manifest <- two_scale_productivity_file_manifest(
  productivity_models, productivity_diagnostics)
productivity_model_audit <- productivity_model_audit %>%
  dplyr::select(-dplyr::any_of(setdiff(names(productivity_export_manifest), "Model"))) %>%
  dplyr::left_join(productivity_export_manifest, by = "Model")
two_scale_write_table(productivity_model_audit, "Unique_percent_use_and_endpoint_model_audit.csv")
two_scale_write_table(productivity_effects, "Unique_percent_use_and_endpoint_contrasts.csv")
two_scale_write_table(productivity_emmeans, "Unique_percent_use_and_endpoint_EMM_tests.csv")
two_scale_write_table(productivity_diagnostic_table, "Unique_percent_use_and_endpoint_diagnostics.csv")
productivity_variance_review <- dplyr::bind_rows(lapply(names(productivity_diagnostics), function(id) {
  x <- productivity_diagnostics[[id]]$variance_review
  if (!nrow(x)) return(NULL)
  dplyr::mutate(x, model_id = id)
}))
two_scale_write_table(productivity_variance_review, "Unique_percent_use_and_endpoint_residual_variance.csv")
if (isTRUE(export_results) && length(productivity_models)) {
  two_scale_write_file(two_scale_dirs$models, "Unique_percent_use_and_endpoint_LMMs.rds",
    function(destination) saveRDS(productivity_models, destination))
  for (id in names(productivity_models)) {
    stem <- productivity_export_manifest$Export_stem[match(id, productivity_export_manifest$Model)]
    two_scale_write_file(two_scale_dirs$models, paste0(stem, "_summary.txt"),
      function(destination) writeLines(capture.output(summary(productivity_models[[id]])), destination))
    for (plot_name in names(productivity_diagnostics[[id]]$plots)) {
      filename <- paste0(stem, "_", two_scale_diagnostic_file_suffix(plot_name), ".png")
      two_scale_write_file(file.path(two_scale_dirs$figures, "Diagnostics"), filename,
        function(destination) ggplot2::ggsave(destination,
          productivity_diagnostics[[id]]$plots[[plot_name]], width = 7, height = 5, dpi = 300))
    }
  }
}
if (isTRUE(export_results)) {
  message("Two-scale exports completed using compact filenames. See Unique_percent_use_and_endpoint_model_audit.csv for the full model IDs and filenames.")
} else {
  message("Two-scale results retained in memory; export_results is FALSE.")
}
