#' Convert human gene synonyms to NCBI gene names
#'
#' This function converts a column containing human gene synonyms within a data frame
#' to NCBI gene names. If the column contains a mix of gene names and gene synonyms,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A data frame object
#' @param colname Name of the column containing human gene synonyms to be converted to human NCBI gene names
#' @param drop If it is TRUE, it will delete row or rows which there is no match between human gene synonyms and human NCBI gene names
#'
#' @return Data frame object
#' @export
#'


ncbiConverter<-function(genelist, colname, drop = FALSE){

  genelist_old  <- genelist
  names(human_ncbi)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(human_ncbi$Gene_synonyms))
  bg5<-human_ncbi[human_ncbi$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% human_ncbi$Gene_name))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }

  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% human_ncbi$Gene_name_temp) && length(human_ncbi$Gene_name_temp[which(human_ncbi$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-human_ncbi$Gene_name_temp[which(human_ncbi$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }

  if (drop == TRUE) {
    index <- genelist[[colname]] %in% genelist_old[[colname]]
    genelist <- genelist[!index,]
  }

  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}


