source("scripts/utils_install_packages.R")

library(ExperimentHub)
library(compositions)
library(readr)
library(dplyr)

eh <- ExperimentHub()
mat_all <- eh[["EH5584"]]
mat <- mat_all

is_genus <- grepl("(^|\\|)g__", rownames(mat)) & !grepl("(^|\\|)s__", rownames(mat))
mat_g <- mat[is_genus, , drop = FALSE]

genus <- sub(".*\\|", "", rownames(mat_g))
genus <- sub("^g__", "", genus)
rownames(mat_g) <- genus
mat_g <- rowsum(mat_g, group = rownames(mat_g))

prev <- rowSums(mat_g > 0)
keep <- prev >= ceiling(ncol(mat_g) * 0.10)
mat_f <- mat_g[keep, , drop = FALSE]

mat_rel <- sweep(mat_f, 2, colSums(mat_f), "/")
mat_rel[mat_rel == 0] <- 1e-6
mat_clr <- apply(mat_rel, 2, compositions::clr)
mat_clr <- as.matrix(mat_clr)
sp <- rownames(mat_clr)

S <- suppressWarnings(cor(t(mat_clr), method = "spearman", use = "pairwise.complete.obs"))
n <- ncol(mat_clr)
Tstat <- S * sqrt((n - 2) / pmax(1e-9, 1 - S^2))
P <- 2 * pt(-abs(Tstat), df = n - 2)

padj <- matrix(0, nrow(S), ncol(S), dimnames = dimnames(S))
ut <- upper.tri(P)
padj[ut] <- p.adjust(P[ut], method = "BH")
padj <- padj + t(padj)
diag(padj) <- 0

thr_r <- 0.30; thr_fdr <- 0.05
sel <- which(upper.tri(S) & (abs(S) >= thr_r) & (padj <= thr_fdr), arr.ind = TRUE)

edge_df <- tibble(
  source = sp[sel[,1]],
  target = sp[sel[,2]],
  rho    = S[sel],
  fdr    = padj[sel]
)

node_df <- tibble(
  id = sp,
  degree = 0L,
  strength = 0
)

dir.create("data", showWarnings = FALSE)
readr::write_csv(edge_df, "data/edges_hmp_genus.csv")
readr::write_csv(node_df, "data/nodes_hmp_genus.csv")

cat(sprintf("✅ CLR + Spearman complete | Genera: %d | Edges: %d\n",
            nrow(node_df), nrow(edge_df)))
