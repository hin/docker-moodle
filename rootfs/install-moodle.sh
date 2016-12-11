#!/bin/sh

# Install moodle files if needed
if [ ! -d /var/www/moodle ]; then
   cd /var/www
   git clone --depth 1 -b v3.2.0 https://github.com/moodle/moodle.git moodle
fi

# Install cron job
echo '*/15 * * * * /usr/bin/php /var/www/moodle/admin/cli/cron.php'|crontab -u nobody -
