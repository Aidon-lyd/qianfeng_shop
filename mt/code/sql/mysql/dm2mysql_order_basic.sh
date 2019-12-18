#!/bin/bash

############################
#将dm层的数据放到mysql中
############################
yesterday='2019-12-15'


sqoop export --connect 'jdbc:mysql://hadoop01:3306/qfbap_report?useUnicode=true&characterEncoding=utf-8' \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table dm_order_basic \
--m 1 \
--export-dir "/bbp/dm/dm_order_basic/dt=${yesterday}" \
--input-fields-terminated-by '\t' \
--update-mode allowinsert \
--update-key date_dt,user_id