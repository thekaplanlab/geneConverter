#' Convert mouse gene synonyms to NCBI mouse gene names
#'
#' This function converts a column containing mouse gene synonyms within a data frame
#' to mouse NCBI gene names. If the column contains a mix of mouse gene names and mouse gene synonyms,
#' only mouse gene synonyms will be converted to mouse gene names and mouse gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing mouse gene synonyms to be converted to mouse gene names
#' @param drop If it is TRUE, it will delete row or rows which there is no match between mouse gene synonyms and mouse gene names
#'
#' @return data frame object
#' @export
#'


synoMouse<-function(genelist, colname, drop = FALSE){

  genelist_old  <- genelist
  names(mouse_synonyms)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(mouse_synonyms$Gene_synonyms))
  bg5<-mouse_synonyms[mouse_synonyms$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% mouse_synonyms$Gene_name))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }
  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% mouse_synonyms$Gene_name_temp) && length(mouse_synonyms$Gene_name_temp[which(mouse_synonyms$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-mouse_synonyms$Gene_name_temp[which(mouse_synonyms$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }

  if (drop == TRUE) {
    index <- genelist[[colname]] %in% genelist_old[[colname]]
    genelist <- genelist[!index,]
  }

  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}
