#!/bin/bash

##############################
##初始化数据库和创建dwd层的模型
##
###############################


hive -e "

create database if not exists bbp_dwd;

use bbp_dwd;

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dwd.dwd_us_order_detail_day (
  order_id bigint,
  order_no string,
  order_date string,
  user_id bigint,
  user_name string,
  order_money decimal(18,2),
  order_type int   ,
  order_status int   ,
  pay_status int   ,
  pay_type int   ,
  order_source string,
  consignee string  ,
  area_id bigint   ,
  area_name string  ,
  address string  ,
  mobile bigint   ,
  phone string  ,
  coupon_id bigint   ,
  coupon_money decimal(18,2)  ,
  carriage_money decimal(18,2)  ,
  delivery_create_time string,
  addr_id bigint,
  order_addr string  ,
  user_order_flag tinyint,
  city_id int,
  city string,
  province string,
  trade_id bigint,
  amount decimal(18,2),
  trade_type int,
  trade_time string
)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/dwd/dwd_us_order_detail_day';
"

