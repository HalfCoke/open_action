FROM nextcloud:fpm-alpine

RUN apt update && apt install -y libmagickcore-6.q16-6-extra cron vim smbclient libsmbclient-dev && apt clean
RUN rm -rf /var/lib/apt/lists/*

RUN { \
    sed -i '194 i service cron start' /entrypoint.sh; \
    sed -i '195 i echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" > crontabConf' /entrypoint.sh; \
    sed -i '196 i echo "*/5 * * * * php -d memory_limit=128M -f /var/www/html/cron.php" >> crontabConf' /entrypoint.sh; \
    sed -i '197 i crontab -u www-data crontabConf' /entrypoint.sh; \
    sed -i '198 i rm -f crontabConf' /entrypoint.sh; \
    }
WORKDIR /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]