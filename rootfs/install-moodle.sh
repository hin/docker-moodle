#!/bin/sh

# Install moodle files if needed
if [ ! -f /var/www/config-dist.php ]; then
   git clone --depth 1 -b v3.2.0 https://github.com/moodle/moodle.git /var/www
fi

# Install cron job
echo '*/15 * * * * /usr/bin/php /var/www/admin/cli/cron.php'|crontab -u nobody -
