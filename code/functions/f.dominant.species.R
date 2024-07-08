f.dominant.species <- function(data,treshold,type){
  if (type=="cpue"){
    data <- data %>% 
      group_by(Meetplaatscode,Datum,plaats,soort,maand) %>% 
      summarize(CPUE=sum(CPUE)) %>%
      ungroup() %>%
      group_by(plaats,soort,maand) %>%
      summarize(CPUE=mean(CPUE)) %>%
      ungroup() %>%
      group_by(plaats,maand) %>%
      mutate(sum_aantal=sum(CPUE,na.rm=TRUE))
    data$percent_aantal <- data$CPUE/data$sum_aantal
  
    specieslist.temp <- unique(data$soort[which(data$percent_aantal>treshold)])
    data$soort[which(!data$soort %in% specieslist.temp)]="rest"
    
    data <- data %>%
      dplyr::group_by(soort,plaats,maand) %>%
      dplyr::summarise_at(vars(-group_cols(),-sum_aantal),mean,na.rm=TRUE)
  }
  if (type=="aantal"){
    data <- data %>% 
      group_by(plaats,soort,maand) %>% 
      summarize(Taxon.aantal=sum(Taxon.aantal)) %>%
      ungroup() %>%
      group_by(plaats,maand) %>%
      mutate(sum_aantal=sum(Taxon.aantal,na.rm=TRUE))
    data$percent_aantal <- data$Taxon.aantal/data$sum_aantal
    
    specieslist.temp <- unique(data$soort[which(data$percent_aantal>treshold)])
    data$soort[which(!data$soort %in% specieslist.temp)]="rest"
    
    data <- data %>%
      dplyr::group_by(soort,plaats,maand) %>%
      dplyr::summarise_at(vars(-group_cols(),-sum_aantal),sum,na.rm=TRUE)
  }
  return(data)
}