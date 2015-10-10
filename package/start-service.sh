#!/bin/sh

set -e
set -x
printenv

mkdir -p $SNAP_APP_DATA_PATH/etc/influxdb/
if [ ! -f $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf ]; then
	cp -n $SNAP_APP_PATH/etc/influxdb/influxdb.conf $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf
	SNAP_APP_DATA_PATH_ESCAPE=$(echo $SNAP_APP_DATA_PATH | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
	sed -i "s/SNAP_APP_DATA_PATH/$SNAP_APP_DATA_PATH_ESCAPE/g" $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf
	SNAP_APP_PATH_ESCAPE=$(echo $SNAP_APP_PATH | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
	sed -i "s/SNAP_APP_PATH/$SNAP_APP_PATH_ESCAPE/g" $SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf
fi

$SNAP_APP_PATH/magic-bin/influxd -config=$SNAP_APP_DATA_PATH/etc/influxdb/influxdb.conf

