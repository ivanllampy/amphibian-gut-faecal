##### Load required packages #####
library(qiime2R) 
library(phyloseq)

##### Import dataset #####
# Import feature table (ASV table) (.qza)
qza <- read_qza("feature-table.qza")                                            # Import taxonomy table from QIIME2 output (.qza) file as R object
feature_table <- as.data.frame(qza$data)                                        # Transform for easier manipulation                                    
# Import metadata (.csv)
metadata<-read.csv("metadata.csv", row.names = 1, header =TRUE)                 # Import metadata in csv format
# Import taxonomy table (.qza)
taxonomy<-read_qza("taxonomy.qza")                                              # Import taxonomy table from QIIME2 output (.qza) file as R object
split_taxonomy<-parse_taxonomy(taxonomy$data)                                   # Transform for easier manipulation
# Combine as a phyloseq object
phyloseq <- phyloseq(otu_table(feature_table, taxa_are_rows = TRUE),            # Feature table
                          tax_table(as.matrix(split_taxonomy)),                 # Taxonomy table
                          phyloseq_metadata <- sample_data(metadata))           # Metadata
