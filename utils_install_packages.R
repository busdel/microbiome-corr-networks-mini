pkgs <- c("ExperimentHub","compositions","readr","dplyr","scales","igraph","ggplot2","forcats")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}