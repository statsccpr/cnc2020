# load package
library(tidyverse)
library(data.table)

#load data

df <- read.csv("all_block_level.csv", header = T, colClasses = c(id="character"))
ref <- read.csv("blocks_focus.csv", header = T, colClasses = "character")
name_key <- read.csv("name_key_pl94_2010.csv", header = T, colClasses = "character")

#df$id<-paste0(
  #formatC(df$STATE, width = 2, format = "d", flag = "0"),
  #formatC(df$COUNTY,width = 3, format= "d", flag="0"),
  #formatC(df$TRACT,width=6, format="d", flag="0"),
  #formatC(df$BLOCK,width=4, format="d", flag="0"))

#write.csv(df, "all3_geoid.csv", row.names = F)

df1 <- df%>%
  filter(id %in% ref$blockid)%>%
  select(id,P0010001,P0010002,P0010003,P0010004,P0010005,P0010006,P0010007,P0010008,P0010009,
         P0020001,P0020002,P0020003,P0020004,P0020005,P0020006,P0020007,P0020008,P0020009,P0020010,P0020011,
         P0030001,P0030002,P0030003,P0030004,P0030005,P0030006,P0030007,P0030008,P0030009,
         P0040001,P0040002,P0040003,P0040004,P0040005,P0040006,P0040007,P0040008,P0040009,P0040010,P0040011
         )

#rename P0001123 raw names to usefulnames using key_names
#?data.table::setnames()
setnames(df1,name_key$name_var_pl94_raw,name_key$name_var_pl94_use)
#create r object 'df_pl94_clean' in long format
df2 <- df1%>%
  pivot_longer(!id, names_to = "var_pl94_use", values_to = "count")

#write.csv(df2,"df_pl94_clean.csv", row.names = F)

# do the same as above but using '2020 legacy file'
# https://www.census.gov/programs-surveys/decennial-census/about/rdo/program-management.html#P3
col_classes_list<-c(STATE = "character",COUNTY = "character",
                    TRACT = "character",BLOCK = "character",
                    GEOID = "character", GEOCODE = "character")

leg_all<-read.csv('combine_leg.csv',header=T,
                colClasses = col_classes_list)

#15-digit geo code
leg_all_no_na <- filter(leg_all, SUMLEV =="750") 
# but create own state_county_tract_block would be a safer choice

leg_all_no_na$id<-paste0(
formatC(leg_all_no_na$STATE, width = 2, format = "d", flag = "0"),
formatC(leg_all_no_na$COUNTY,width = 3, format= "d", flag="0"),
formatC(leg_all_no_na$TRACT,width=6, format="d", flag="0"),
formatC(leg_all_no_na$BLOCK,width=4, format="d", flag="0"))
write.csv(leg_all_no_na, "leg_block.csv", row.names = F)

########

dl <- read.csv("leg_block.csv", header = T, colClasses = c(GEOCODE="character"))

dl1 <- dl%>%
  select(GEOCODE,P0010001,P0010002,P0010003,P0010004,P0010005,P0010006,P0010007,P0010008,P0010009,
         P0020001,P0020002,P0020003,P0020004,P0020005,P0020006,P0020007,P0020008,P0020009,P0020010,P0020011,
         P0030001,P0030002,P0030003,P0030004,P0030005,P0030006,P0030007,P0030008,P0030009,
         P0040001,P0040002,P0040003,P0040004,P0040005,P0040006,P0040007,P0040008,P0040009,P0040010,P0040011
  )

dl2 <- dl1[sample(200),] #RI blocks
#CA blocks
#df1 <- df%>%
# filter(id %in% ref$blockid)

setnames(dl2,name_key$name_var_pl94_raw,name_key$name_var_pl94_use)

dl3 <- dl2%>%
  pivot_longer(!GEOCODE, names_to = "var_pl94_use", values_to = "count")

write.csv(dl3,"dat_pl94_2020_leg.csv",row.names = F )
