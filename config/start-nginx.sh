#!/usr/bin/env bash

TEST="-"
while [ "$TEST" != "400" ]; do
    sleep 5
    TEST=$(curl -so /dev/null -w '%{response_code}' -X POST http://server:8080)
    echo "$TEST"
done

exec /usr/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf