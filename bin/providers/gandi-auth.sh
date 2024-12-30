#!/bin/sh

api='https://api.gandi.net/v5/livedns'

domain=$1
record_name=$2
token=$3

curl -s -X PUT \
	-H "Content-Type: application/json" \
	-H "authorization: Bearer $API_KEY" \
	-d "{\"rrset_ttl\": 300, \"rrset_values\": [$token]}" \
	"$api/domains/$domain/records/$record_name/TXT"