# https://www.rdocumentation.org/packages/openxlsx/versions/4.1.5/topics/read.xlsx
# https://shihs.github.io/blog/r/2018/02/26/R-%E5%A6%82%E4%BD%95%E8%AE%80%E5%8F%96Excel%E6%AA%94%E6%A1%88/
library(openxlsx)
ken <- openxlsx::read.xlsx("https://www.eia.gov/petroleum/supply/weekly/wcrudeoilstorage.xlsx", colNames = FALSE,sheet = 2, skipEmptyRows = FALSE) %>% 
  tibble::as.tibble()


convertToDate(ken[3,3])

ken %>% 
    tibble::as.tibble(options(tibble.print_min = 20))
