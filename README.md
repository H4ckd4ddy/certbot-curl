# certbot-curl

Modular Docker image for certbot

docker-compose example :

```
certbot-curl:
  image: hackdaddy/certbot-curl:release-1.4
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
    - EMAIL=my-email@example.com
    - DOMAINS= example.com,*. example.com
    - CONTAINER_TO_RESTART=name-of-my-nginx-container
```