library(tidyverse)

#Raw data downloaded from https://depmap.org/portal/download/all/. 
#Raw data too large to keep in repository. 
metadata = read.csv("../DepMap_23Q2_raw/Model.csv")
mutation = read.csv("../DepMap_23Q2_raw/OmicsSomaticMutations.csv")
expression = read.csv("../DepMap_23Q2_raw/OmicsExpressionProteinCodingGenesTPMLogp1.csv")


#Simplify mutation data for classroom use
#Pick genes that are Cosmic Hotspot, Driver, LikelyDriver, LoF
#Description of these criteria found https://storage.googleapis.com/shared-portal-files/Tools/%5BDMC%20Communication%5D%2022Q4%20Mutation%20Pipeline%20Update.pdf
mutation = summarise(group_by(mutation, ModelID, HugoSymbol),
                            mutated = ifelse(length(which(CosmicHotspot == "True" | 
                                                          Driver == "True" | LoF == "True" |
                                                          LikelyDriver == "True")) >= 1, TRUE, NA))
mutation = pivot_wider(mutation, names_from = "HugoSymbol", values_from = "mutated")

idx = apply(mutation, MARGIN = 2, function(x) !all(is.na(x)))
mutation = mutation[, idx]
mutation[is.na(mutation)] = FALSE

#Clean up expression data
colnames(expression) = gsub("(.*)\\.\\..*", "\\1", colnames(expression)) 
#Subset expression data to be close to mutation data.
idx = c(1, which(colnames(expression) %in% colnames(mutation)))
expression = expression[, idx]

#Clean up colnames in mutation and expression data
colnames(mutation) = paste0(colnames(mutation), "_", "Mut")
colnames(mutation)[1] = "ModelID"
colnames(expression) = paste0(colnames(expression), "_", "Exp")
colnames(expression)[1] = "ModelID"

save(mutation, expression, metadata, file = "CCLE.RData")

