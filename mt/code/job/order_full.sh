#!/bin/bash

############################
##全量数据导入
##
############################

sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table code_category \
--m 1 \
--target-dir '/bbp/dim/dim_code_category' \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table user \
--m 1 \
--target-dir '/bbp/dim/dim_user' \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table user_addr \
--m 1 \
--target-dir '/bbp/dim/dim_user_addr' \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table user_extend \
--m 1 \
--target-dir '/bbp/dim/dim_user_extend' \
--delete-target-dir \
--fields-terminated-by '\t'


sqoop import --connect jdbc:mysql://hadoop01:3306/qfbap_source \
--driver com.mysql.jdbc.Driver \
--username root --password root \
--table code_city \
--m 1 \
--target-dir '/bbp/dim/dim_code_city' \
--delete-target-dir \
--fields-terminated-by '\t'

