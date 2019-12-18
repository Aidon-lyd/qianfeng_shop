#!/bin/bash

##############################
##初始化数据库和创建dim层的模型
##
###############################


hive -e "
drop database if exists bbp_dim CASCADE;
-- hive 建库
create database if not exists bbp_dim;


CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dim.dim_code_category (
  first_category_id int   ,
  first_category_name string  ,
  second_category_id int   ,
  second_catery_name string  ,
  third_category_id int   ,
  third_category_name string  ,
  category_id int
)
row format delimited fields terminated by '\t'
location '/bbp/dim/dim_code_category'
;

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dim.dim_user (
  user_id bigint     ,
  user_name string  ,
  user_gender tinyint  ,
  user_birthday string  ,
  user_age int   ,
  constellation string  ,
  province string  ,
  city string  ,
  city_level tinyint  ,
  e_mail string  ,
  op_mail string  ,
  mobile bigint   ,
  num_seg_mobile int   ,
  op_Mobile string  ,
  register_time string  ,
  login_ip string  ,
  login_source string  ,
  request_user string  ,
  total_score decimal(18,2)  ,
  used_score decimal(18,2)  ,
  is_blacklist tinyint  ,
  is_married tinyint  ,
  education string  ,
  monthly_income decimal(18,2) ,
  profession string  ,
  create_date string
)
row format delimited fields terminated by '\t'
location '/bbp/dim/dim_user';


CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dim.dim_user_addr (
  user_id bigint   ,
  order_addr string  ,
  user_order_flag tinyint  ,
  addr_id bigint     ,
  arear_id int
)
row format delimited fields terminated by '\t'
location '/bbp/dim/dim_user_addr' ;


CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dim.dim_user_extend (
  user_id bigint   ,
  user_gender bigint   ,
  is_pregnant_woman tinyint  ,
  is_have_children tinyint  ,
  is_have_car tinyint  ,
  phone_brand string  ,
  phone_brand_level string  ,
  phone_cnt int   ,
  change_phone_cnt int   ,
  is_maja tinyint  ,
  majia_account_cnt int   ,
  loyal_model string  ,
  shopping_type_model string  ,
  weight int   ,
  height int
)
row format delimited fields terminated by '\t'
location '/bbp/dim/dim_user_extend';

CREATE EXTERNAL TABLE IF NOT EXISTS bbp_dim.dim_code_city (
  `id` int comment 'arear_id',
  `city` string,
  `province` string
)
row format delimited fields terminated by '\t'
location '/bbp/dim/dim_code_city'
;

"