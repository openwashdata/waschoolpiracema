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
# data_in <- read_csv("data-raw/dataset.csv")
# codebook <- read_excel("data-raw/codebook.xlsx") |>
#  clean_names()

# Tidy data --------------------------------------------------------------------
## Clean the raw data into a tidy format here
Piracema_2020 <- read_csv(here::here("data-raw/Piracema_2020_clean.csv"))
Piracema_2021 <- read_csv(here::here("data-raw/Piracema_2021_clean.csv"))
Piracema_2022 <- read_csv(here::here("data-raw/Piracema_2022_clean.csv"))

piracema_full <- bind_rows(Piracema_2020, Piracema_2021, Piracema_2022) # binding
piracema <- piracema_full[,-c(2,3,4,5,6,9)] # anonymization

# categorical variables
piracema$TP_DEPENDENCIA              <- as.factor(piracema$TP_DEPENDENCIA)
piracema$TP_LOCALIZACAO              <- as.factor(piracema$TP_LOCALIZACAO)
piracema$TP_LOCALIZACAO_DIFERENCIADA <- as.factor(piracema$TP_LOCALIZACAO_DIFERENCIADA)
piracema$IN_AGUA_POTAVEL             <- as.factor(piracema$IN_AGUA_POTAVEL)
piracema$IN_AGUA_REDE_PUBLICA        <- as.factor(piracema$IN_AGUA_REDE_PUBLICA)
piracema$IN_AGUA_POCO_ARTESIANO      <- as.factor(piracema$IN_AGUA_POCO_ARTESIANO)
piracema$IN_AGUA_CACIMBA             <- as.factor(piracema$IN_AGUA_CACIMBA)
piracema$IN_AGUA_FONTE_RIO           <- as.factor(piracema$IN_AGUA_FONTE_RIO)
piracema$IN_AGUA_INEXISTENTE         <- as.factor(piracema$IN_AGUA_INEXISTENTE)
piracema[,12:24] <- lapply(piracema[,12:24], as.factor) # should have done this instead ^^


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
piracema <- piracema %>% rename(YEAR = NU_ANO_CENSO)
piracema <- piracema %>% rename(MUN_ID = CO_MUNICIPIO)
piracema <- piracema %>% select(-c(MUN_ID)) # same among all rows (3150604)
piracema <- piracema %>% rename(SCH_ID = CO_ENTIDADE)
piracema <- piracema %>% rename(ADMIN = TP_DEPENDENCIA)
piracema <- piracema %>% rename(LOC = TP_LOCALIZACAO)
piracema <- piracema %>% select(-c(TP_LOCALIZACAO_DIFERENCIADA)) # same among all rows (0)
piracema <- piracema %>% rename(DRINK_WATER = IN_AGUA_POTAVEL)
piracema <- piracema %>% rename(PUBLIC_WATER = IN_AGUA_REDE_PUBLICA)
piracema <- piracema %>% rename(BOREHOLE_WATER = IN_AGUA_POCO_ARTESIANO)
piracema <- piracema %>% rename(WELL_WATER = IN_AGUA_CACIMBA)
piracema <- piracema %>% rename(SURFACE_WATER = IN_AGUA_FONTE_RIO)
piracema <- piracema %>% rename(NO_WATER = IN_AGUA_INEXISTENTE)
piracema <- piracema %>% rename_with(~str_replace(., "^IN_ESGOTO", "SEWAGE"), starts_with("IN_ESGOTO"))
piracema <- piracema %>% rename_with(~str_replace(., "^IN_LIXO", "WASTE"), starts_with("IN_LIXO"))
piracema <- piracema %>% rename_with(~str_replace(., "^IN_BANHEIRO", "SANITARY"), starts_with("IN_BANHEIRO"))
waschoolpiracema <- janitor::clean_names(piracema)

# Export Data ------------------------------------------------------------------
usethis::use_data(waschoolpiracema, overwrite = TRUE)
fs::dir_create(here::here("inst", "extdata"))
readr::write_csv(waschoolpiracema,
                 here::here("inst", "extdata", paste0("waschoolpiracema", ".csv")))
openxlsx::write.xlsx(waschoolpiracema,
                     here::here("inst", "extdata", paste0("waschoolpiracema", ".xlsx")))
