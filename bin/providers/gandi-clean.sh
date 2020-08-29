#!/bin/sh

api='https://dns.api.gandi.net/api/v5'

domain=$1
record_name=$2

curl -s -X DELETE \
	-H 'Content-Type: application/json' \
	-H "X-Api-Key: $API_KEY" \
	"$api/domains/$domain/records/$record_name/TXT" >&2
