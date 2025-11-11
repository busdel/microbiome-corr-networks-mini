source("scripts/utils_install_packages.R")
plot_igraph <- getFromNamespace("plot.igraph", "igraph")

library(readr); library(dplyr); library(igraph); library(scales)

edge_df <- read_csv("data/edges_hmp_genus.csv", show_col_types = FALSE)
node_df <- read_csv("data/nodes_hmp_genus.csv", show_col_types = FALSE)

G <- igraph::graph_from_data_frame(edge_df, directed = FALSE)
node_df_g <- node_df[match(igraph::V(G)$name, node_df$id),]

igraph::E(G)$color <- ifelse(igraph::E(G)$rho >= 0, "forestgreen", "firebrick3")
igraph::E(G)$width <- scales::rescale(abs(igraph::E(G)$rho), to = c(0.5,3))
v_size <- scales::rescale(node_df_g$degree, to = c(8,22))

set.seed(42)
lay <- igraph::layout_with_fr(G, niter = 4000) * 2.5

png("figures/network_signed_labeled_spaced.png", width = 1800, height = 1400, res = 200)
plot_igraph(
  G, layout = lay,
  vertex.label = V(G)$name,
  vertex.label.cex = 0.9,
  vertex.size = v_size,
  vertex.color = node_df_g$module,
  edge.color = E(G)$color,
  edge.width = E(G)$width
)
dev.off()

cat("✅ Network plot saved: figures/network_signed_labeled_spaced.png")