#!/bin/bash

############################
##增加分区
##
############################
yesterday=`date -d "1 days ago" "+%Y-%m-%d"`

hive -e "
alter table bbp_ods.ods_biz_trade add partition(dt='${yesterday}');
alter table bbp_ods.ods_cart add partition(dt='${yesterday}');
alter table bbp_ods.ods_order_delivery add partition(dt='${yesterday}');
alter table bbp_ods.ods_order_item add partition(dt='${yesterday}');
alter table bbp_ods.ods_us_order add partition(dt='${yesterday}');
alter table bbp_ods.ods_user_app_click_log add partition(dt='${yesterday}');
alter table bbp_ods.ods_user_pc_click_log add partition(dt='${yesterday}');
"