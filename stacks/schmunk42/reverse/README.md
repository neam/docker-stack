Reverse Proxy
=============

Ajdust `docker.env` settings, required for TLS communication.
And mount (rebuild) with corresponding certs.

Start reverse proxy

    docker-compose up -d
    
Start test container with `VIRTUAL_HOST` setting    
    
    docker-compose -f hello-world.yml up -d

Open in browser

    http://hello.example.com.192.168.99.100.xip.io


### SSL

Generate a self-signed certificate, replace `default` with your actual domain-name.

    openssl req -new -x509 -sha256 -days 365 -nodes -out certs/default.crt -keyout certs/default.key


### Debugging

Show logs    

    docker-compose logs

Show nginx config

    docker exec reverse_proxy_1 cat /etc/nginx/conf.d/default.conf
    
Run bash in nginx
    
    docker exec -it reverse_proxy_1 bash
    
    

