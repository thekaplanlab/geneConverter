#' Convert human gene synonyms to HGNC approved gene names
#'
#' This function converts a column containing human gene synonyms within a data frame
#' to HGNC appreved gene names. If the column contains a mix of gene names and gene synonyms,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing gene synonyms to be converted to gene names
#' @return dataframe object
#' @export
#'
hgncConverter2<-function(genelist, colname){

  colname2<-"Gene_name"
  colname3<-"Genename"
  tempcolname<-"Gene_synonyms"
  approved<-semi_join(genelist, human_hgnc, by = setNames(colname2, colname))
  someWOapproved<-anti_join(genelist, approved, by = colname)
  notApproved<-semi_join(someWOapproved, human_hgnc, by = setNames(tempcolname, colname))
  some<-rbind(approved, notApproved)
  non<-anti_join(genelist, some, by = colname)

  if ("Gene_name" %in% colnames(genelist) & !("Genename" %in% colnames(genelist))){
    hgnc_temp<-human_hgnc
    colnames(hgnc_temp)[1]<-"Genename"
    temp_notApproved<-left_join(notApproved, hgnc_temp, by = setNames(tempcolname, colname))
    temp_notApproved[[colname]]<-temp_notApproved$Genename
    temp_notApproved<-temp_notApproved %>% select(!Genename)
  }
  else if (!("Gene_name" %in% colnames(genelist))){
    temp_notApproved<-left_join(notApproved, human_hgnc, by = setNames(tempcolname, colname))
    temp_notApproved[[colname]]<-temp_notApproved$Gene_name
    temp_notApproved<-temp_notApproved %>% select(!Gene_name)
  }
  else {
    stop("Change the name of that damn column!")
  }

  all<-rbind(approved, temp_notApproved, non)
  return(all)

}
