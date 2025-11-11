# 🧬 Microbiome Correlation Network — Mini Project

Public microbiome dataset → **CLR transform** → **correlations** → **signed network** (positive/negative), with daily small improvements.

- **Dataset:** Human Microbiome Project (HMP_2012), MetaPhlAn-style relative abundances  
- **Source:** ExperimentHub (`EH5584`)
- **Day 1:** Mixed body sites (to keep setup simple).  
- **Day 2 (planned):** Stool-only + proportionality (`propr`) comparison.

---

## 🚀 Why this repo?

✅ Minimal and reproducible microbiome **co-occurrence pipeline**  
✅ Encourages **daily commits** (micro-progress)  
✅ Uses **composition-aware** processing (CLR; next: proportionality)

---

## 🔧 Run the pipeline locally

```r
# 0) Install dependencies (R >= 4.2)
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ExperimentHub")
install.packages(c("compositions","readr","dplyr","scales","igraph","ggplot2","forcats"))

# 1) CLR + Spearman correlation network (edges + nodes)
source("scripts/01_CLR_Spearman_network.R")

# 2) Summaries + Louvain community detection + hub tables
source("scripts/02_summaries_modules.R")

# 3) Publication-style figures (barplot, histogram, heatmap)
source("scripts/03_figures_bar_hist_heatmap.R")

# 4) Signed network visualization (green = positive, red = negative)
source("scripts/04_network_signed_plot.R")

# 3) Signed network (labels, green=positive / red=negative)
source("scripts/01c_signed_plots.R")

# 4) Publication-style bar/hist/heatmap figures
source("scripts/01d_figures_bar_hist_heatmap.R")
