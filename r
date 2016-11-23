##################################

rm(list = ls())
getwd()
setwd('')
library(dplyr)
library(RMySQL)

#following scripts are used to select which columns are used as key

#isTRUE(sum(!duplicated(Penalties[c("provnum",'pnlty_type',"pnlty_date",'order_by_date')])) == dim(Penalties)[1])
#isTRUE(sum(!duplicated(QualityMsrMDS[c("PROVNUM","MSR_CD")])) == dim(QualityMsrMDS)[1])
#answer is True. Therefore, we could use the combination of 'provider num' and 'msr_cd'as primary key of this table
#isTRUE(sum(!duplicated(QualityMsrClaims[c("PROVNUM","MSR_CD")])) == dim(QualityMsrClaims)[1])
#answer is True. Therefore, we could use the combination of 'provider num' and 'msr_cd'as primary key of this table
#QualityMsr <- merge(QualityMsrMDS, QualityMsrClaims, by = c('PROVNUM','PROVNAME','ADDRESS','CITY','STATE','ZIP','MSR_CD',
#                                                            'MSR_DESCR','STAY_TYPE','FIVE_STAR_MSR','FILEDATE'), all = T)#as we can see, outer join QualityMsrMDS and QualityMsrClaims would give us a fine table for further usage
#isTRUE(sum(!duplicated(Deficiencies[c("provnum","survey_date_output","SurveyType","tag")])) == dim(Deficiencies)[1])# use these four as primary key
#isTRUE(sum(!duplicated(ProviderInfo[c("provnum")])) == dim(ProviderInfo)[1])# use provnum as key
#isTRUE(sum(!duplicated(SurveySummary[c("PROVNUM","cycle")])) == dim(SurveySummary)[1])
########
#connet database
require("RPostgreSQL")
require('RMySQL')
library(dplyr)
# create a connection
# save the password that we can "hide" it as best as we can by collapsing it
pw <- {
 
}

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")
# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database
con <- dbConnect(drv, dbname = "postgres",
                 host = "localhost", port = 5432,
                 user = "openpg", password = pw)

dbExistsTable(con, "ownership")
#if here report 'true', you are connected to postgre database
SurveySummary <- read.csv('SurveySummary_Download.csv')[,c(-3,-4,-5,-6)] 
SurveySummary<-SurveySummary[!SurveySummary['F_SURVEY_DATE'] =='',]
dbWriteTable(con, "surveysummary", value = SurveySummary, append = TRUE, row.names = FALSE)


StateAverages <- read.csv('StateAverages_Download.csv') 
StateAverages <- StateAverages[,c(names(StateAverages)[-1],'STATE')]
dbWriteTable(con, 'stateaverages', StateAverages, append = T, row.names = F )

ProviderInfo <- read.csv('ProviderInfo_Download.csv') 
ProviderInfo[ ProviderInfo == "" ] = NA
ProviderInfo[ ProviderInfo == "." ] = NA
dbWriteTable(con, 'providerinfo', ProviderInfo, append = T, row.names = F)

QualityMsrMDS <- read.csv('QualityMsrMDS_Download.csv')[,c(-3,-4,-5,-6)] 
dbWriteTable(con, 'qualitymsrmds', QualityMsrMDS, append = T, row.names= F )

QualityMsrClaims <-read.csv('QualityMsrClaims_Download.csv')[,c(-3,-4,-5,-6)] 
QualityMsrClaims$measure_start_yr =  unlist(strsplit(as.character(QualityMsrClaims$MEASURE_PERIOD),'[Q-]'))[1]
QualityMsrClaims$measure_start_qt =  unlist(strsplit(as.character(QualityMsrClaims$MEASURE_PERIOD),'[Q-]'))[2]
QualityMsrClaims$measure_end_yr =  unlist(strsplit(as.character(QualityMsrClaims$MEASURE_PERIOD),'[Q-]'))[3]
QualityMsrClaims$measure_end_qt =  unlist(strsplit(as.character(QualityMsrClaims$MEASURE_PERIOD),'[Q-]'))[4]
QualityMsrClaims <- QualityMsrClaims[ ,c('PROVNUM','PROVNAME','MSR_CD','MSR_DESCR','STAY_TYPE','SCORE_ADJUSTED','SCORE_OBSERVED',
                                        'SCORE_EXPECTED','SCORE_FN','FIVE_STAR_MSR','measure_start_yr',
                                          'measure_start_qt','measure_end_yr','measure_end_qt','FILEDATE')]
dbWriteTable(con, 'qualitymsrclaims', QualityMsrClaims, append = T, row.names= F )

Deficiencies <- read.csv('Deficiencies_Download.csv')[,c(-3,-4,-5,-6)]
Deficiencies[ Deficiencies == "" ] = NA
dbWriteTable(con, 'deficiencies', Deficiencies, append= T, row.names = F)

Ownership <- read.csv('Ownership_Download.csv')[,c(-3,-4,-5,-6)]
Ownership$ASSOCIATION_DATE = unlist(strsplit(as.character(Ownership$ASSOCIATION_DATE),' '))[2]
Ownership <- Ownership[,c('ROLE_DESC','PROVNUM','PROVNAME','OWNER_TYPE','OWNER_PERCENTAGE','ASSOCIATION_DATE',
                        'OWNER_NAME','filedate')]
dbWriteTable(con, 'ownership', Ownership, append =T ,row.names = F)

Penalties <- read.csv('Penalties_Download.csv')[,c(-3,-4,-5,-6)]
Penalties[ Penalties == "" ] = NA
# because some nursing house penaltied several times at the same day, we give each penalty a number
Penalties['order_key'] = c(1:nrow(Penalties))
Penalties <- Penalties[ ,c(names(Penalties)[-8],'filedate')]
dbWriteTable(con, 'penalties', Penalties, append = T, row.names = F)
# I really can't make a good column, so I created a naive key here.

ProviderInfo <- read.csv('ProviderInfo_Download.csv')
ProviderInfo [ProviderInfo == '.'] = NA
ProviderInfo [ProviderInfo == ''] = NA
dbWriteTable(con, 'providerinfo', ProviderInfo, append = T, row.names = F)

#ALTER TABLE qualitymsrclaims ALTER COLUMN provnum TYPE character varying(6); 
#GRANT SELECT ON deficiencies TO PUBLIC;
#GRANT INSERT ON deficiencies TO PUBLIC ;
#GRANT UPDATE ON deficiencies TO PUBLIC;
