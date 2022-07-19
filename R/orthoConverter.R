#' Convert C. elegans, D. melanogaster, M. musculus, R. norvegicus, D. rerio and,
#' S. cerevisiae gene names to human gene names.
#'
#' This function converts a column containing gene names of given organisms within a data frame
#' to human gene names. If the column contains a mix of these organisms and Human gene names,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A data frame object
#' @param colname Name of the column containing gene synonyms to be converted to human gene names
#' @param ctype The type of creature whose gene names will be changed
#' @param drop If it is TRUE, it will delete row or rows which there is no match between selected creature and human
#'
#' @return Data frame object
#' @export
#'

orthoConverter<-function(genelist, colname, ctype, drop = FALSE){

  genelist_old  <- genelist
  names(ctype)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(ctype$Gene_synonyms))
  bg5<-ctype[ctype$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% ctype$Gene_name_temp))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }
  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% ctype$Gene_name_temp) && length(ctype$Gene_name_temp[which(ctype$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-ctype$Gene_name_temp[which(ctype$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }

  if (drop == TRUE) {
    index <- genelist[[colname]] %in% genelist_old[[colname]]
    genelist <- genelist[!index,]
  }

  colnames(genelist)[which(names(genelist) == colname)] <- "converted_genes"
  return(genelist[,1:(length(genelist)-1), drop = FALSE])

}



