#!/bin/sh

case $1 in
    bash)
        exec bash
        ;;
    install-db)
        exec /install-db.sh
        ;;
    install-moodle)
        exec /install-moodle.sh
        ;;
    run)
        # Install cron job
        echo '*/15 * * * * /usr/bin/php /var/www/admin/cli/cron.php'|crontab -u nobody -
        mysqld --user=root &
        php-fpm
        nginx
        ;;
    *)
        echo "Usage: XXX"
        ;;
esac

