# Load the necessary libraries
library(DESeq2)
library(apeglm)
library(ggplot2)
library(data.table)
library(pheatmap)

# Set the working directory and file paths
data_dir <- "/Users/nelly/Documents/Genome-Analysis/"
file_name <- "htseq_result.txt"
condition_file <- "/Users/nelly/Documents/culture.txt"
file_list <- list.files(path = data_dir, pattern = ".txt")

# Read in the first file and set row names as gene names
dataset <- read.delim(file = paste(data_dir, file_list[1], sep=""), sep = '\t', header = FALSE, row.names = 1)

# Read the file as a table
data <- read.table("/Users/nelly/Downloads/htseq_result.txt", header = FALSE)

# Read the condition file
sampleCondition <- read.table(condition_file, header = TRUE)
sampleCondition <- sampleCondition[, c("culture")]

# Extract the row names from the first column of the data
row_names <- data[, 1]
data <- data[, -1]  # Remove the first column from the data

# Convert the data to a matrix
data_matrix <- as.matrix(data)

# Set the row names of the data matrix
rownames(data_matrix) <- row_names

# Sort the data alphabetically by row names (assuming genes are in rows)
data_sorted <- data_matrix[order(rownames(data_matrix)), ]
data_sorted <- data_sorted[-(1:5), ]

# Create a metadata dataframe
metaData <- data.frame(id = c("ERR2036629", "ERR2036630", "ERR2036631", "ERR2036632", "ERR2036633"),
                       condition = c("Continuous", "Continuous", "Bioleaching", "Bioleaching", "Continuous"))

# Create a DESeqDataSet object
dds <- DESeqDataSetFromMatrix(countData = data_sorted, 
                              colData = metaData, 
                              design = ~ condition)
colnames(dds) <- c("ERR2036629", "ERR2036630", "ERR2036631", "ERR2036632", "ERR2036633")

# Perform differential expression analysis
dds <- DESeq(dds)

# Generate the results table
results <- results(dds)

# Order the results table by the smallest p-value
results <- results[order(results$pvalue), ]

# Summarize the results
summary(results)

# Create another results table with an alpha value of 0.05
alpha <- 0.05
alpha_results <- subset(results, padj <= alpha)

# Generate plotMA
plotMA(dds, ylim = c(-2, 2))

#Convert DESeqResults to data.frame
results_df <- as.data.frame(results)

# Remove BaseMean from resulting table
results_df <- results_df[, -which(colnames(results_df) == "baseMean")]

# Generate volcano plot
volcano_plot <- ggplot(results_df, aes(x = log2FoldChange, y = -log10(pvalue))) +
  geom_point(aes(color = padj < alpha), alpha = 0.8) +
  geom_hline(yintercept = -log10(alpha), color = "red", linetype = "dashed") +
  labs(x = "log2 Fold Change", y = "-log10 p-value", title = "Volcano Plot") +
  theme_minimal()
print(volcano_plot)

# Generate PCA plot
rld <- rlog(dds)
pca_data <- plotPCA(rld, intgroup = "condition", returnData = TRUE)
# Generate PCA plot
pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 3) +
  labs(x = "PC1", y = "PC2", title = "PCA Plot") +
  theme_minimal()
print(pca_plot)

# Select 20 genes belonging to functional categories for heatmap
selected_genes <- rownames(results)[1:20]
heatmap_data <- assay(rld)[selected_genes, ]

# Create a heatmap of the selected genes
heatmap_plot <- pheatmap(heatmap_data, 
                         show_rownames = TRUE,
                         cluster_rows = TRUE,
                         cluster_cols = FALSE,
                         main = "Heatmap of 20 Genes",
                         fontsize = 8)

# Calculate the number of upregulated and downregulated genes in bioleaching vs continuous
upregulated_genes <- subset(results, log2FoldChange > 0 & padj <= alpha)
downregulated_genes <- subset(results, log2FoldChange < 0 & padj <= alpha)

num_upregulated <- nrow(upregulated_genes)
num_downregulated <- nrow(downregulated_genes)

# Print the number of upregulated and downregulated genes
cat("Number of upregulated genes: ", num_upregulated, "\n")
cat("Number of downregulated genes: ", num_downregulated, "\n")
