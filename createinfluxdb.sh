#!/bin/bash

if ! -d /data/influxdb; then
      sudo mkdir -p /data/influxdb;
fi

docker run --rm \
      influxdb influxd config > /data/influxdb.conf

docker run --rm \
      -e INFLUXDB_DB=jenkins -e INFLUXDB_ADMIN_ENABLED=true \
      -e INFLUXDB_ADMIN_USER=jenkins -e INFLUXDB_ADMIN_PASSWORD=tanium123 \
      -e INFLUXDB_USER=jenkins -e INFLUXDB_USER_PASSWORD=tanium123 \
      -v /data/influxdb:/var/lib/influxdb \
      -p 8086:8086 -p 8083:8083 \
      influxdb /init-influxdb.sh

docker run -d --name influxdb \
      -v /data/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
      -v /data/influxdb:/var/lib/influxdb \
      -p 8086:8086 -p 8083:8083 \
      influxdb -config /etc/influxdb/influxdb.conf
