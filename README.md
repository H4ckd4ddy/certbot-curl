# certbot-curl
Modular Docker image for certbot


Use with docker-compose :

```
certbot-curl:
  image: hackdaddy/certbot-curl:release-1.0
  volumes:
    - type: bind
      source: /path/to/certs
      target: /etc/letsencrypt
    - type: bind
      source: /var/run/docker.sock
      target: /var/run/docker.sock
  environment:
    - PROVIDER=Gandi
    - API_KEY=xxxxxxxxxxxxxxxxxxxx
    - EMAIL=my-email@exemple.com
    - DOMAINS=exemple.com,*.exemple.com
    - NGINX_CONTAINER=name-of-my-nginx-container
```