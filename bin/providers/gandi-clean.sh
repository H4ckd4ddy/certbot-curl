#!/bin/sh

api='https://api.gandi.net/v5/livedns'

domain=$1
record_name=$2

curl -s -X DELETE \
	-H "authorization: Bearer $API_KEY" \
	"$api/domains/$domain/records/$record_name/TXT" >&2