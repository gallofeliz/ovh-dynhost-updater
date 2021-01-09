FROM alpine:3.10

RUN apk add --no-cache python3
RUN python3 -m pip install ovh_dynhost

RUN echo '{}' > /root/.ovh-dynhost.conf

ADD dynhost.cron /var/spool/cron/crontabs/dynhost.cron
ADD dynhost.sh /usr/local/bin/dynhost

CMD ["sh", "-c", "env > /tmp/env; dynhost ; crontab /var/spool/cron/crontabs/dynhost.cron && crond -f -L /dev/stdout"]
