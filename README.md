# AFRI analysis revision

The complete revised R Markdown and supporting records are available individually in this repository and together in the ZIP bundle, including the Word model and dataset catalog.

- [Download the complete bundle](AFRI_Revision_Bundle.zip)
- [Export-only repair for an active R session](AFRI_Two_Scale_Export_Fix.R)
- [Complete R Markdown workflow](AFRI_CHAPTER_2_Optimized.Rmd)
- [Download the Word variable/model/dataset document](AFRI_Variables_Models_and_Datasets.docx)
- [Response variables and exact model formulas](Complete_Response_Model_List.md)
- [Model list as CSV](Complete_Response_Model_List.csv)
- [Revision and validation report](Revision_Report.md)
- [Analysis/export audit](Analysis_Export_Audit.csv)
- [Expected output directory tree](Expected_Output_Directory_Tree.txt)

Global GreenFeed contains one Year-random model for CH4 and one for CO2. The separate fixed-year sensitivity analyses are absent from the current workflow and model list.

Unique two-scale outputs use `Chapter_2_Results/05_Two_Scale_Analysis_maps/`, with numbered subfolders for tables, models, figures, maps, and spatial datasets.

P, A, and Q period models use `TRT * SR + Period`; Global GreenFeed uses `TRT * SR + RotationPeriod`. All retain random Year and physical Pasture intercepts. Treatment × stocking rate remains; period interactions are removed. Baseline S and the final-weight ANCOVA C remain unchanged. The protected HMM/GPS specifications are preserved.

When applying the additive-period model specifications, start a fresh R session and rerun the analysis so its tables use newly fitted objects.

For `cannot open the connection` in the unique percent-use/endpoint chunk, the corrected exporter uses compact summary/diagnostic filenames and includes full model IDs in its audit. Save `AFRI_Two_Scale_Export_Fix.R` beside the Rmd and run `source("AFRI_Two_Scale_Export_Fix.R")` in the session containing the existing results. This repair saves cached results and does not require refitting. Eight targeted export checks passed; actual Windows writes remain unverified.

All 206 R chunks parsed, and targeted synthetic checks passed. Original research input datasets are not included; study-data model execution, research exports, and a full knit remain unverified. See the report for dependencies, input paths, remaining model limitations, and the precise validation scope.
