#!/bin/sh

set -e
set -x

mkdir -p $SNAP_APP_DATA_PATH/etc/influxdb/
mkdir -p $SNAP_APP_DATA_PATH/var/

cp -n $SNAP_APP_PATH/etc/influxdb/influxdb.conf $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf
SNAP_APP_DATA_PATH_ESCAPE=$(echo $SNAP_APP_DATA_PATH | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
sed -i "s/SNAP_APP_DATA_PATH/$SNAP_APP_DATA_PATH_ESCAPE/g" $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf
SNAP_APP_PATH_ESCAPE=$(echo $SNAP_APP_PATH | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
sed -i "s/SNAP_APP_PATH/$SNAP_APP_PATH_ESCAPE/g" $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf

$SNAP_APP_PATH/magic-bin/influxd -config=$SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf

