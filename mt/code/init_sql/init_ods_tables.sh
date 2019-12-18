#!/bin/bash

##############################
##初始化数据库和创建ods层的模型
##
###############################


hive -e "
drop database if exists bbp_ods CASCADE;

create database if not exists bbp_ods;
create database if not exists bbp_dwd;
create database if not exists bbp_dws;
create database if not exists bbp_dm;

use bbp_ods;

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_biz_trade (
  trade_id bigint,
  order_id bigint,
  user_id bigint,
  amount decimal(18,2),
  trade_type int,
  trade_time string  
) 
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_biz_trade'
 ;


CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_cart (
  cart_id bigint     ,
  session_id string  ,
  user_id bigint   ,
  goods_id bigint   ,
  goods_num int   ,
  add_time string  ,
  cancle_time string  ,
  sumbit_time string  ,
  create_date string
)  
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_cart'
;




CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_order_delivery (
  order_id bigint   ,
  order_no string  ,
  consignee string  ,
  area_id bigint   ,
  area_name string  ,
  address string  ,
  mobile bigint   ,
  phone string  ,
  coupon_id bigint   ,
  coupon_money decimal(18,2)  ,
  carriage_money decimal(18,2)  ,
  create_time string  ,
  update_time string  ,
  addr_id bigint   
) 
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_order_delivery'
;



CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_order_item (
  user_id bigint   ,
  order_id bigint   ,
  order_no string  ,
  goods_id bigint   ,
  goods_no string  ,
  goods_name string  ,
  goods_amount int   ,
  shop_id bigint   ,
  shop_name string  ,
  curr_price decimal(18,2)  ,
  market_price decimal(18,2)  ,
  discount decimal(18,2)  ,
  cost_price decimal(18,2)  ,
  first_cart bigint   ,
  first_cart_name string  ,
  second_cart bigint   ,
  second_cart_name string  ,
  third_cart bigint   ,
  third_cart_name string  ,
  goods_desc string,
  update_time string
)  
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_order_item';



CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_us_order (
  order_id bigint     ,
  order_no string  ,
  order_date string  ,
  user_id bigint   ,
  user_name string  ,
  order_money decimal(18,2)  ,
  order_type int   ,
  order_status int   ,
  pay_status int   ,
  pay_type int   ,
  order_source string  ,
  update_time string  
)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_us_order';




CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_user_app_click_log (
  log_id bigint     ,
  user_id bigint   ,
  imei string  ,
  log_time string  ,
  visit_os string  ,
  os_version string  ,
  app_name string  ,
  app_version string  ,
  device_token string  ,
  visit_ip string  ,
  province string  ,
  city string  
) 
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_user_app_click_log';


CREATE EXTERNAL TABLE IF NOT EXISTS bbp_ods.ods_user_pc_click_log (
  log_id bigint     ,
  user_id bigint   ,
  session_id string  ,
  cookie_id string  ,
  visit_time string  ,
  visit_url string  ,
  visit_os string  ,
  browser_name string  ,
  visit_ip string  ,
  province string  ,
  city string  ,
  page_id int   ,
  goods_id bigint   ,
  shop_id bigint   
)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/ods/ods_user_pc_click_log'
;
"