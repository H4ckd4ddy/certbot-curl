FROM certbot/certbot:latest

RUN apk add --update \
	curl jq && \
	rm -rf /var/cache/apk/*

VOLUME /etc/letsencrypt

COPY bin/ /usr/local/bin/

ENTRYPOINT [ "update-certs.sh" ]
