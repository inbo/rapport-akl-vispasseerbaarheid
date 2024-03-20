f.dominant.species <- function(data,treshold){
  data <- data %>% 
    group_by(plaats,Taxon.naam,maand) %>% 
    summarize(Taxon.aantal=sum(Taxon.aantal)) %>%
    ungroup() %>%
    group_by(plaats,maand) %>%
    mutate(sum_aantal=sum(Taxon.aantal,na.rm=TRUE))
  data$percent_aantal <- data$Taxon.aantal/data$sum_aantal

  specieslist.temp <- unique(data$Taxon.naam[which(data$percent_aantal>treshold)])
  data$Taxon.naam[which(!data$Taxon.naam %in% specieslist.temp)]="rest"
  
  data <- data %>%
    dplyr::group_by(Taxon.naam,plaats,maand) %>%
    dplyr::summarise_at(vars(-group_cols(),-sum_aantal),sum,na.rm=TRUE)
  return(data)
}