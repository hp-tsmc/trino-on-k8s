#! /bin/bash

# openssl rand -base64 2

x=1
while [ $x -le 1000 ]
do
  product_name=`openssl rand -base64 2`
  echo "insert into dep values ('${product_name}');" >> data.sql
  x=$(( $x + 1 ))
done