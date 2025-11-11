# 🧬 Microbiome Correlation Network — Mini Project

> Public microbiome dataset → CLR transform → correlations → signed network (positive/negative), with daily small improvements.

**Dataset:** Human Microbiome Project (HMP_2012) relative abundances (MetaPhlAn-style) via ExperimentHub (`EH5584`).  
**Scope (Day 1):** Mixed body sites (all HMP_2012) to keep setup simple; Day 2 narrows to **stool** or a stool-only dataset.

---

## Why this repo?
- Shows an end-to-end, reproducible **co-occurrence pipeline**
- Designed for quick **daily commits** (mini improvements)
- Uses **composition-aware practices** (CLR; next: proportionality)

---

## Reproduce locally

```r
# 0) Install deps (R >= 4.2 recommended)
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ExperimentHub")
install.packages(c("compositions","readr","dplyr","scales","igraph","ggplot2","forcats"))

# 1) Run Day 1 pipeline
source("scripts/01_CLR_Spearman_network.R")

# 2) Summaries + modules + CSVs
source("scripts/01b_summaries_and_modules.R")

# 3) Signed network (labels, green=positive / red=negative)
source("scripts/01c_signed_plots.R")

# 4) Publication-style bar/hist/heatmap figures
source("scripts/01d_figures_bar_hist_heatmap.R")
