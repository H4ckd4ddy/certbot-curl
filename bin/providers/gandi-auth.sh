#!/bin/sh

api='https://dns.api.gandi.net/api/v5'

domain=$1
record_name=$2
token=$3

curl -s -X PUT \
	-H "Content-Type: application/json" \
	-H "X-Api-Key: $API_KEY" \
	-d "{\"rrset_type\": \"TXT\",
		 \"rrset_ttl\": 300,
		 \"rrset_values\": [$token]}" \
	"$api/domains/$domain/records/$record_name/TXT"