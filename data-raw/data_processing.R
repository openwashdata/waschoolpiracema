# Description ------------------------------------------------------------------
# R script to process uploaded raw data into a tidy, analysis-ready data frame
# Load packages ----------------------------------------------------------------
## Run the following code in console if you don't have the packages
## install.packages(c("usethis", "fs", "here", "readr", "openxlsx"))
library(usethis)
library(fs)
library(here)
library(readr)
library(openxlsx)
library(tidyverse)
library(janitor)

# Read data --------------------------------------------------------------------
Piracema_2020 <- read_csv(here::here("data-raw/Piracema_2020_clean.csv"))
Piracema_2021 <- read_csv(here::here("data-raw/Piracema_2021_clean.csv"))
Piracema_2022 <- read_csv(here::here("data-raw/Piracema_2022_clean.csv"))

# Tidy data --------------------------------------------------------------------
## Clean the raw data into a tidy format here
piracema_full <- bind_rows(Piracema_2020, Piracema_2021, Piracema_2022) # binding
piracema <- piracema_full[,-c(2,3,4,5,6,9)] # anonymization

# ethnical distribution percentages
piracema$PC_GIRL   <- piracema$QT_MAT_BAS_FEM/piracema$QT_MAT_BAS*100
piracema$PC_BOY    <- piracema$QT_MAT_BAS_MASC/piracema$QT_MAT_BAS*100
piracema$PC_WHITE  <- piracema$QT_MAT_BAS_BRANCA/piracema$QT_MAT_BAS*100
piracema$PC_BROWN  <- piracema$QT_MAT_BAS_PARDA/piracema$QT_MAT_BAS*100
piracema$PC_BLACK  <- piracema$QT_MAT_BAS_PRETA/piracema$QT_MAT_BAS*100
piracema$PC_INDIAN <- piracema$QT_MAT_BAS_INDIGENA/piracema$QT_MAT_BAS*100
piracema$PC_ASIAN  <- piracema$QT_MAT_BAS_AMARELA/piracema$QT_MAT_BAS*100
piracema$PC_ND     <- piracema$QT_MAT_BAS_ND/piracema$QT_MAT_BAS*100
piracema <- piracema %>% select(-c(QT_MAT_BAS_FEM, QT_MAT_BAS_MASC, QT_MAT_BAS_BRANCA, QT_MAT_BAS_PARDA, QT_MAT_BAS_PRETA, QT_MAT_BAS_INDIGENA, QT_MAT_BAS_AMARELA, QT_MAT_BAS_ND))

# education levels distribution
piracema$PC_CRE    <- piracema$QT_MAT_INF_CRE/piracema$QT_MAT_BAS*100
piracema$PC_PRE    <- piracema$QT_MAT_INF_PRE/piracema$QT_MAT_BAS*100
piracema$PC_PRIM_1 <- piracema$QT_MAT_FUND_AI/piracema$QT_MAT_BAS*100
piracema$PC_PRIM_2 <- piracema$QT_MAT_FUND_AF/piracema$QT_MAT_BAS*100
piracema$PC_SEC    <- piracema$QT_MAT_MED/piracema$QT_MAT_BAS*100
piracema <- piracema %>% select(-c(QT_MAT_INF_CRE, QT_MAT_INF_PRE, QT_MAT_FUND_AI, QT_MAT_FUND_AF, QT_MAT_MED))

# rename columns
piracema <- piracema %>%
  rename(YEAR = NU_ANO_CENSO, MUN_ID = CO_MUNICIPIO) %>%
  select(-c(MUN_ID)) %>% # same among all rows (3150604)
  rename(SCH_ID = CO_ENTIDADE,
         ADMIN = TP_DEPENDENCIA,
         LOC = TP_LOCALIZACAO) %>%
  select(-c(TP_LOCALIZACAO_DIFERENCIADA)) %>% # same among all rows (0)
  rename(DRINK_WATER = IN_AGUA_POTAVEL,
         PUBLIC_WATER = IN_AGUA_REDE_PUBLICA,
         BOREHOLE_WATER = IN_AGUA_POCO_ARTESIANO,
         WELL_WATER = IN_AGUA_CACIMBA,
         SURFACE_WATER = IN_AGUA_FONTE_RIO,
         NO_WATER = IN_AGUA_INEXISTENTE) %>%
  rename_with(~str_replace(., "^IN_ESGOTO", "SEWAGE"), starts_with("IN_ESGOTO")) %>%
  rename_with(~str_replace(., "^IN_LIXO", "WASTE"), starts_with("IN_LIXO")) %>%
  rename_with(~str_replace(., "^IN_BANHEIRO", "SANITARY"), starts_with("IN_BANHEIRO")) %>%
  janitor::clean_names() %>%
  select(-c(sewage_inexistente)) # same among all rows (0)

# categorical variables
waschoolpiracema <- piracema |>
  dplyr::mutate(admin = factor(admin, levels=1:4, labels=c("federal", "state", "municipal", "private"))) |>
  dplyr::mutate(loc = factor(loc, levels=1:2, labels = c("urban", "rural"))) |>
  dplyr::mutate(across(c(drink_water, public_water, borehole_water, well_water,
                         surface_water, no_water, sewage_rede_publica,
                         sewage_fossa_septica, waste_servico_coleta,
                         waste_queima, waste_enterra, waste_destino_final_publico,
                         waste_descarta_outra_area, sanitary, sanitary_ei,
                         sanitary_pne, sanitary_funcionarios, sanitary_chuveiro), as.logical))

# Export Data ------------------------------------------------------------------
usethis::use_data(waschoolpiracema, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(waschoolpiracema,
                 here::here("inst", "extdata", paste0("waschoolpiracema", ".csv")))
openxlsx::write.xlsx(waschoolpiracema,
                     here::here("inst", "extdata", paste0("waschoolpiracema", ".xlsx")))
