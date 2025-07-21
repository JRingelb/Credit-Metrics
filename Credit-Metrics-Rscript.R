options(scipen = 99)
library(readxl)
library(dplyr)
library(tidyr)

Asset.Correlation <- read_excel("Credit-Metrics-Resources.xlsx", 
                                sheet = "Asset.Correlation")

Single.Factor <- read_excel("Credit-Metrics-Resources.xlsx", 
                            sheet = "Single.Factor")

PD.Matrix <- read_excel("Credit-Metrics-Resources.xlsx", 
                        sheet = "Historical") |>
  pivot_longer(contains("END.PD"),names_to = "End.PD", values_to = "Prob") |>
  mutate(End.PD = as.numeric(stringr::str_remove(End.PD,"End.PD.")))

PD.Transition.Matrices <- Single.Factor |>
  crossing(Asset.Correlation) |>
  crossing(PD.Matrix) |>
  group_by(Year,Initial.PD) |>
  arrange(Year,Initial.PD,desc(End.PD)) |>
  mutate(PDF = cumsum(Prob),
         PDF = case_when(PDF >1 ~ 1,
                         TRUE ~ PDF),
         PDF_Lag = lag(PDF,n=1,order_by = desc(End.PD)),
         Adjustment = (qnorm(PDF) + sqrt(Asset.Correlation)*-Z.Score)/sqrt(1-Asset.Correlation),
         Lagged_Adjustmented = (qnorm(PDF_Lag) + sqrt(Asset.Correlation)*-Z.Score)/sqrt(1-Asset.Correlation),
         Prob_Adj = pnorm(Adjustment),
         Prob_Adj_Lagged = pnorm(Lagged_Adjustmented),
         Probability = case_when(End.PD == 8 ~ Prob_Adj,
                                 TRUE ~ Prob_Adj - Prob_Adj_Lagged))

