# AFRI R Markdown revision report

The delivery contains one complete document, `AFRI_CHAPTER_2_Optimized.Rmd`, with all runtime helpers embedded. It replaces the uploaded 33,602-line document with a 21,638-line workflow and retains 45 response specifications in the final statistical reporting layer. A response specification can reuse an earlier model; it does not imply another fitted model. No scientific results were invented, and the uploaded file was left unchanged.

The latest revision removes the requested combined-gas calculations and reorganizes the final workbook while retaining the requested additive-period model specifications. Seven current combined-gas removal checks and eight current synthetic workbook checks passed. All 206 R chunks parsed, all 61 retained formula fields passed the static formula audit, and the rebuilt 57-entry Word document passed integrity and content checks. Previous additive-model and export-only checks are recorded with their original scope. Records from the preceding interaction-model revision are identified separately as historical evidence. **A full knit, study-data model execution, and study export generation remain unverified because the original HMM, BW, GreenFeed, and GIS inputs were not supplied.** The document deliberately reports unavailable models or inference instead of silently switching families or modifying the requested formulas after a singular fit.

## Requested combined-gas removal and workbook organization

Removed all five combined CH4 + CO2 response specifications: whole-season combined intensity per kg liveweight gain, whole-season combined mass per active hectare, both period-grid combined masses per active hectare, and period combined intensity per kg liveweight gain. Their period/season combined-total precursor calculations, statistical fits, EMMs, tests, labels, and reporting entries are removed. Separate CH4 and CO2 totals, per-hectare responses, liveweight-gain intensities, primary models, and maps remain. The final reporting inventory has 45 specifications; the complete catalog has 57 reporting/source/conditional entries. Previously exported study files are not automatically deleted.

`AFRI_Statistical_Results.xlsx` now begins with the preserved `Table_1_Grazing_Behaviors` table. Its original presentation, cached results, and four source models are reused, with no refit; its standalone workbook writer is removed so Table 1 has one export owner. All three former `ShrunkBW_Season` variables are included in `Table2`, and the separate `ShrunkBW_Season` worksheet is removed. The four whole-season pasture responses—CH4 g/active ha, CO2 g/active ha, area grazed ha, and LWG kg/active ha—are moved from `Table2` to `WholeSeason_Additional`. The moved LWG variable is the season-total `LWG_kg_per_active_ha_whole_season`, not the distinct daily `ADG_Land_kg_per_active_ha_day_whole_season` response. The other two publication sheets remain `Pasture_RGP` and `Animal_RGP`. Static comparison with the preceding published revision found 199 of 206 chunk bodies unchanged: seven intended chunks changed for calculation removal, registry/export-owner metadata, and workbook reporting. All seven removed calculation/response identifiers and the standalone Table 1 workbook filename are absent; both compact export-repair scripts are byte-identical. Evidence: `validation/Combined_Removal_Workbook_Scope.txt`.

Worksheet placement is explicit reporting metadata; the source analysis category, response key, dataset, fitted model, and retained inference stay linked. The model inventory and complete catalog expose this metadata as `Reported_worksheet`. The updated Word document describes the same remaining responses and sheet layout. Seven targeted removal checks and eight workbook check groups passed. The actual current publication source saved and reopened a 31-sheet synthetic workbook; no study workbook has been generated without the source data. Behavior EMMs and letters are included in the raw-result sheets; `Table1_Reference_ANOVA` contains the full cached reference Type III ANOVA rows and columns, including the intercept where present. These same behavior tests are excluded only from `Fixed_Effect_Omnibus`, so they are exported once.

## GreenFeed select masking correction

The protected setup attaches `multcomp` after `dplyr`; `multcomp` attaches MASS, whose `select(obj)` can mask `dplyr::select()`. Two GreenFeed calls were left unqualified: the rotation schedule column selection and the post-hoc grouping-letter selection in `gf_rotation_reporting_table()`. Both now explicitly use `dplyr::select()`. The setup chunk also binds `select <- dplyr::select` after all package attachments, so interactive unqualified calls resolve correctly. These corrections affect function lookup only; all scientific schedules, transformations, model specifications and export expressions otherwise remain identical.

The package-order conflict and the previous errors were reproduced in R. With MASS attached, the corrected schedule retained exactly the same 15 rows, dates, rotation assignments and factors, and the corrected reporting function retained all 30 fabricated EMM/count/P-value/letter rows. Nine targeted checks passed, including the actual setup assignment and its ability to repair the previous interactive calls. All 206 R chunks, YAML, knitr purl and extracted R parsed again. All four protected model arguments and the 33/46 unchanged-chunk count were independently confirmed. See `validation/Select_Masking_Fix_Validation.txt`. No study model, study export or full knit was executed for this correction.

## Final three-grid map path correction

The `final-three-grid-map-package` error was raised by the previous writer's conservative 240-character guard. The supplied destination also reaches the usual legacy Windows path limit, so simply removing the guard would not resolve the long destination. The revised exporter keeps the requested `01_Grazing_Behavior_Spatial_Aera/04_Maps/Three_Grid_Metrics` root and shortens only its internal metric directories to `01_LWG`, `02_CH4`, and `03_CO2`. Compact PNG suffixes `all_rgp`, `inside_rgp`, and `season` replace repeated long grid labels; complete metric and grid identifiers remain in the single map inventory.

The writer checks the complete absolute destination and temporary-render paths against the usual 260-character Windows limit, verifies the parent directory, and includes the failed path in filesystem errors. It renders to a temporary PNG before publishing the nonempty result and retains the optional ragg-to-standard-PNG fallback. It reuses the same nine plot objects and preserves 16 × 10 inch period maps, 12 × 8 inch seasonal maps, and 300 dpi. Existing analysis outputs are not automatically deleted; the compact destinations replace the long filenames for future requested exports.

`AFRI_Three_Grid_Map_Export_Fix.R` supplies the same export-only repair for an active R session. It uses `three_grid_metric_plot_objects` already in memory and does not rebuild maps, reprocess data, or refit models. This correction changes only `final-three-grid-map-package`; the other 205 of 206 R chunks are identical to the preceding revision. All 206 chunks, YAML, knitr purl and extracted R parsed successfully. For that earlier export-only revision, the then-current 62-entry model/dataset catalog, 50-row inventory and Word document were byte-identical, and the compact destinations calculated from the supplied Windows project path are 224–231 characters. Twelve targeted synthetic export checks passed on Linux. Actual Windows writes and study map exports remain unverified because the validation environment is Linux and the original inputs were not supplied. Static scope evidence is in `validation/Three_Grid_Map_Export_Scope.txt`.

The actual revised exporter produced nine synthetic PNGs and one complete inventory: period PNGs were 4,800 × 3,000 pixels and seasonal PNGs 3,600 × 2,400 pixels at 300 dpi. Cached scientific plot data, mappings, layers, labels and export specifications were preserved. Checks covered disabled exports, blocked parent-directory errors, preservation of an existing PNG during partial-render failure, temporary-file cleanup, absolute-path checks including relative destinations in a long working directory, recovery/source parity, and repeat recovery with identical output checksums. The supplied Windows destinations calculate to 224–231 characters and temporary paths to 225–226 characters. Windows guards were simulated on Linux; successful Windows writes are not claimed. Evidence is in `validation/Three_Grid_Compact_Export_Checks.csv` and `validation/Three_Grid_Compact_Export_Validation.txt`.

## Two-scale model export connection correction

For the preceding two-scale export correction, two of the 206 R chunks changed; the other 204 were identical to its preceding GitHub revision. The affected unique-model fitting, inference and diagnostic-calculation block is identical. All 206 chunks, YAML, knitr purl and extracted R parsed successfully again, and all 62 catalog entries/66 formula fields are unchanged.

The `unique-percent-use-and-endpoint-sensitivity-models` error `Error in file(con, "w") : cannot open the connection` occurs while opening an output file, rather than identifying a model-fitting failure. The former summary and diagnostic filenames embedded each complete model identifier; the previously supplied Windows project path made some destinations longer than the legacy Windows path limit. A missing or unwritable destination can produce the same error, so the corrected writers identify the exact failed destination instead of assuming one cause.

The unique two-scale exporter now uses compact summary and diagnostic filenames, such as `rgp_all_gain_sync_summary.txt` and `season_whole_gain_end_resid.png`, and records their association with the full model identifiers in `Unique_percent_use_and_endpoint_model_audit.csv`. `two_scale_write_file()` creates and verifies the parent directory, verifies a nonempty saved file, and reports the destination, character count and underlying error. It explicitly identifies a Windows path reaching the usual 260-character limit. The complete model identifiers, in-memory fits, model archive keys, data, additive-period specifications and inference remain unchanged. Unique percent-use, synchronized-window and endpoint-sensitivity results remain under `05_Two_Scale_Analysis_maps`; no existing study folders or files are automatically deleted.

`AFRI_Two_Scale_Export_Fix.R` is supplied so an active R session can save already-computed results without repeating data processing, model fitting or inference. Eight targeted portable writer checks passed using six cached synthetic models. On Linux, the corrected exporter created six summaries, 18 diagnostic PNGs, five CSVs and one model archive; the saved full model IDs and summary contents were preserved. The compact destinations calculated from the previously supplied Windows project path were 206–221 characters. These calculations do not establish successful Windows writes; actual Windows and study-data exports remain unverified. Evidence is in `validation/Two_Scale_Compact_Export_Checks.csv` and `validation/Two_Scale_Compact_Export_Validation.txt`.

## User-requested model specification update

The retained model instruction explicitly requests `TRT * SR + Period` for repeated responses and `TRT * SR + RotationPeriod` for Global GreenFeed, with only Year and physical Pasture random intercepts. It replaces the preceding revision's management-by-period interactions with an additive period main effect. All repeated pasture-period, animal-period, and optional sampling-qualified GreenFeed questions now use this structure. Protected HMM/GPS baseline models and the observed final-weight ANCOVA keep their prior specifications.

| Code / scope | Requested formula |
|---|---|
| S — baseline | `response ~ TRT * SR + (1 | Year) + (1 | Pasture)` |
| P — pasture-period | `response ~ TRT * SR + Period + (1 | Year) + (1 | Pasture)` |
| A — animal-period | `response ~ TRT * SR + Period + (1 | Year) + (1 | Pasture)` |
| F — Global GreenFeed | `response ~ TRT * SR + RotationPeriod + (1 | Year) + (1 | Pasture)` |
| C — observed final-weight ANCOVA | `FBW ~ IBW + TRT * SR + (1 | Year) + (1 | Pasture_ID)` |
| Q — sampling-qualified animal-period GreenFeed | `response ~ TRT * SR + Period + (1 | Year) + (1 | Pasture)` |

`RGP`, `Period`, and `RotationPeriod` are the respective source names for grazing period. Global GreenFeed F uses the literal `RotationPeriod` and `Year` columns in the requested formula. `Pasture_ID` and `Pasture` identify physical pastures.

`TRT * SR` includes Treatment, Stocking Rate, and their interaction. Period is added as a main effect: no Treatment × Period, Stocking Rate × Period, or Treatment × Stocking Rate × Period interaction remains. Each retained model therefore assumes the management differences are constant across periods. Main-effect period comparisons and adjusted period EMMs remain scientifically distinct outputs; no interaction P-values for removed terms are invented or reported. A complete TRT × SR × Period EMM prediction grid can still describe the adjusted combinations; that grid does not add interaction terms to the fitted formula.

F now equals the Global primary Year-random question. The former fixed-year sensitivity is removed rather than refitted as a duplicate of the primary model. Both gases retain one primary model and reuse it for downstream tables and figures. Following the latest combined-gas removal, the complete catalog has 45 final reporting entries plus 12 source/conditional entries (57 records). A and Q share a formula structure with P, while their observation units and Q qualification rule remain distinct.

Removing management-by-period interactions changes the fixed-effect assumptions and can change estimates, SEs, degrees of freedom, and P-values; numerical equivalence to the preceding revision is not claimed. The previously requested Year/Pasture-only covariance structure remains. Animal and pasture-year identifiers remain available as linkage/QC metadata, but no separate random effects or residual correlation terms are fitted for those identifiers. Within-animal repeated-measure and pasture-year residual correlation beyond the shared Year/Pasture intercepts remains a limitation. The single-pasture-per-treatment-cell limitation and withholding of unsupported confirmatory inference remain in place.

## Files supplied

- `AFRI_CHAPTER_2_Optimized.Rmd`: complete analysis, usable as a single RStudio document.
- `AFRI_Two_Scale_Export_Fix.R`: export-only recovery for existing unique two-scale productivity results in an active R session; respects `export_results`.
- `AFRI_Three_Grid_Map_Export_Fix.R`: export-only recovery for the nine already-built metric maps in an active R session; respects `export_results`.
- `Analysis_Export_Audit.csv`: 192 detailed rows covering derived datasets, QC records, retained models, reporting views, figures, spatial outputs, and export ownership.
- `Response_Model_Inventory.csv`: all 45 final reporting specifications, their data sources, scale, and observation unit.
- `Complete_Response_Model_List.csv` and `.md`: all 57 reporting/source/conditional entries, with exact formulas, model-fitting/reporting datasets and model-reuse conditions.
- `AFRI_Variables_Models_and_Datasets.docx`: Word version of the current variable/model/dataset catalog, with 57 model entries, six descriptive measure groups, and the current additive-period formulas. The Word document is included in `AFRI_Revision_Bundle.zip`.
- `Expected_Output_Directory_Tree.txt`: standalone expected output tree.
- `Revision_Metadata.json`: source/revision hashes, counts, and execution limitation.
- `validation/`: parsing, protected-model preservation, package versions/availability, and synthetic-test evidence. These are validation records, not study results.

## Changes to the protected HMM/GPS Sections 1–5.5

The user confirmed that the protected reference is the first HMM/GPS workflow through its Section 5.5, rather than the similarly numbered BW sections.

All four reference models retain identical formula, data, and REML arguments. Of the 46 protected R chunks, 33 are text-identical after line-ending normalization; another spatial chunk differs only in two comments that used the obsolete terminology. The other changes concern integration, cached calculations, applicable diagnostics, and export handling:

1. Qualified reference fitting calls as `lme4::lmer()` and cached their existing `car::Anova()` results. The original reference Type III test method remains unchanged.
2. Reused the already-created EMM grids in Table 1. Its model observations, estimates, tests, and scientific definitions remain tied to the original monthly fits; no replacement season-mean Table 1 models are fitted.
3. Preserved Shapiro–Wilk tests where applicable and added an explicit not-run status for fewer than three, more than 5,000, or constant finite residuals. Existing reference Shapiro results are reused by the later diagnostic layer. The reference raw-data distribution checks are retained separately.
4. Added parameter defaults for interactive setup and corrected the input-file absolute-path regex escaping. The setup now also binds `select <- dplyr::select` after package attachments to prevent MASS masking in interactive calls; the affected GreenFeed calls retain explicit namespaces.
5. Reused the preserved Table 1 as the first `Table_1_Grazing_Behaviors` worksheet of `AFRI_Statistical_Results.xlsx`, with its existing presentation and results. Removed its standalone workbook writer and other duplicate CSV/workbook exports; cached numerical/omnibus inputs remain available for the single reporting owner. Removed duplicate PDF copies of the reference PNG EMM figures.
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

All baseline and repeated models use only the requested Year/Pasture random intercepts. P, A, and Q use Treatment × Stocking Rate plus an additive Period main effect; F uses the additive RotationPeriod alias. BW area, Global gas, unique two-scale, final statistical fits and conditional sensitivity formulas use this same fixed-effect structure for period questions. Whole-season models retain TRT × SR and Year/Pasture. Identity columns remain available for matching observations, sample-size/design audits, and descriptive coverage checks.

Kenward–Roger is used for suitable REML fits when `pbkrtest` is available and the model has at most 3,000 observations. Satterthwaite is recorded otherwise, including preserved ML fits; the helper does not silently refit an ML model to obtain KR. Type III factor contrasts are set before new fits. Global GreenFeed F uses random Year and physical Pasture, and reuses the primary model; no separate fixed-year sensitivity remains.

The design has one physical pasture per TRT × SR cell. Repeated animals, periods, and years are not independent treatment replicates. The final design audit is repeated on each response's complete cases. Available raw management tests are labeled exploratory/conditional, confirmatory reporting values and management letters are withheld where replication is insufficient, and missing/nonfinite estimates, SEs, or tests remain missing. The protected Table 1 is preserved with its original results and the stated limitations.

Unique monthly, period, whole-window, calendar-season, raw-endpoint ANCOVA, percent-active-area, daily land-rate, season-total land-rate, and ratio questions remain distinct. The original seasonal productivity loop that sought period-grid labels in the whole-season dataset is corrected. Duplicate period ADG and equivalent land-ratio fits are consolidated; a genuinely different synchronized-window or endpoint subset remains a labeled sensitivity.

## Diagnostics and tables

Every retained Gaussian fit has applicable full-residual Shapiro–Wilk results/status, residual-versus-fitted and normal Q–Q plots, scale-location and grouped residual-SD review, fitted random variances, singularity, optimizer/convergence warnings, and dropped fixed-column metadata. Residual flags identify rows for review and do not delete them. No model is changed solely because its Shapiro P-value is significant or a variance reaches zero.

Tables consume retained results rather than refitting or recomputing EMMs. They retain model-specific n, observation and experimental-unit information, six TRT × SR EMM ± SE cells, model-based TRT/SR/TRT × SR P-values, and appropriate scoped letters. Period tables retain the additive Period main-effect test and its adjusted EMMs where needed; removed management-by-period interaction tests are omitted. Missing results use a dash and are audited. The publication layer uses one workbook for the preserved Table 1 plus four other table families and numerical/model/design/diagnostic/QC records. Table 1 is its first sheet and has no second standalone workbook writer.

## Export organization

Every old requested directory name and all obsolete framework identifiers were removed from the code. `AFRI_OUT` behavior/spatial outputs remain consolidated under the spatial package. At the user's request, unique two-scale outputs now use `05_Two_Scale_Analysis_maps` directly under `Chapter_2_Results`, as a sibling of the behavior/spatial, BW, GreenFeed, and statistical folders. Its tables, model results, figures, maps, and spatial datasets retain their numbered subfolders. Behavior, active-area, and integrated metric maps remain in `01_Grazing_Behavior_Spatial_Aera/04_Maps`; integrated datasets remain in the spatial `Integrated_Analysis/01_Tables` folder. `05_Requested_Revision_Final` is not created or referenced. Existing obsolete folders/files are not automatically deleted. Designated result files are refreshed only when exports are requested.

A final integrated writer now retains the four complete BW/productivity datasets, the descriptive behavior-period dataset, and six unique assignment/availability/map-QC tables. These had been computed without a complete final data-export owner. Whole-season daily-rate QC is kept in the statistical workbook rather than duplicated as CSV.

BW and GreenFeed final export blocks now honor `export_results = FALSE`. Report-only graphics use temporary report paths; they cannot leak into another analysis's result folder. BW's final SVG figures/maps are generated by knitr during rendering, while GreenFeed and metric-map final outputs have designated writers. Each of the nine LWG/CH4/CO2 three-grid PNGs has one exporter and one inventory.

Model RDS files support downstream reuse and are not duplicate CSV tables. Reused models keep their original export owner. A single complete session record and current-run inventory are written at the end. BW's separate checksum manifest remains a distinct integrity audit. Direct RStudio chunk execution displays BW figures; rendering is required to generate its knitr-managed SVG collection.

Expected output tree (only writers with meaningful outputs create their directories):

```text
Chapter_2_Results/
├── 01_Grazing_Behavior_Spatial_Aera/
│   ├── 01_Tables/                       # HMM data/QC and map inventory
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
│   │       ├── 01_LWG/                       # three compact PNGs
│   │       ├── 02_CH4/                       # three compact PNGs
│   │       └── 03_CO2/                       # three compact PNGs
│   ├── 05_Spatial_Data/                 # HMM/base/grid GeoPackages
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
├── 05_Two_Scale_Analysis_maps/
│   ├── 01_Tables/                       # coverage/endpoints/GPS/inference/QC
│   ├── 02_Model_Results/                # unique conditional/sensitivity RDS
│   ├── 03_Figures/                      # coverage + Diagnostics/
│   ├── 04_Maps/RGP_two_active_area_grid_maps/
│   └── 05_Spatial_Data/Whole_season_unique_active_grid.gpkg
└── 06_Statistical_Analysis/
    ├── 01_Tables/AFRI_Statistical_Results.xlsx  # Table 1 first; four other families + raw/QC
    ├── 02_Model_Results/Retained_Gaussian_LMMs.rds
    ├── 03_Figures/Diagnostics/          # newly owned model diagnostics only
    └── 06_Logs/
        ├── Complete_Analysis_Session_Info.txt
        └── Final_Export_Inventory.csv
```

## Analysis/export audit overview

The full 192-row CSV gives each source object and destination. `Preserved`, `Consolidated`, and `Corrected` describe code treatment. Every row separately states that its **study-data execution is not verified**.

| Section | Analysis / output | Source object | Final export location | Status |
|---|---|---|---|---|
| HMM 1–4 | Behaviors, movement, QC, three independent area denominators | retained HMM/daily/monthly/GPS/area objects | spatial `01_Tables`, `04_Maps`, `05_Spatial_Data` | Preserved |
| HMM 5.2–5.4 | Reference Table 1, EMMs/tests, four fitted models and plots | `table1_results`, original models/EMMs | statistical workbook first Table 1 sheet; spatial model and figure folders | Consolidated |
| BW 1–4 | Cleaning, splines, growth, whole-window ADG | `BW_daily`, `animal_spline_models`, `smooth_adg_model` | BW standard folders | Preserved / Consolidated |
| BW 5–6 | Production and three matched-area LMMs | `period_production_sf`, `pasture_use_models` | BW standard folders | Corrected to requested Year/Pasture grouping |
| GreenFeed 1–4 | Unique visits, daily/Dressler/Global means, two Year/Pasture primary models | `visit_records_unique`, `dressler_animal_system`, `gf_rotation_models` | GreenFeed standard folders | Consolidated / Corrected |
| Two-scale 4–8 | Coverage, endpoint ANCOVA, qualifying gases, percent use and distinct sensitivities | `manual_endpoint_summary`, `conditional_models`, `productivity_models` | `05_Two_Scale_Analysis_maps/{01_Tables,02_Model_Results,03_Figures,04_Maps,05_Spatial_Data}` | Preserved / Corrected |
| Integrated 9.2–9.5 | Final animal/pasture datasets and unique map/availability QC | `shrunk_bw_*`, `period_level_grazing_productivity`, `whole_season_grazing_productivity` | spatial `Integrated_Analysis/01_Tables` | Corrected |
| Statistical 9.7–9.12 | 45 response views, authoritative fits, diagnostics and design audit | `analysis_fits` and retained earlier models | owned archive/diagnostics and statistical workbook | Consolidated / Corrected |
| Publication 9.12–9.13 | Preserved Table 1 first, four other manuscript families and numerical/QC sheets | `publication_table_objects`, retained inference objects | statistical workbook | Consolidated |
| Final maps | Nine metric maps and single inventory | `three_grid_metric_plot_objects` | spatial `04_Maps/Three_Grid_Metrics/{01_LWG,02_CH4,03_CO2}` and `01_Tables` | Corrected / Consolidated |

## Validation report

| Check | Outcome | Scope / limitation |
|---|---|---|
| Static code and cross-section audit | Seven current combined-gas removal checks and scoped code comparison passed | Exactly five combined-gas models and two precursor calculations removed. On 18 fabricated period and 18 fabricated season rows, all surviving CH4/CO2/LWG values and missing/invalid-denominator handling matched the preceding revision. All other integrated source expressions, registry keys/datasets and surviving model formulas remain unchanged. Complete-code comparison preserves 199/206 chunk bodies and both compact export-recovery scripts. |
| Full model catalog formula audit | 61/61 current static formula checks passed | All 57 retained full formulas and four conditional alternatives retain TRT × SR, additive Period/source alias where applicable, only Year/Pasture random intercepts and ANCOVA IBW, with no management-by-period interactions. Evidence: `validation/Additive_Period_Formula_Audit.csv`. |
| R Markdown YAML and chunk labels | Passed current revision | Valid YAML and 206 uniquely labeled R chunks. |
| Actual R parsing | Passed current revision | 206/206 chunks, including disabled chunks; knitr purl and complete extracted-R parsing. |
| Two-scale summary and diagnostic file connections | Prior export-only correction: 8/8 targeted synthetic checks passed | Six cached model summaries, 18 PNGs, five CSVs and one RDS written on Linux; full IDs, exact summary contents, repeat-safe audit joins and cached models preserved. Disabled and zero-fit exports, missing-parent and writer-error messages verified. Windows destination lengths calculated as 206–221 characters; actual Windows/study writes remain unverified. |
| User-requested two-scale directory relocation | Prior seven runtime checks; current path audit passed | New root and five subfolders; disabled exports write nothing; fabricated CSV/figure/verified-map exports and RGP/final manifests use the new paths. That earlier directory-only revision changed one root assignment among 206 chunks. Runtime checks were performed on Linux; study GIS/data, full knit and actual Windows writes remain unverified. |
| GreenFeed select masking correction | Prior nine targeted checks passed; correction retained | Actual multcomp/MASS package-order conflict and both prior errors reproduced; corrected 15-row schedule/date classifier and 30-row fabricated reporting table preserved. Delivered setup alias also restores both previous interactive calls. Namespace lookup only; protected models unchanged. |
| Protected model argument comparison | Passed | All four reference formula/data/REML call arguments identical; 33/46 protected chunks text-identical. |
| Installed-package namespace API audit | Passed for 142 uses | Zero unavailable-function failures among checked APIs; 32 uses could not be checked because their packages were absent. |
| Shared runtime/model/diagnostic checks | Prior evidence retained | Unchanged shared helper, parameter and map-safety functions previously passed 29 synthetic checks; these records are distinct from current formula-specific tests. |
| Final export guards/inventory | Historical: 9/9 synthetic checks passed | Prior BW/GF disabled-export guards, eleven integrated CSVs, current-run inventory and no-delete checks; additive-formula changes do not themselves establish execution of study exports. |
| Statistical-layer integration | Prior additive-model evidence: 34 assertions passed | 24 primary structure/reuse/count/grid/diagnostic checks, nine Global gas provenance/empty-schema checks and one comparison-cache check. |
| Authoritative area and stale-source safeguards | Prior additive-model evidence: 25/25 assertions passed | Exact source reuse; missing, failed or unequal source unavailable; pre-change management-by-period interactions and extra random effects rejected instead of silently reused. Together with the preceding row, 59 statistical assertions passed. |
| BW source area models and reporting | Prior additive-model synthetic execution passed; source retained | Actual delivered source code fitted both additive RGP models and the unchanged seasonal model; fixed/ANOVA terms, Year/Pasture groups, fitted n, residual Shapiro tests and model-derived reporting checked for all three. |
| Global GreenFeed models and interfaces | Prior additive-model synthetic execution passed; source retained | All 47 GreenFeed chunks parsed; 459 dates plus missing dates classified; exactly two Year/Pasture Gaussian fits, KR inference, 60 EMM rows, counts/tests/letters/diagnostics/cache and common management contrasts across periods verified. No removed interaction tests or fixed-year duplicate fits. |
| Two-scale models, counts and endpoints | Prior additive-model evidence: five synthetic check groups passed | Qualified Q fits use additive Period with test-only thresholds; fitted counts after missingness, pending Q status when unset, additive P models, unchanged S/C, equivalent gain consolidation and distinct endpoint/window sensitivities checked. Actual Q analyses remain pending the user's sampling rule. |
| Publication cross-schema execution | Eight current synthetic check groups passed | Actual current source saved/reopened 31 nonempty synthetic sheets. Table_1_Grazing_Behaviors is first and preserves the original presentation. All three seasonal animal responses appear once in Table2; four season-total land responses appear once in WholeSeason_Additional; ShrunkBW_Season and combined-gas labels are absent. Existing models and numerical inputs were reused. Cached Table 1 EMMs/letters and full Type III ANOVA were preserved without duplicated behavior omnibus tests. Disabled exports, missing SE/P, typed empty results and removal of stale combined-gas rows from reporting copies were verified; original environment objects were preserved. Evidence: `validation/Workbook_Reorganization_Checks.csv` and `validation/Workbook_Reorganization_Validation.txt`. |
| Word model/dataset catalog | Current regenerated document checks passed | Rebuilt 29,051-byte DOCX contains 57 model entries, ten tables and six descriptive measure groups. ZIP integrity, Word reopening, matching response multiplicities and preserved dataset caveats, all requested formulas, removal of all seven combined-gas identifiers, worksheet-layout notes, pending Q status, hyperlinks and Unicode passed. Evidence: `validation/Word_Removal_Workbook_Validation.txt`. Visual pagination was not rendered; these are code specifications, not study results. |
| Final three-grid compact paths and writer | Prior export-only correction: 12/12 targeted synthetic checks passed | Nine PNGs and one complete inventory written on Linux, with exact 300 dpi pixel dimensions. Scientific plot content preserved; disabled exports, partial-render preservation/cleanup, blocked parents, absolute destination/temporary guards, recovery/source parity and repeated recovery checked. Supplied Windows destinations calculate to 224–231 characters; temporary paths 225–226. Actual Windows/study exports remain unverified. |
| Prior nine-map writer | Historical synthetic checks passed | Nine fabricated plots previously produced nine PNGs and one inventory with disabled/failed write handling. These are not research maps. |
| Study statistical model execution | **Not run** | Original source datasets absent. No actual n/EMM/SE/P/CLD values validated. |
| Study export creation / GIS writes | **Not run** | Original inputs absent; sf unavailable in validation runtime. Actual map appearance, geometry/equality assertions and GeoPackage writes require project inputs. |
| Full document knit | **Not run** | Source datasets absent; full application dependencies were not available. |

The validation runtime was R 4.5.0 with lme4 1.1-37, lmerTest 3.1-3, emmeans 1.10.7, and pbkrtest 0.5.4. Tested versions are recorded in `validation/Package_Versions.csv`. `lubridate`, `car`, `sf`, `readxl`, and `DHARMa` were unavailable in that local validation runtime; the complete workflow was therefore not executed. Synthetic tests isolated the installed helper dependencies and never substituted generated data for the research analysis.

Current removal/workbook evidence is separate from prior additive-model execution records and from `validation/Historical_Interaction_Models/`. The superseded 62-entry Word and 30-sheet publication checks are retained in `validation/Historical_Pre_Removal_Workbook/`; they do not validate the new first-sheet Table 1 or worksheet layout. Passing earlier model-specific tests is not presented as execution of all 45 surviving response specifications.

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

For individual chunks, run shared runtime/setup and the required upstream data chunks first. Unchanged question requests reuse their fitted objects. Start a fresh R session for the revised workflow so old combined-gas columns and model lists are not retained. The surviving model specifications remain unchanged by this removal/routing revision. Pre-change models with management-by-period interactions or extra random effects are rejected, and changed formula/data requests cannot silently reuse a stale registry. After deliberately changing inputs or model specifications again, start a fresh session.

For an already-running session affected only by `select()` masking, run the following in the Console, then rerun the failed GreenFeed chunk. Existing calculated objects can be retained; the namespace fix does not require a new session.

```r
select <- dplyr::select
```

For the two-scale productivity `file(con, "w")` export error, download `AFRI_Two_Scale_Export_Fix.R` beside the revised Rmd and run the following in the existing session:

```r
source("AFRI_Two_Scale_Export_Fix.R")
```

This script requires the already-computed productivity models, inference and diagnostic objects and only repeats their designated export operations. It does not repeat statistical analyses. If a failure still occurs, its message now identifies the exact destination, path length and filesystem error. A shorter project path or `params$output_dir` is necessary if the resulting Windows path still reaches the usual limit. Changing `params$output_dir` also requires rerunning the setup that establishes `master_output_root`; moving existing study files is not automatic.

For the final three-grid PNG path error, download `AFRI_Three_Grid_Map_Export_Fix.R` beside the revised Rmd and run it in the existing session:

```r
source("AFRI_Three_Grid_Map_Export_Fix.R")
```

Keep the current session open: the script exports the cached `three_grid_metric_plot_objects` and one inventory, without repeating map construction or analyses. It requires the established `master_output_root` and honors `export_results`. If a complete absolute destination or temporary path still reaches the Windows limit, choose a shorter output root and rerun the setup that establishes it before exporting; the repair does not move or delete existing outputs.

The two optional **animal-period two-scale** GreenFeed thresholds remain `null`. No prespecified rule was supplied. Threshold-dependent qualifying gas models are explicitly pending. This does **not** add a threshold to the Global pasture-period analysis; its existing valid-visit rules and aggregation remain. The separate Dressler whole-season 40-visit rule is preserved.
