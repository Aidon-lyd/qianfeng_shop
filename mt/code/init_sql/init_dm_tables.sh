#!/bin/bash

##############################
##初始化数据库和创建dm层的模型
##
###############################


hive -e "

create database if not exists bbp_dm;

use bbp_dm;

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dm.dm_order_distribute (
 date_dt string,
 province string,
 city string,
 school_orders int,
 company_orders int,
 home_orders int,
 midnight_orders int,
 am_orders int,
 mm_orders int,
 pm_orders int,
 night_orders int
)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/dm/dm_order_distribute';

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dm.dm_order_basic (
date_dt string,
user_id string,
first_order_time string,
last_order_time string,
first_order_diff int,
last_order_diff int,
no_order_30_cnt int,
no_amount_30_cnt double,
no_order_60_cnt int,
no_amount_60_cnt double,
no_order_90_cnt int,
no_amount_90_cnt double,
in_order_30_cnt int,
in_amount_30_cnt double,
in_order_60_cnt int,
in_amount_60_cnt double,
in_order_90_cnt int,
in_amount_90_cnt double,
in_order_avg double,
max_amount double,
min_amount double,
no_order_avg double,
common_order_address string,
common_pay_type int,
total_orders int,
total_amount double
)
partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/bbp/dm/dm_order_basic';
"
