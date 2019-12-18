#!/bin/bash

############################
##增量数据导入
##
############################
yesterday=`date -d "1 days ago" "+%Y-%m-%d"`

sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * from biz_trade where date(trade_time) > date_sub(CURRENT_DATE(),interval 1 day) and trade_time < CURRENT_DATE() and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_biz_trade/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * from cart where date(add_time) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_cart/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * from order_delivery where date(create_time) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_order_delivery/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select oi.*,uo.order_date FROM order_item oi JOIN us_order uo ON oi.order_id = uo.order_id WHERE DATE(order_date) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_order_item/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * FROM us_order WHERE DATE(order_date) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_us_order/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * FROM user_app_click_log WHERE DATE(log_time) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_user_app_click_log/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source?tinyInt1isBit=false \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--query 'select * FROM user_pc_click_log WHERE DATE(visit_time) = date_sub(CURRENT_DATE(),interval 1 day) and $CONDITIONS' \
--m 1 \
--target-dir "/bbp/ods/ods_user_pc_click_log/dt=${yesterday}" \
--delete-target-dir \
--fields-terminated-by '\t'
