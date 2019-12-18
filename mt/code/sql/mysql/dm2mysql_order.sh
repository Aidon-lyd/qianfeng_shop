#!/bin/bash

############################
#将dm层的数据放到mysql中
############################
yesterday='2019-12-15'


sqoop export --connect 'jdbc:mysql://hadoop01:3306/qfbap_report?useUnicode=true&characterEncoding=utf-8' \
--username root --password root \
--table order_distribute \
--m 1 \
--export-dir "/bbp/dm/dm_order_distribute/dt=${yesterday}" \
--input-fields-terminated-by '\t' \
--update-mode allowinsert \
--update-key dt,province,city