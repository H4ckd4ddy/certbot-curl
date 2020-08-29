#!/bin/sh

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

domain_uid=$( echo $CERTBOT_DOMAIN | tr . _ )

# Check if domain already checked
if [ -f "/tmp/$domain_uid.token" ];then
	token="$(cat /tmp/$domain_uid.token),\"$CERTBOT_VALIDATION\""
else
	token="\"$CERTBOT_VALIDATION\""
fi

# Save token (in case of multiple verifications)
echo "$token" > "/tmp/$domain_uid.token"

if [ $subdomain == $domain ];then
	record_name="_acme-challenge"
else
	record_name="_acme-challenge.$subdomain"
fi

# Exec provider script
source "$PROVIDER_DIR/$PROVIDER-auth.sh" $domain $record_name $token