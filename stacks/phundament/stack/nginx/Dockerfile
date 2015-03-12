FROM nginx:1.7

# Note: Source-code is used from phundament/app:cli volume
# Copy custom project config overrides

ADD nginx.conf /etc/nginx/nginx.conf
ADD conf.d/* /etc/nginx/conf.d/
ADD run.sh /root/run.sh

CMD ["/root/run.sh"]