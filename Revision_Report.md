# AFRI R Markdown revision report

The delivery contains one complete document, `AFRI_CHAPTER_2_Optimized.Rmd`, with all runtime helpers embedded. It replaces the uploaded 33,602-line document with a 21,718-line workflow and retains 50 response specifications in the final statistical reporting layer. A response specification can reuse an earlier model; it does not imply another fitted model. No scientific results were invented, and the uploaded file was left unchanged.

The current requested-model revision passed actual R parsing and targeted synthetic execution. Current statistical, Global GreenFeed, two-scale, table/export and formula-audit checks passed; unchanged shared-helper checks are explicitly identified as prior evidence. **A full knit, study-data model execution, and study export generation remain unverified because the original HMM, BW, GreenFeed, and GIS inputs were not supplied.** The document deliberately reports unavailable models or inference instead of silently switching families or modifying the requested formulas after a singular fit.

## User-requested model specification update

The latest instruction explicitly requests only Year and physical Pasture random intercepts. It supersedes the additional pasture-year and animal/steer random intercepts in the preceding revision. All repeated pasture-period, animal-period, and optional sampling-qualified GreenFeed questions now use the requested structure. Protected HMM/GPS baseline models and the observed final-weight ANCOVA keep their prior specifications.

| Code / scope | Requested formula |
|---|---|
| S — baseline | `response ~ TRT * SR + (1 | Year) + (1 | Pasture)` |
| P — pasture-period | `response ~ TRT * SR * Period + (1 | Year) + (1 | Pasture)` |
| A — animal-period | `response ~ TRT * SR * Period + (1 | Year) + (1 | Pasture)` |
| F — Global GreenFeed | `response ~ TRT * SR * RotationPeriod + (1 | Year) + (1 | Pasture)` |
| C — observed final-weight ANCOVA | `FBW ~ IBW + TRT * SR + (1 | Year) + (1 | Pasture_ID)` |
| Q — sampling-qualified animal-period GreenFeed | `response ~ TRT * SR * Period + (1 | Year) + (1 | Pasture)` |

`RGP`, `Period`, and `RotationPeriod` are the respective source names for grazing period. Global GreenFeed F uses the literal `RotationPeriod` and `Year` columns in the requested formula. `Pasture_ID` and `Pasture` identify physical pastures.

F now equals the Global primary Year-random question. The former fixed-year sensitivity is removed rather than refitted as a duplicate of the primary model. Both gases retain one primary model and reuse it for downstream tables and figures. The complete catalog therefore has 50 final reporting entries plus 12 source/conditional entries (62 records). A and Q share a formula structure with P, while their observation units and Q qualification rule remain distinct.

This changes the covariance assumptions and can change estimates, SEs, degrees of freedom, and P-values; numerical equivalence to the preceding revision is not claimed. Animal and pasture-year identifiers remain available as linkage/QC metadata, but no separate random effects or residual correlation terms are fitted for those identifiers. Within-animal repeated-measure and pasture-year residual correlation beyond the shared Year/Pasture intercepts remains a limitation. The single-pasture-per-treatment-cell limitation and withholding of unsupported confirmatory inference remain in place.

## Files supplied

- `AFRI_CHAPTER_2_Optimized.Rmd`: complete analysis, usable as a single RStudio document.
- `Analysis_Export_Audit.csv`: 197 detailed rows covering derived datasets, QC records, retained models, reporting views, figures, spatial outputs, and export ownership.
- `Response_Model_Inventory.csv`: all 50 final reporting specifications, their data sources, scale, and observation unit.
- `Complete_Response_Model_List.csv` and `.md`: all 62 reporting/source/conditional entries, with exact formulas and model-reuse conditions.
- `Expected_Output_Directory_Tree.txt`: standalone expected output tree.
- `Revision_Metadata.json`: source/revision hashes, counts, and execution limitation.
- `validation/`: parsing, protected-model preservation, package versions/availability, and synthetic-test evidence. These are validation records, not study results.

## Changes to the protected HMM/GPS Sections 1–5.5

The user confirmed that the protected reference is the first HMM/GPS workflow through its Section 5.5, rather than the similarly numbered BW sections.

All four reference models retain identical formula, data, and REML arguments. Of the 46 protected R chunks, 33 are text-identical after line-ending normalization; another spatial chunk differs only in two comments that used the obsolete terminology. The other changes concern integration, cached calculations, applicable diagnostics, and export handling:

1. Qualified reference fitting calls as `lme4::lmer()` and cached their existing `car::Anova()` results. The original reference Type III test method remains unchanged.
2. Reused the already-created EMM grids in Table 1. Its model observations, estimates, tests, and scientific definitions remain tied to the original monthly fits; no replacement season-mean Table 1 models are fitted.
3. Preserved Shapiro–Wilk tests where applicable and added an explicit not-run status for fewer than three, more than 5,000, or constant finite residuals. Existing reference Shapiro results are reused by the later diagnostic layer. The reference raw-data distribution checks are retained separately.
4. Added parameter defaults for interactive setup and corrected the input-file absolute-path regex escaping.
5. Consolidated Table 1, long EMM/post-hoc results, and its omnibus sheets into `Table_1_Grazing_Behaviors.xlsx`; removed the duplicate CSV and second workbook copies. Removed duplicate PDF copies of the reference PNG EMM figures.
6. Used the required spatial folder name from initial setup onward, removed unused folder creation, respected the export switch, and removed automatic deletion of malformed old exports.
7. Made the reference PNG and GeoPackage writers prepare and verify temporary outputs before refreshing designated files. A failed PNG render, including a partial nonempty image, cannot replace an existing completed image.
8. Registered the existing reference models for later reuse and extended their variance, rank-deficiency, singularity, and convergence review.

The reference models omit an animal-year random intercept despite their monthly observations. This remains an explicit within-animal correlation limitation of the preserved reference; preservation is not evidence that those tests supply independently replicated pasture-treatment inference.

## Imports and processing

- HMM CSV import remains once. The three smart-scale CSVs and three distinct BW worksheet reads remain once each; different worksheets are not treated as duplicate datasets.
- Each discovered GreenFeed workbook is imported once. The annual GreenFeed steer CSVs remain distinct from the BW workbook rosters because their equivalence could not be established without the original data. Their objects are now named `gf_Steers_*` so they cannot overwrite BW `Steers_*`.
- BW and GreenFeed reuse corrected HMM pasture/rotation geometry. Repeated shapefile readers, boundary corrections, and clipping passes were removed. Assertions verify source files, CRS, feature mappings, rotation keys, and supplied area references before reuse.
- The rotation schedule is shared, while the BW and GreenFeed date intersections remain separate. In particular, the original GreenFeed final-period endpoints differ from BW in 2023 and 2024; those GreenFeed endpoints are preserved and asserted.
- Equivalent timestamp parsing and date filtering were consolidated. Manual BW endpoints are summarized in one pass while retaining both contiguous-calendar-day and first/last-available-day definitions. Raw and shrunk weights remain separate scientifically meaningful measures.
- Finite-value helpers and exact identifier helpers are reused. Similar functions with different missing/infinite-value behavior are not indiscriminately merged.
- Whole-season active area continues to use directly pooled seasonal GPS fixes. It is never obtained by adding period areas. All-pasture period, inside-RGP period, and independent whole-season denominators remain distinct.

## Statistical consolidation and corrections

The former family-selection, repair/fallback, and competing final-model framework was replaced by a shared Gaussian LMM workflow. All new inferential fits use `lme4::lmer()`, with `lmerTest` inference and retained `emmeans` grids. No Gamma/Tweedie/GLMM, unclustered LM/GLM fallback, covariance-selection refitting, or automatic removal of grouping factors remains.

A registry retains a fit per question and refuses conflicting formula/data reuse. Inference and diagnostics are cached. Later sections reuse reference behavior/DDT models, whole-window ADG, matched-grid active-area fits, equivalent Global gas means, and equivalent joined Dressler seasonal values. Reuse requires matching complete observation keys, response values, and relevant window provenance. Different endpoint subsets or aggregation weights are explicitly labeled sensitivity questions rather than silently merged. The three matched-grid area questions must use the retained BW source model: missing or failed source fits and unequal integrated rows are audited as unavailable, and cannot trigger competing replacement fits.

All baseline and repeated models now use only the requested Year/Pasture random intercepts. P, A, and Q keep the Treatment × Stocking Rate × Period fixed-effect specification. The previous revision's separate pasture-year and animal-year random terms are removed consistently from BW area, Global gas, unique two-scale, and final statistical models. Whole-season models continue to use Year/Pasture. Identity columns are retained for matching observations, sample-size/design audits, and descriptive coverage checks.

Kenward–Roger is used for suitable REML fits when `pbkrtest` is available and the model has at most 3,000 observations. Satterthwaite is recorded otherwise, including preserved ML fits; the helper does not silently refit an ML model to obtain KR. Type III factor contrasts are set before new fits. Global GreenFeed F uses random Year and physical Pasture, and reuses the primary model; no separate fixed-year sensitivity remains.

The design has one physical pasture per TRT × SR cell. Repeated animals, periods, and years are not independent treatment replicates. The final design audit is repeated on each response's complete cases. Available raw management tests are labeled exploratory/conditional, confirmatory reporting values and management letters are withheld where replication is insufficient, and missing/nonfinite estimates, SEs, or tests remain missing. The protected Table 1 is preserved with its original results and the stated limitations.

Unique monthly, period, whole-window, calendar-season, raw-endpoint ANCOVA, percent-active-area, daily land-rate, season-total land-rate, and ratio questions remain distinct. The original seasonal productivity loop that sought period-grid labels in the whole-season dataset is corrected. Duplicate period ADG and equivalent land-ratio fits are consolidated; a genuinely different synchronized-window or endpoint subset remains a labeled sensitivity.

## Diagnostics and tables

Every retained Gaussian fit has applicable full-residual Shapiro–Wilk results/status, residual-versus-fitted and normal Q–Q plots, scale-location and grouped residual-SD review, fitted random variances, singularity, optimizer/convergence warnings, and dropped fixed-column metadata. Residual flags identify rows for review and do not delete them. No model is changed solely because its Shapiro P-value is significant or a variance reaches zero.

Tables consume retained results rather than refitting or recomputing EMMs. They retain model-specific n, observation and experimental-unit information, six TRT × SR EMM ± SE cells, model-based TRT/SR/interaction P-values, and appropriate scoped letters. Period tables also retain relevant period tests. Missing results use a dash and are audited. The publication layer uses one workbook for five remaining table families and numerical/model/design/diagnostic/QC records; it does not duplicate Table 1.

## Export organization

Every old requested directory name and all obsolete framework identifiers were removed from the code. `AFRI_OUT` and the separate two-scale root are consolidated under the spatial package. `05_Requested_Revision_Final` is not created or referenced. Existing obsolete folders/files are not automatically deleted. Designated result files are refreshed only when exports are requested.

A final integrated writer now retains the four complete BW/productivity datasets, the descriptive behavior-period dataset, and six unique assignment/availability/map-QC tables. These had been computed without a complete final data-export owner. Whole-season daily-rate QC is kept in the statistical workbook rather than duplicated as CSV.

BW and GreenFeed final export blocks now honor `export_results = FALSE`. Report-only graphics use temporary report paths; they cannot leak into another analysis's result folder. BW's final SVG figures/maps are generated by knitr during rendering, while GreenFeed and metric-map final outputs have designated writers. Each of the nine LWG/CH4/CO2 three-grid PNGs has one exporter and one inventory.

Model RDS files support downstream reuse and are not duplicate CSV tables. Reused models keep their original export owner. A single complete session record and current-run inventory are written at the end. BW's separate checksum manifest remains a distinct integrity audit. Direct RStudio chunk execution displays BW figures; rendering is required to generate its knitr-managed SVG collection.

Expected output tree (only writers with meaningful outputs create their directories):

```text
Chapter_2_Results/
├── 01_Grazing_Behavior_Spatial_Aera/
│   ├── 01_Tables/                       # HMM data/QC, Table 1 XLSX, map inventory
│   ├── 02_Model_Results/                # four retained reference fits/summaries
│   ├── 03_Figures/                      # reference EMM/diagnostic PNGs
│   ├── 04_Maps/
│   │   ├── 01_QC_State/
│   │   ├── 02_Final_State/
│   │   ├── 03_QC_Combined/
│   │   ├── 04_Final_Combined/
│   │   ├── 05_QC_Separate/
│   │   ├── 06_Final_Separate/
│   │   ├── 07_Active_Area/
│   │   └── Three_Grid_Metrics/
│   │       ├── 01_Body_Weight_LWG_Three_Grids/  # three PNGs
│   │       ├── 02_CH4_Three_Grids/             # three PNGs
│   │       └── 03_CO2_Three_Grids/             # three PNGs
│   ├── 05_Spatial_Data/                 # HMM/base/grid GeoPackages
│   ├── Two_Scale_Analysis/
│   │   ├── 01_Tables/                   # coverage/endpoints/GPS/inference/QC
│   │   ├── 02_Model_Results/            # unique conditional/sensitivity RDS
│   │   ├── 03_Figures/                  # coverage + Diagnostics/
│   │   ├── 04_Maps/RGP_two_active_area_grid_maps/
│   │   └── 05_Spatial_Data/Whole_season_unique_active_grid.gpkg
│   └── Integrated_Analysis/01_Tables/   # eleven unique final dataset/QC CSVs
├── 02_Grazing_BW_AFRI/
│   ├── 01_Tables/
│   ├── 02_Model_Results/                # splines, authoritative ADG/area fits
│   ├── 03_Figures/                      # final knitr SVGs
│   ├── 04_Maps/                         # distinct final knitr SVG layouts
│   ├── 05_Spatial_Data/period_production_sf.gpkg
│   └── 06_Logs/                         # BW export/checksum audits
├── 03_Grazing_GreenFeed_AFRI/
│   ├── 01_Tables/                       # curated QC/means/inference CSVs
│   ├── 02_Model_Results/                # two retained Year/Pasture primary gas models
│   ├── 03_Figures/                      # final TIFFs + diagnostic PDFs
│   ├── 04_Maps/                         # final CH4/CO2 TIFFs
│   ├── 05_Spatial_Data/GreenFeed_Gas_Per_Active_Hectare.gpkg
│   └── 06_Logs/GreenFeed_Export_Audit.csv
└── 06_Statistical_Analysis/
    ├── 01_Tables/AFRI_Statistical_Results.xlsx
    ├── 02_Model_Results/Retained_Gaussian_LMMs.rds
    ├── 03_Figures/Diagnostics/          # newly owned model diagnostics only
    └── 06_Logs/
        ├── Complete_Analysis_Session_Info.txt
        └── Final_Export_Inventory.csv
```

## Analysis/export audit overview

The full 197-row CSV gives each source object and destination. `Preserved`, `Consolidated`, and `Corrected` describe code treatment. Every row separately states that its **study-data execution is not verified**.

| Section | Analysis / output | Source object | Final export location | Status |
|---|---|---|---|---|
| HMM 1–4 | Behaviors, movement, QC, three independent area denominators | retained HMM/daily/monthly/GPS/area objects | spatial `01_Tables`, `04_Maps`, `05_Spatial_Data` | Preserved |
| HMM 5.2–5.4 | Reference Table 1, EMMs/tests, four fitted models and plots | `table1_results`, original models/EMMs | spatial Table 1 XLSX, model and figure folders | Consolidated |
| BW 1–4 | Cleaning, splines, growth, whole-window ADG | `BW_daily`, `animal_spline_models`, `smooth_adg_model` | BW standard folders | Preserved / Consolidated |
| BW 5–6 | Production and three matched-area LMMs | `period_production_sf`, `pasture_use_models` | BW standard folders | Corrected to requested Year/Pasture grouping |
| GreenFeed 1–4 | Unique visits, daily/Dressler/Global means, two Year/Pasture primary models | `visit_records_unique`, `dressler_animal_system`, `gf_rotation_models` | GreenFeed standard folders | Consolidated / Corrected |
| Two-scale 4–8 | Coverage, endpoint ANCOVA, qualifying gases, percent use and distinct sensitivities | `manual_endpoint_summary`, `conditional_models`, `productivity_models` | spatial `Two_Scale_Analysis` | Preserved / Corrected |
| Integrated 9.2–9.5 | Final animal/pasture datasets and unique map/availability QC | `shrunk_bw_*`, `period_level_grazing_productivity`, `whole_season_grazing_productivity` | spatial `Integrated_Analysis/01_Tables` | Corrected |
| Statistical 9.7–9.12 | 50 response views, authoritative fits, diagnostics and design audit | `analysis_fits` and retained earlier models | owned archive/diagnostics and statistical workbook | Consolidated / Corrected |
| Publication 9.12–9.13 | Five remaining manuscript table families and numerical/QC sheets | `publication_table_objects`, retained inference objects | statistical workbook | Consolidated |
| Final maps | Nine metric maps and single inventory | `three_grid_metric_plot_objects` | spatial `04_Maps/Three_Grid_Metrics` and `01_Tables` | Consolidated |

## Validation report

| Check | Outcome | Scope / limitation |
|---|---|---|
| Static code and cross-section audit | Passed targeted checks | Requested formulas applied consistently; obsolete names/framework and former fixed-year fit/export objects absent. Source-data equality is enforced at runtime, not presumed. |
| Full model catalog formula audit | Passed 66 formula checks | 62 full formulas plus four conditional alternatives have only Year/Pasture random intercepts, required fixed interactions, random Year, and the ANCOVA IBW covariate. This is static formula inspection. |
| R Markdown YAML and chunk labels | Passed | 206 uniquely labeled R chunks; valid YAML. |
| Actual R parsing | Passed | 206/206 chunks; knitr purl and complete extracted-R parsing. |
| Protected model argument comparison | Passed | All four reference formula/data/REML call arguments identical; 33/46 protected chunks text-identical. |
| Installed-package namespace API audit | Passed for 142 uses | Zero unavailable-function failures among checked APIs; 32 uses could not be checked because their packages were absent. |
| Shared runtime/model/diagnostic checks | Prior evidence retained | Unchanged shared helper, parameter and map-safety functions previously passed 29 synthetic checks; these records are distinct from current formula-specific tests. |
| Current final export guards/inventory | 9/9 synthetic checks passed | All BW/GF disabled-export guards, eleven integrated CSVs, current-run inventory and no-delete behavior. |
| Statistical-layer integration | 32 current synthetic assertions passed | 22 primary requested-structure/reuse/count/grid/diagnostic checks; nine Global gas provenance and empty-schema checks; one comparison-cache check. |
| Authoritative area and stale-source safeguards | 23/23 current synthetic checks passed | Exact source reuse; missing, failed or unequal area source unavailable; pre-change models with extra random effects rejected instead of silently reused. Together with the preceding row, 55 statistical assertions passed. |
| Global GreenFeed models and interfaces | Current synthetic checks passed | Exactly two Gaussian models with literal Year/Pasture groups; KR inference, 60 EMM rows, n/tests/letters/diagnostics/cache, unchanged gas values and 459-date plus NA classifications. |
| Two-scale models, counts, endpoints and maps | 10 current synthetic check groups passed | Qualified Q gas thresholds exercised in test-only fixtures; distinct fitted animal counts after missingness; requested P/S and unchanged C; duplicate gain consolidation and distinct sensitivities; endpoint rules and map writer checks. |
| Publication cross-schema execution | Current synthetic execution passed | All five table families; ten n values matched retained synthetic-model nobs; one workbook reopened with 30 nonempty sheets; no duplicate Table 1 raw rows; missing and empty results preserved. |
| Nine-map writer | Current synthetic checks passed | Nine fabricated plots produced nine PNGs and one inventory; disabled/failed writes handled. These are not research maps. |
| Study statistical model execution | **Not run** | Original source datasets absent. No actual n/EMM/SE/P/CLD values validated. |
| Study export creation / GIS writes | **Not run** | Original inputs absent; sf unavailable in validation runtime. Actual map appearance, geometry/equality assertions and GeoPackage writes require project inputs. |
| Full document knit | **Not run** | Source datasets absent; full application dependencies were not available. |

The validation runtime was R 4.5.0 with lme4 1.1-37, lmerTest 3.1-3, emmeans 1.10.7, and pbkrtest 0.5.4. Tested versions are recorded in `validation/Package_Versions.csv`. `lubridate`, `car`, `sf`, `readxl`, and `DHARMa` were unavailable in that local validation runtime; the complete workflow was therefore not executed. Synthetic tests isolated the installed helper dependencies and never substituted generated data for the research analysis.

Tests exposed and corrected unexported `emmeans::pairs` calls, empty-result normalization/schema failures, scoped prerequisite lookups, export-switch leaks, and partial-render overwrite risks. Several generated models using the intentionally unreplicated six-pasture allocation also produced singularity or unstable/negative-variance inference warnings. Passing code-path tests does not establish valid treatment inference under that design. Missing numerical results are retained as missing and flagged for review.

## Running in RStudio

Place the Rmd in the project root with the original input directories described in its YAML. Use current compatible package versions (R 4.1+ for native pipes and dplyr 1.1.1+ for the join relationship checks). Install the required packages in the RStudio environment before knitting:

```r
install.packages(c(
  "rmarkdown", "dplyr", "tidyr", "readr", "stringr", "lubridate", "ggplot2",
  "lme4", "lmerTest", "emmeans", "car", "multcomp", "multcompView",
  "sf", "openxlsx", "knitr", "readxl", "purrr", "digest", "DHARMa",
  "scales", "viridis", "pbkrtest", "ragg"
), repos = "https://cloud.r-project.org")

rmarkdown::render("AFRI_CHAPTER_2_Optimized.Rmd")
# Compute without saving the final analysis export collection:
rmarkdown::render("AFRI_CHAPTER_2_Optimized.Rmd",
                  params = list(export_results = FALSE))
```

`pbkrtest` and `ragg` are optional enhancements; their availability is checked. `DT` is optional and assignment-conflict reporting falls back to `knitr::kable()` if it is absent. System libraries may be required when installing spatial/graphics packages from source. The Rmd itself does not install packages or change the working directory.

For individual chunks, run shared runtime/setup and the required upstream data chunks first. Unchanged question requests reuse their fitted objects. Start a fresh R session for this model-specification update. Pre-change models with extra random effects are rejected, and changed formula/data requests cannot silently reuse a stale registry. After deliberately changing inputs or model specifications again, start a fresh session.

The two optional **animal-period two-scale** GreenFeed thresholds remain `null`. No prespecified rule was supplied. Threshold-dependent qualifying gas models are explicitly pending. This does **not** add a threshold to the Global pasture-period analysis; its existing valid-visit rules and aggregation remain. The separate Dressler whole-season 40-visit rule is preserved.
