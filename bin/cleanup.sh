#!/bin/sh

domain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/.+\.(.+\..+)/\1/')
subdomain=$(echo "$CERTBOT_DOMAIN" | sed -r 's/(.+)\..+\..+/\1/')

domain_uid=$( echo $CERTBOT_DOMAIN | tr . _ )

[[ ! -f "/tmp/$domain_uid.token" ]] && echo "Domain already clean" && exit

if [ $subdomain == $domain ]; then
  record_name="_acme-challenge"
else
  record_name="_acme-challenge.$subdomain"
fi

# Exec provider script
source "$PROVIDER_DIR/$PROVIDER-clean.sh" $domain $record_name

rm -f "/tmp/$domain_uid.token"