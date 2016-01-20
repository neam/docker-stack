Reverse Proxy
=============

Ajdust `docker.env` settings, required for TLS communication.
And mount (rebuild) with corresponding certs.

Start reverse proxy

    docker-compose up -d
    
Start test container with `VIRTUAL_HOST` setting    
    
    docker-compose -f hello-world.yml up -d


### SSL setup

Generate a self-signed certificate

    openssl req -new -x509 -sha256 -days 365 -nodes -out certs/default.crt -keyout certs/default.key
        
Replace `default` with your actual domain-name, like `hello.example.com` or `www.example.de.192.168.99.100.xip.io`
when creating a self-signed cert for a domain.


### Testing

Open in browser

Wildcard

    http://hello.example.com.192.168.99.100.xip.io
    ->
    http://hello.example.com.192.168.99.100.xip.io

Full domain

    http://www.example.de.192.168.99.100.xip.io
    ->
    https://www.example.de.192.168.99.100.xip.io

HTTP only

    http://nossl.192.168.99.100.xip.io
    
Initial connection shows certificate, then error 501 (503)
    
    https://nossl.192.168.99.100.xip.io

Error 503

    http://192.168.99.100
    https://192.168.99.100



### Debugging

Show logs    

    docker-compose logs

Show nginx config

    docker exec reverse_proxy_1 cat /etc/nginx/conf.d/default.conf
    
Run bash in nginx
    
    docker exec -it reverse_proxy_1 bash
    
    

