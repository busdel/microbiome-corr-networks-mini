library(ggplot2); library(forcats); library(readr); library(dplyr)

node_df <- read_csv("data/nodes_hmp_genus.csv", show_col_types = FALSE)
edge_df <- read_csv("data/edges_hmp_genus.csv", show_col_types = FALSE)

top_hubs <- read_csv("data/top_hubs_degree_strength.csv", show_col_types = FALSE)

p_hubs <- ggplot(top_hubs, aes(x = fct_reorder(id, degree), y = degree)) +
  geom_col() +
  coord_flip() +
  labs(x = "Genus", y = "Degree", title = "Top 10 hub genera") +
  theme_bw()

ggsave("figures/top_hubs_bar.png", p_hubs, width = 7, height = 5, dpi = 300)

p_deg <- ggplot(node_df, aes(x = degree)) +
  geom_histogram(bins = 30) +
  labs(x = "Degree", y = "Count", title = "Degree distribution") +
  theme_bw()

ggsave("figures/degree_hist.png", p_deg, width = 7, height = 5, dpi = 300)