library(targets)


getwd()

options(stringsAsFactors = F)
tar_option_set(packages = c("dplyr", "ggplot2", "tidyr"))

# functions in seperate script
source('scripts\\functions.R')



list(
  # pl94 census
  tar_target(
    raw_pl94_file,  # r object name
    "data/dat_pl94_2010_raw.csv",  # sub in _2020_ or _2020_leg_
    format = "file"
  ),
  
  tar_target(
    df_pl94_raw,
    read.csv(raw_pl94_file)
  ),
  tar_target(
    df_pl94_clean,  # df_pl94_clean = clean_pl94(df_pl94_raw)
    df_pl94_raw
  ),
  
  # # cnc data
  # tar_target(
  #   raw_cnc_file,
  #   "data/dat_cnc_raw.csv",
  #   format = "file"
  # ),
  # 
  # tar_target(
  #   df_cnc_raw,
  #   read.csv(raw_cnc_file)
  # ),
  # tar_target(
  #   df_cnc_clean,  # df_cnc_clean = clean_cnc(df_cnc_raw)
  #   df_cnc_raw  
  # ),
  # 
  # # non response analysis using cnc raw
  # 
  # # cnc imputed
  # tar_target(
  #   raw_cnc_file,
  #   "data/dat_cnc_imp.csv",  # imputed
  #   format = "file"
  # ),
  # 
  # # birth death adjustments for responders before April 1st
  # # likely skip, no adjustment
  # 
  # # join cnc_raw + cnc_adj + pl94
  # tar_target(
  #   df_pl94cnc_clean,
  # df_cnc_raw %>% 
  #   left_join(x=.,y=df_pl94) %>%
  #   left_join(x=.,y=df_cnc_adj)
  # ),
  
  # plot cnc vs pl94
  tar_target(plot_cnc_pl94, 
             # create_plot(df_pl94cnc_clean)
             create_plot(df_pl94_clean)  # placeholder
             )
  
  # tables cnc vs pl94
  # 1 agg table pooling 200 blocks
  # 200 tables, one for each block (appendix/supplement)
  
  # sampling weights to upscale blocks to counties
  
)

# tar_make()
# tar_visnetwork()
# tar_manifest()
# tar_load(plot_cnc_pl94)
# hist()