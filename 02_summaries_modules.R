library(igraph); library(dplyr); library(readr)

edge_df <- read_csv("data/edges_hmp_genus.csv", show_col_types = FALSE)
node_df <- read_csv("data/nodes_hmp_genus.csv", show_col_types = FALSE)

G <- igraph::graph_from_data_frame(edge_df, directed = FALSE)

node_df <- node_df |>
  mutate(
    degree   = igraph::degree(G)[id],
    strength = igraph::strength(G, weights = abs(igraph::E(G)$rho))[id]
  )

com <- igraph::cluster_louvain(G)
node_df$module <- com$membership[id]

write_csv(node_df, "data/nodes_hmp_genus.csv")

top_hubs <- node_df |> arrange(desc(degree)) |> slice_head(n = 10)
write_csv(top_hubs, "data/top_hubs_degree_strength.csv")

top_edges_pos <- edge_df |> arrange(desc(rho)) |> slice_head(n = 15)
top_edges_neg <- edge_df |> arrange(rho) |> slice_head(n = 15)

write_csv(top_edges_pos, "data/top_edges_positive.csv")
write_csv(top_edges_neg, "data/top_edges_negative.csv")

cat("✅ Summaries + Louvain modules saved.\n")