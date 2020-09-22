#### TABTOUCH BASKETBALL 
library(tidyverse)
library(rvest)
library(xml2)
library(RSelenium)
require(plyr)
require(tidyr)
require(dplyr)
require(tryCatchLog)
library(httr)
library(rvest)
library(xml2)
library(magrittr)
library(tibble)
library(googlesheets4)
library(webdriver)
library(cronR)


#Create the remote driver / navigator
rd <- rsDriver(browser = "firefox")

Sys.sleep(2)

  rd$client$navigate("https://www.tabtouch.com.au") 
  Sys.sleep(5)
  
  ## Goes TAB Touch Sports page
  full<-rd$client$findElement(using = "xpath", "/html/body/header/div/nav/ul/li[2]/a") 
  full$clickElement()
  Sys.sleep(2)
  
  ## Goes to Basketball page
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]") 
  full$clickElement()
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[2]/span/a") 
  full$clickElement()

  ####### NBA Matches/ Line Bets
  Sys.sleep(15)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]")
  full$clickElement()
  Sys.sleep(15)
  a <- rd$client$getPageSource(full)
  a <- a[[1]] %>% read_html(full)
  NBALineOdds <- a %>% html_nodes(xpath = "/html/body/section/div/div[2]/div[3]/div/table") %>% html_table() %>% as.data.frame()

 
  
  Game1Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))
  
  Game2Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))
  
  
  Game3Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))
  
  
  Game4Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))
  

  Game5Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))
  
  Game6Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))
  
  Game7Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))
  
  
  Game8Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))
  
  
  Game9Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))
  
  
  Game10Line <- data_frame(Title = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                          Home = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                          Away = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))
  
  
  NBALineOdds <- bind_rows(Game1Line, Game2Line, Game3Line, Game4Line, Game5Line, Game6Line, Game7Line, Game8Line, Game9Line, Game10Line)
  
  
  ####### Third Tab
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[3]")
  full$clickElement()
  Sys.sleep(10)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]/a")
  full$clickElement()
  b <- rd$client$getPageSource(full)
  b <- b[[1]] %>% read_html(full)
  
  
  Third1Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))
  
  Third2Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))
  
  
  Third3Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))
  
  
  Third4Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))
  
  
  Third5Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker ="TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))
  
  Third6Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))
  
  Third7Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))
  
  
  Third8Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))
  
  
  Third9Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                          Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                          Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                          Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))
  
  
  Third10Line <- data_frame(Title = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                           Home = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                           Away = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(b, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))
  
  
  ThirdLineOdds <- bind_rows(Third1Line, Third2Line, Third3Line, Third4Line, Third5Line, Third6Line, Third7Line, Third8Line, Third9Line, Third10Line)
  
  Sys.sleep(2)
  
  ###### Fourth Tab
  Sys.sleep(2)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[4]")
  full$clickElement()
  Sys.sleep(10)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]/a")
  full$clickElement()
  c <- rd$client$getPageSource(full)
  c <- c[[1]] %>% read_html(full)
  
  
  Fourth1Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))
  
  Fourth2Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))
  
  
  Fourth3Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))
  
  
  Fourth4Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker ="TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))
  
  
  Fourth5Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                            Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                            Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                            RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                            Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                            HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                            Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                            AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))
  
  Fourth6Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                            Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                            Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                            RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                            Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                            HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                            Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                            AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))
  
  Fourth7Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))
  
  
  Fourth8Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))
  
  
  Fourth9Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                           Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                           Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                           Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                           Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))
  
  
  Fourth10Line <- data_frame(Title = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                             Bookmaker = "TAB Touch",
                            Type = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                            Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                            RaceNo = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                            Home = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                            HomeOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                            Away = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                            AwayOdds = html_text(html_node(c, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))
  
  
  FourthLineOdds <- bind_rows(Fourth1Line, Fourth2Line, Fourth3Line, Fourth4Line, Fourth5Line, Fourth6Line, Fourth7Line, Fourth8Line, Fourth9Line, Fourth10Line)
  
  
  
  # China CBA Matches
  Sys.sleep(2)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[5]/span/a") 
  full$clickElement()
  Sys.sleep(2)
  full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]")
  full$clickElement()
  Sys.sleep(10)
  e <- rd$client$getPageSource(full)
  e <- e[[1]] %>% read_html(full)
  
  CBA1Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))
  
  CBA2Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))
  
  
  CBA3Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))
  
  CBA4Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                         Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                         Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                         Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))
  
CBA5Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                       Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                       Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))
  
CBA6Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                       Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                       Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))
  
CBA7Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                       Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                       Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))
  
  
CBA8Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                       Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                       Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))
  
  
CBA9Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                       Bookmaker = "TAB Touch",
                          Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                       Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                          Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                          Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))
  
  
CBA10Line <- data_frame(Title = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                        Bookmaker = "TAB Touch",
                           Type = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                        Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                           Home = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                           Away = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(e, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))
  
  
CBALineOdds <- bind_rows(CBA1Line, CBA2Line, CBA3Line, CBA4Line, CBA5Line, CBA6Line, CBA7Line, CBA8Line, CBA9Line, CBA10Line)
  
Sys.sleep(2)

###### Sixth Tab
Sys.sleep(2)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[6]/span/a")
full$clickElement()
Sys.sleep(10)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]/a")
full$clickElement()
d <- rd$client$getPageSource(full)
d<- d[[1]] %>% read_html(full)


Sixth1Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))

Sixth2Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))


Sixth3Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))


Sixth4Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))


Sixth5Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))

Sixth6Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))

Sixth7Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker ="TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))


Sixth8Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))


Sixth9Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                          Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                          Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                          Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))


Sixth10Line <- data_frame(Title = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                           Type = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                           Home = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                           Away = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(d, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))


SixthLineOdds <- bind_rows(Sixth1Line, Sixth2Line, Sixth3Line, Sixth4Line, Sixth5Line, Sixth6Line, Sixth7Line, Sixth8Line, Sixth9Line, Sixth10Line)

Sys.sleep(2)

###### Seventh Tab
Sys.sleep(2)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[7]/span/a")
full$clickElement()
Sys.sleep(10)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]/a")
full$clickElement()
g<- rd$client$getPageSource(full)
g<- g[[1]] %>% read_html(full)


Seventh1Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))

Seventh2Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker ="TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))


Seventh3Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker ="TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))


Seventh4Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))


Seventh5Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))

Seventh6Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))

Seventh7Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))


SeventhLine8 <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))


Seventh9Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                           Bookmaker = "TAB Touch",
                         Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                         RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                         Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                         HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                         Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                         AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))


Seventh10Line <- data_frame(Title = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                            Bookmaker = "TAB Touch",
                          Type = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(a, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                          RaceNo = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                          Home = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                          HomeOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                          Away = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                          AwayOdds = html_text(html_node(g, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))


SeventhLineOdds <- bind_rows(Seventh1Line, Seventh2Line, Seventh3Line, Seventh4Line, Seventh5Line, Seventh6Line, Seventh7Line, SeventhLine8, Seventh9Line, Seventh10Line)



###### Eigth Tab
Sys.sleep(2)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[1]/ul[2]/li[5]/ul/li[8]/span/a")
full$clickElement()
Sys.sleep(10)
full<-rd$client$findElement(using = "xpath", "/html/body/section/div/div[2]/div[3]/ul/li[2]/a")
full$clickElement()
f <- rd$client$getPageSource(full)
f<- f[[1]] %>% read_html(full)


Eigth1Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[1]/tr[3]/td[3]")))

Eigth2Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[2]/tr[3]/td[3]")))


Eigth3Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[3]/tr[3]/td[3]")))


Eigth4Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[4]/tr[3]/td[3]")))


Eigth5Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[5]/tr[3]/td[3]")))

Eigth6Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[6]/tr[3]/td[3]")))

Eigth7Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                         Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[7]/tr[3]/td[3]")))


EigthLine8 <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[8]/tr[3]/td[3]")))


Eigth9Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                         Bookmaker = "TAB Touch",
                           Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                         Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/time")),
                           RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[1]/td/strong")),
                           Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[2]")),
                           HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[2]/td[3]")),
                           Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[2]")),
                           AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[9]/tr[3]/td[3]")))


Eigth10Line <- data_frame(Title = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/h1")),
                          Bookmaker = "TAB Touch",
                            Type = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/h2")),
                          Date = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/time")),
                            RaceNo = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[1]/td/strong")),
                            Home = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[2]")),
                            HomeOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[2]/td[3]")),
                            Away = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[2]")),
                            AwayOdds = html_text(html_node(f, xpath = "/html/body/section/div/div[2]/div[3]/div/table/tbody[10]/tr[3]/td[3]")))


EigthLineOdds <- bind_rows(Eigth1Line, Eigth2Line, Eigth3Line, Eigth4Line, Eigth5Line, Eigth6Line, Eigth7Line, EigthLine8, Eigth9Line, Eigth10Line)



Main <- bind_rows(NBALineOdds, ThirdLineOdds, FourthLineOdds, CBALineOdds, SixthLineOdds, SeventhLineOdds, EigthLineOdds)
Main <- subset(Main, Type == "Line")
Main <- Main[complete.cases(Main), ]
Main$HomeLine<-str_sub(Main$Home,-5,-1)
Main$AwayLine<-str_sub(Main$Away,-5,-1)
Main$HomeTeam<-substr(Main$Home, 1,nchar(Main$Home)-5)
Main$AwayTeam<-substr(Main$Away, 1,nchar(Main$Away)-5)
Main$Time<-substr(Main$Date, 1,nchar(Main$Date) -13)
Main$Date<-str_sub(Main$Date,7,-1)
Main$Time<-as.POSIXct(Main$Time, format = '%H:%M', tz="Pacific/Auckland")
attributes(Main$Time)$tzone <- "Australia/Melbourne"
Main$Time<-format(Main$Time,"%H:%M")
Main$Timestamp<-format(Sys.time())
Main$Timestamp<-as.POSIXct(format(Main$Timestamp), tz="Pacific/Auckland")
attributes(Main$Timestamp)$tzone <- "Australia/Melbourne"
Main$Date<-str_replace(Main$Date, "[ ]", "")
Main$Date<-str_replace(Main$Date, "[ ]", "-")
Main$Date<-str_replace(Main$Date, "[ ]", "-")
Main$Date<-as.Date(Main$Date,format="%d-%b-%y")
Main$Date<-as.Date(Main$Date,format="%Y-%m-%d")



Main<-select(Main, "Bookmaker", "Title", "Type", "Date", "Time", "HomeTeam", "HomeLine", "HomeOdds", "AwayTeam", "AwayLine", "AwayOdds", "Timestamp")



write_sheet(Main, ss = "https://docs.google.com/spreadsheets/d/1hF_DN0dQ2zbvuK_JuZ-W1N2DC3mn99qx0epy8rJhDQ8/edit#gid=0", sheet = "TAB Touch")













#### Pinnacle Basketball Scraper

rd$client$navigate("https://www.pinnacle.com/en/basketball/nba/matchups") 
Sys.sleep(15)


## Goes to Sports page
full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
full$clickElement()
Sys.sleep(20)
z <- rd$client$getPageSource(full)
z<- z[[1]] %>% read_html(full)
Sys.sleep(10)

Game1 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))

Game2 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))

Game3 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))

Game4 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))

Game5 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))

Game6 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))


Game7 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))


Game8 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))

Game9 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                    Bookmaker = "Pinnacle",
                    Type = ("Line"),
                    HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                    HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                    HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                    AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                    AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                    AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                    Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                    Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))

Game10 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))

Game11 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))

Game12 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))

Game13 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))

Game14 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[3]/div[1]/a/div[2]/span")))


Game15 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[4]/div[1]/a/div[2]/span")))

Game16 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[2]/span")))


Game17 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[4]/div/div/div[6]/div[1]/a/div[2]/span")))


Game18 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[2]/span")))


Game19 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                     Bookmaker = "Pinnacle",
                     Type = ("Line"),
                     HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[1]")),
                     HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[1]")),
                     HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[2]")),
                     AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                     AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[1]")),
                     AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[2]")),
                     Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                     Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[2]/span")))



NBA <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13, Game14, Game15, Game16, Game17, Game18, Game19)





## NBA Page 2 Matches (Pinnacle)
full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[3]") 
full$clickElement()
Sys.sleep(10)
h <- rd$client$getPageSource(full)
h<- h[[1]] %>% read_html(full)
Sys.sleep(10)
        
        
        
        Game1 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
      
      
        Game2 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
        
        Game3 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
        
        Game4 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
        
        Game5 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
        
        Game6 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
        
        
        Game7 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
        
        
        Game8 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
        
        Game9 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
        
        Game10 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                             Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
        
        Game11 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                             Bookmaker = "Pinnacle",
                             Type = ("Line"),
                             HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                             HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                             HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                             AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                             AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                             AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                             Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                             Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
        
        Game12 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                             Bookmaker = "Pinnacle",
                             Type = ("Line"),
                             HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                             HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                             HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                             AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                             AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                             AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                             Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                             Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
        
        Game13 <- data_frame(Title = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                             Bookmaker = "Pinnacle",
                             Type = ("Line"),
                             HomeTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                             HomeLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                             HomeOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                             AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                             AwayLine = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                             AwayOdds = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                             Date = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                             Time = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
        
        
    
       NBA1 <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13)
       
        
       ## Thailand Matches (Pinnacle)
       rd$client$navigate("https://www.pinnacle.com/en/basketball/thailand-basketball-league/matchups") 
  
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(15)
       x <- rd$client$getPageSource(full)
       x<- x[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(x, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Game14 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       
       Game15 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game16 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       
       Game17 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       
       Game18 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       
       Game19 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       
       Thai <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13, Game14, Game15, Game16, Game17, Game18, Game19)
       
       
       ## WNBA Matches (Pinnacle)
       rd$client$navigate("https://www.pinnacle.com/en/basketball/wnba/matchups") 
       
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(10)
       y <- rd$client$getPageSource(full)
       y<- y[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(h, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(y, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Game14 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       
       Game15 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game16 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       
       Game17 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       
       Game18 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       
       Game19 <- data_frame(Title = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(z, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       
       WNBA <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13, Game14, Game15, Game16, Game17, Game18, Game19)
       
  
       ## Euroleague Matches (Pinnacle)
       rd$client$navigate("https://www.pinnacle.com/en/basketball/europe-euroleague/matchups") 

       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div//div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(15)
       v <- rd$client$getPageSource(full)
       v<- v[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Euro <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13)
       
        
       
       ## World Cup Friendlies (Pinnacle) 
       rd$client$navigate("https://www.pinnacle.com/en/basketball/world-club-friendlies/matchups")
      
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(10)
       u <- rd$client$getPageSource(full)
       u<- u[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))

       Game2 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(v, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div//div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(u, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       WCF <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13)
       
       
       
       ## Poland page 1 Matches (Pinnacle)
       rd$client$navigate("https://www.pinnacle.com/en/basketball/poland-tauron-basket-liga/matchups") 
  
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(20)
       l <- rd$client$getPageSource(full)
       l<- l[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Game14 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       
       Game15 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div//div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game16 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       
       Game17 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[6]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[6]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       
       Game18 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       
       Game19 <- data_frame(Title = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(l, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       
       Poland1 <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13, Game14, Game15, Game16, Game17, Game18, Game19)
       
       
       
       
       
       
       ## Poland page 2 Matches (Pinnacle)
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[3]") 
       full$clickElement()
       Sys.sleep(10)
       n <- rd$client$getPageSource(full)
       n<- n[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       
       
       Game1 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       
       Game2 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))

       Game9 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(n, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Poland2 <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13)
       
       ## Poland page 3 Matches (Pinnacle)
       
       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[4]") 
       full$clickElement()
       Sys.sleep(20)
       o <- rd$client$getPageSource(full)
       o<- o[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main//div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div//div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div//div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div//div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/diiv/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                           Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                              Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Game14 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[3]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[3]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       
       Game15 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[4]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game16 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       
       Game17 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[6]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div[4]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       
       Game18 <- data_frame(Title = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[1]")),
                            HomeLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div//div/div[4]/div/div/div[7]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]/span")),
                            Time = html_text(html_node(o, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[4]/div/div/div[7]/div[1]/a/div[2]/span")))
       
    
       
       
       Poland3 <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13, Game14, Game15, Game16, Game17, Game18)
       
       
       
       
       ## Italy Matches (Pinnacle)

       rd$client$navigate("https://www.pinnacle.com/en/basketball/italy-super-coppa/matchups") 

       full<-rd$client$findElement(using = "xpath", "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[3]/div/div[1]/div/div/button[2]") 
       full$clickElement()
       Sys.sleep(10)
       p <- rd$client$getPageSource(full)
       p<- p[[1]] %>% read_html(full)
       Sys.sleep(10)
       
       Game1 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[3]/div[1]/a/div[2]/span")))
       
       Game2 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[4]/div[1]/a/div[2]/span")))
       
       Game3 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[5]/div[1]/a/div[2]/span")))
       
       Game4 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[6]/div[1]/a/div[2]/span")))
       
       Game5 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div[1]/a/div[2]/span")))
       
       Game6 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[1]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[8]/div[1]/a/div[2]/span")))
       
       
       Game7 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[9]/div[1]/a/div[2]/span")))
       
       
       Game8 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[10]/div[1]/a/div[2]/span")))
       
       Game9 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                           Bookmaker = "Pinnacle",
                           Type = ("Line"),
                           HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[1]/span")),
                           HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[1]")),
                           HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[1]/span[2]")),
                           AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[1]/div[2]/span")),
                           AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[1]")),
                           AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[2]/a[2]/span[2]")),
                           Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                           Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[11]/div[1]/a/div[2]/span")))
       
       Game10 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div[3]/div/div/div[12]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[12]/div[1]/a/div[2]/span")))
       
       Game11 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[13]/div[1]/a/div[2]/span")))
       
       Game12 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[14]/div[1]/a/div[2]/span")))
       
       Game13 <- data_frame(Title = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div/div[1]/div[1]/div/ul/li[3]/span")),
                            Bookmaker = "Pinnacle",
                            Type = ("Line"),
                            HomeTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[1]/span")),
                            HomeLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[1]")),
                            HomeOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[1]/span[2]")),
                            AwayTeam = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[1]/div[2]/span")),
                            AwayLine = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[1]")),
                            AwayOdds = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[2]/a[2]/span[2]")),
                            Date = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[7]/div/span")),
                            Time = html_text(html_node(p, xpath = "/html/body/div[2]/div/div/div[2]/main/div/div/div[3]/div/div/div[15]/div[1]/a/div[2]/span")))
       
       Italy <- bind_rows(Game1, Game2, Game3, Game4, Game5, Game6, Game7, Game8, Game9, Game10, Game11, Game12, Game13)
       
       
       
        rd$client$close()
        rd$server$stop()
        
        
      
        PinnacleBB<-bind_rows(NBA, NBA1, Thai, WNBA, Euro, WCF, Poland1, Poland2, Poland3, Italy)
        
        
PinnacleBB <- PinnacleBB[complete.cases(PinnacleBB), ]

PinnacleBB$Time<-as.POSIXct(PinnacleBB$Time, format = '%H:%M', tz="Pacific/Auckland")
attributes(PinnacleBB$Time)$tzone <- "Australia/Melbourne"
PinnacleBB$Time<-format(PinnacleBB$Time,"%H:%M")

Today<-Sys.Date() 
Today<-format(Today, format="%a, %b %d, %Y")

Tomorrow<-Sys.Date() + 1
Tomorrow<-format(Tomorrow, format="%a, %b %d, %Y")

PinnacleBB$Date[PinnacleBB$Date == 'Today'] <- Today
PinnacleBB$Date[PinnacleBB$Date == 'Tomorrow'] <- Tomorrow
PinnacleBB$fix<-str_sub(PinnacleBB$Date,5,-1)
PinnacleBB$fix<-str_replace(PinnacleBB$fix, "[,]", "")
PinnacleBB$fix<-str_replace(PinnacleBB$fix, "[ ]", "")
PinnacleBB$fix<-str_replace(PinnacleBB$fix, "[ ]", "-")
PinnacleBB$fix<-str_replace(PinnacleBB$fix, "[ ]", "-")
PinnacleBB$fix<-as.Date(PinnacleBB$fix,format="%b-%d-%y")
PinnacleBB$fix<-as.Date(PinnacleBB$fix,format="%Y-%m-%d")

### Adds a Timestamp of time Scraped (NZ Time to AUST)
PinnacleBB$Timestamp<-format(Sys.time())
PinnacleBB$Timestamp<-as.POSIXct(format(PinnacleBB$Timestamp), tz="Pacific/Auckland")
attributes(PinnacleBB$Timestamp)$tzone <- "Australia/Melbourne"



PinnacleBB<-select(PinnacleBB, "Bookmaker", "Title", "Type", "fix", "Time", "HomeTeam", "HomeLine", "HomeOdds", "AwayTeam", "AwayLine", "AwayOdds", "Timestamp")
colnames(PinnacleBB)<- c("Bookmaker", "Title", "Type", "Date", "Time", "HomeTeam", "HomeLine", "HomeOdds", "AwayTeam", "AwayLine", "AwayOdds", "Timestamp")



#### Adds to the Google Docs Pinnacle Page
write_sheet(PinnacleBB, ss = "https://docs.google.com/spreadsheets/d/1hF_DN0dQ2zbvuK_JuZ-W1N2DC3mn99qx0epy8rJhDQ8/edit#gid=1567209", sheet = "Pinnacle")

#### Adds to the Google Docs Page
sheet_append(PinnacleBB, ss = "https://docs.google.com/spreadsheets/d/1hF_DN0dQ2zbvuK_JuZ-W1N2DC3mn99qx0epy8rJhDQ8/edit#gid=1567209", sheet = "PastOdds")
sheet_append(Main, ss = "https://docs.google.com/spreadsheets/d/1hF_DN0dQ2zbvuK_JuZ-W1N2DC3mn99qx0epy8rJhDQ8/edit#gid=1567209", sheet = "PastOdds")






