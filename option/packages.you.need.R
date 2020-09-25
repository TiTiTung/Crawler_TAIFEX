#==========================================================================
# T-T-Tung
#=======================下載物件===========================================
# 有一些必要的 Packages 是一定要載的！
#==========================================================================
{
  if (!is.element("dplyr", installed.packages()[,1])) {
    install.packages("dplyr", dep = TRUE)
    require("dplyr", character.only = TRUE)
  } else {
    require("dplyr", character.only = TRUE)
  }
  
  if (!is.element("magrittr", installed.packages()[,1])) {
    install.packages("magrittr", dep = TRUE)
    require("magrittr", character.only = TRUE)
  } else {
    require("magrittr", character.only = TRUE)
  }
  
  if (!is.element("stringr", installed.packages()[,1])) {
    install.packages("stringr", dep = TRUE)
    require("stringr", character.only = TRUE)
  } else {
    require("stringr", character.only = TRUE)
  }
  
  if (!is.element("lubridate", installed.packages()[,1])) {
    install.packages("lubridate", dep = TRUE)
    require("lubridate", character.only = TRUE)
  } else {
    require("lubridate", character.only = TRUE)
  }
  
  if (!is.element("quantmod", installed.packages()[,1])) {
    install.packages("quantmod", dep = TRUE)
    require("quantmod", character.only = TRUE)
  } else {
    require("quantmod", character.only = TRUE)
  }
  
  # 可以處理EXCEL資料
  if (!is.element("openxlsx", installed.packages()[,1])) {
    install.packages("openxlsx", dep = TRUE)
    require("openxlsx", character.only = TRUE)
  } else {
    require("openxlsx", character.only = TRUE)
  }
  
  if (!is.element("tibble", installed.packages()[,1])) {
    install.packages("tibble", dep = TRUE)
    require("tibble", character.only = TRUE)
  } else {
    require("tibble", character.only = TRUE)
  }
  
  if (!is.element("highcharter", installed.packages()[,1])) {
    install.packages("highcharter", dep = TRUE)
    require("highcharter", character.only = TRUE)
  } else {
    require("highcharter", character.only = TRUE)
  }
  
  na.replace <- function(object, replacement) {
    na.index <- is.na(object)
    object[na.index] <- replacement
    return(object)
  }
}
