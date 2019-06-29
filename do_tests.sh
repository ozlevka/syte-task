#!/usr/bin/env bash

DO_TOKEN=$(cat do.token)


curl -X GET -H "Authorization: Bearer $DO_TOKEN"  "https://api.digitalocean.com/v2/images" | jq '.'