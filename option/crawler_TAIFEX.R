source("packages.you.need.R")

#==================================================================================
# T-T-Tung
#=======================找出有開盤的日期===========================================
# 下載期交所得資料最多只能載一個月，因此先用 quantmod 抓出大盤資料，選出有開盤的時間
# 再把每個月有開盤的第一天跟最後一天選出來，塞到下載連結裡面
# ----------------------------------------------------------------------------------
# # 期交所網站:
# "https://www.taifex.com.tw/cht/3/dlOptDataDown"
# # 下載動作：
# "?down_type=1&commodity_id=TXO&commodity_id2=&queryStartDate=2020%2F09%2F01&queryEndDate=2020%2F09%2F18"
#==================================================================================
{
twii_date <- quantmod::getSymbols("^TWII", auto.assign = FALSE, 
                                  from = "2000-01-01", to=Sys.Date()) %>% time()

start_year <- 2001

for(year in start_year:( Sys.Date() %>% year()) ){
  
    for(month in sprintf('%02d', 1:12)){
      x = twii_date[str_detect(twii_date, str_c(year,"-",month,"-"))] %>% min()  
      y = twii_date[str_detect(twii_date, str_c(year,"-",month,"-"))] %>% max() 
      
        if(year  == start_year & month == sprintf('%02d', 1)){
          min.date = x
          max.date = y
        }else{
          min.date = c(min.date, x)
          max.date = c(max.date, y) 
        }
    }
}

# 剔除 NA
# 轉換成期交所抓資料需要的日期格式
# magrittr::%<>% 
min.date %<>% as.character() %>% na.omit() %>% str_replace_all("-","%2F")
max.date %<>% as.character() %>% na.omit() %>% str_replace_all("-","%2F")

downlode.operation <- str_c("?down_type=1&commodity_id=TXO&commodity_id2=&queryStartDate=",
                            min.date,"&queryEndDate=",max.date)
}

#==================================================================================
# 用 read.csv() 把資料爬進來
#==================================================================================
# n 是用來儲存第一筆下載的檔案開關，為了後面rbind(y,x)
n = 1

for(i in downlode.operation){

  URL <- str_c("https://www.taifex.com.tw/cht/3/dlOptDataDown",i)
  
  # 因為要 rbind() 所以不能用 as.tibble() 
  x <- read.csv(URL, sep = ",",header = T, stringsAsFactors = FALSE,row.names =NULL,fileEncoding='big5') 
      
      # rbind() 
      if( n == 1 ){
        y = x
        n = 0
      }else{
        y = rbind(y,x)
      }

  time.interval <- time_length(interval(time.start, Sys.time()), unit = "min") %>% round(2)
  cat("All articles are processed! Execution time: ", time.interval, "mins", "\n")
}

#==================================================================================
# 爬完資料後的後續處理
#==================================================================================
# 更改至正確的 column 名稱
colnames(y) <- c("date", "contract", "contract.month", "strike.price", "call.put", "open", "high", 
                 "low", "close", "volume", "settlement.price", "OI", "Best.Bid",	"Best.Ask",	
                 "historical.high",	"historical.low",	"Trading.Halt", "trading.session","empty")

y$call.put %<>% stringr::str_replace_all("買權", "call")
y$call.put %<>% stringr::str_replace_all("賣權", "put")

y$trading.session %<>% stringr::str_replace_all("一般", "regular")
y$trading.session %<>% stringr::str_replace_all("盤後", "after-hours")

#==================================================================================
# 資料儲存
#==================================================================================
call.option.dat <- y %>% 
  as.tibble() %>% 
  filter(call.put == "call")

put.option.dat <- y %>% 
  as.tibble() %>% 
  filter(call.put == "put")


write.csv(y, "TXO.raw.dat.csv")


write.csv(call.option.dat, "call.option.dat.csv")
write.csv(put.option.dat, "put.option.dat.csv")
