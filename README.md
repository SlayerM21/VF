# AFRI analysis revision

The complete revised R Markdown and supporting records are available individually in this repository and together in the ZIP bundle.

- [Download the complete bundle](AFRI_Revision_Bundle.zip)
- [Complete R Markdown workflow](AFRI_CHAPTER_2_Optimized.Rmd)
- [Response variables and exact model formulas](Complete_Response_Model_List.md)
- [Model list as CSV](Complete_Response_Model_List.csv)
- [Revision and validation report](Revision_Report.md)
- [Analysis/export audit](Analysis_Export_Audit.csv)
- [Expected output directory tree](Expected_Output_Directory_Tree.txt)

Global GreenFeed contains one Year-random model for CH4 and one for CO2. The separate fixed-year sensitivity analyses are absent from the current workflow and model list.

Period models use treatment × stocking rate × period fixed effects with random Year and physical Pasture intercepts. The final-weight ANCOVA also includes initial body weight. The protected HMM/GPS specifications are preserved.

All 206 R chunks parsed, and targeted synthetic checks passed. Original research input datasets are not included; study-data model execution, research exports, and a full knit remain unverified. See the report for dependencies, input paths, remaining model limitations, and the precise validation scope.
