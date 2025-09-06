#!/bin/sh

api='https://api.cloudflare.com/client/v4'

domain=$1
record_name=$2
token=$3

zone_id=$(curl -s -X GET "$api/zones?name=$domain" \
                  -H "Authorization: Bearer $API_KEY" \
                  -H "Content-Type: application/json" | jq -r '.result[0].id' )

IFS=','
for t in $token; do
  t=$(echo "$t" | sed 's/^ *//;s/ *$//')
  [ -z "$t" ] && continue
  curl -s -X POST "$api/zones/$zone_id/dns_records" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d "{\"name\": \"$record_name\",
             \"type\": \"TXT\",
             \"ttl\": 120,
             \"content\": $t}"
done

sleep 15