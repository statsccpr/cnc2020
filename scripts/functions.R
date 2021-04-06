# all the functions


# if pl94 data in long format

df_pl94_long = readr::read_csv(file = "/data/prototype/dat_pl94_2010_long.csv")
str(df_pl94_long)

library(tidyr)
df_use = pivot_wider(id_cols = id,
            names_from = var_pl94_use,
            values_from = count,
            data=df_pl94_long)

str(df_use)
View(df_use)

# rename
# P0020004	tot_a0p_r1p_all_hl_n	P0040004	tot_a18p_r1p_all_hl_n
# drop the r1p

# tidyr::split long data to primary keys as 
# agegrp:0p/18p , race:w/b/a/. , hl:n/y



# # on cnc data, have corresponding version matching pl94 
# name_var_cnc_raw
# 
# name_var_pl94_raw, name_var_cnc_raw
# P0020002,  P0020002+P0020002
# cnc+adjusted needs to post process and collapse race categories

# # merge in design info like 
# htc
# block, agegrp,race 


create_plot = function(df_use){
  require(ggplot2)
  ggplot(data = df_use,
         aes(x=tot_a0p, y=tot_a0p_r1_all))+
    
    # adding ref line, exclude geom_point(aes(x=tot_pl94,y=tot_pl94)) + 
    
    # # y=x identity line is pl94
    # geom_abline(intercept=0,slope=1,alpha=0.1)+
    # geom_point(aes(x=tot_pl94,y=tot_cnc_raw),shape = 17) +
    # geom_point(aes(x=tot_pl94,y=tot_cnc_adj),shape = 15)+
    
    # horizontal at 0 line is pl94
    # geom_abline(intercept=0,slope=0,alpha=0.5,size=0.01) +
    
  geom_abline(intercept=0,slope=1,alpha=0.1) +
    geom_point(aes(x=log(tot_a0p), y=log(tot_a0p_r1_all)),shape = 17) +
    # geom_point(aes(x=(tot_a0p), y=(tot_a0p_r1_all)),shape = 17) +
    
    # geom_point(aes(x=tot_pl94,y=tot_cnc_raw-tot_pl94),shape = 17) +
    # geom_point(aes(x=tot_pl94,y=tot_cnc_adj-tot_pl94),shape = 15)+
    
    
    # above 0 means cnc has more than pl94
    # below 0 means cnc has less than pl94
    # facet_wrap(~type_htc,ncol = 2) + 
    ylab('Total People') +
    xlab('Total People in PL94') +
    labs(subtitle="Each block has 3 values: PL94 (horizontal position), CNC raw (triangle), and CNC adjusted (square)") +
    labs(title="Points above (below) the reference line are CNC totals that are higher (lower) than the PL94") +
    labs(caption="can color groups by other info like: race-ethnicity / hard to count / land cover") +
    # coord_flip() +
    theme_minimal() 
}