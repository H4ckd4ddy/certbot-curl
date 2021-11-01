#!/bin/sh

api='https://api.cloudflare.com/client/v4'

domain=$1
record_name=$2

zone_id=$(curl -s -X GET "$api/zones?name=$domain" \
                  -H "Authorization: Bearer $API_KEY" \
                  -H "Content-Type: application/json" | jq -r '.result[0].id' )

record_id=$(curl -s -X GET "$api/zones/$zone_id/dns_records?type=TXT&name=$record_name.$domain" \
                    -H "Authorization: Bearer $API_KEY" \
                    -H "Content-Type: application/json" | jq -r '.result[0].id' )

curl -s -X DELETE  "$api/zones/$zone_id/dns_records/$record_id" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY"