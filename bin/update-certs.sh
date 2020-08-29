#!/bin/sh

# Load config file if exist
[[ -f /etc/update-certs/config ]] && . /etc/update-certs/config

# Check if all parameters are set
[[ -z "$PROVIDER" ]] && echo "Please specify provider" && exit
[[ -z "$API_KEY" ]] && echo "Please specify API key" && exit
[[ -z "$EMAIL" ]] && echo "Please specify email address" && exit
[[ -z "$DOMAINS" ]] && echo "Please specify domains" && exit

# Convert provider name lowercase
export PROVIDER=$(echo $PROVIDER | tr '[:upper:]' '[:lower:]')

# Check if provider scripts exist
export PROVIDER_DIR="/usr/local/bin/providers"
if ! ( [ -f "$PROVIDER_DIR/$PROVIDER-auth.sh" ] && [ -f "$PROVIDER_DIR/$PROVIDER-clean.sh" ] );then
  echo "No script found for this provider";exit
fi

# Check cert every 5 days
while true; do
	certbot certonly --manual \
		--expand \
		--agree-tos \
		--manual-public-ip-logging-ok \
		--no-eff-email \
		--non-interactive \
		--preferred-challenges=dns \
		--manual-auth-hook authenticate.sh \
		--manual-cleanup-hook cleanup.sh \
		--post-hook reload-nginx.sh \
		--email "$EMAIL" \
		-d "$DOMAINS" \
		--server https://acme-v02.api.letsencrypt.org/directory
		"$@"

	sleep 5d
done