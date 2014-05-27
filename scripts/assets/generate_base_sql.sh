#!/bin/bash

EXEC_PATH="`dirname \"$0\"`"

mysqldump -u$1 -p -d --triggers --routines --databases $2 --single-transaction | sed 's/ AUTO_INCREMENT=[0-9]*\b//' > $EXEC_PATH/base.sql