FROM nextcloud:fpm

RUN apt update && apt install -y aria2 libmagickcore-6.q16-6-extra cron vim smbclient libsmbclient-dev && apt clean
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/aria2
WORKDIR /var/www/aria2
RUN touch aria2.session
RUN { \
    echo 'dir=/Downloads'; \
    echo 'enable-rpc=true'; \
    echo 'rpc-allow-origin-all=true'; \
    echo 'rpc-listen-all=true'; \
    echo 'continue=true'; \
    echo 'input-file=/var/www/aria2/aria2.session'; \
    echo 'save-session=/var/www/aria2/aria2.session'; \
    echo 'max-concurrent-downloads=20'; \
    echo 'save-session-interval=120'; \
    echo 'connect-timeout=120'; \
    echo 'max-connection-per-server=10'; \
    echo 'min-split-size=10M'; \
    echo 'split=10'; \
    echo 'check-certificate=false'; \
    } > aria2.conf; \
    chown -R www-data:root /var/www/aria2; \
    chmod -R g=u /var/www/aria2
VOLUME ["/var/www/aria2"]
RUN { \
    sed -i '194 i su -s /bin/bash -c "aria2c --conf-path=/var/www/aria2/aria2.conf -D" www-data' /entrypoint.sh; \
    sed -i '195 i service cron start' /entrypoint.sh; \
    sed -i '196 i echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" > crontabConf' /entrypoint.sh; \
    sed -i '197 i echo "*/5 * * * * php -d memory_limit=128M -f /var/www/html/cron.php" >> crontabConf' /entrypoint.sh; \
    sed -i '198 i crontab -u www-data crontabConf' /entrypoint.sh; \
    sed -i '199 i rm -f crontabConf' /entrypoint.sh; \
    }
WORKDIR /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]