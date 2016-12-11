#!/bin/sh

# Install moodle files if needed
if [ ! -f /var/www/config-dist.php ]; then
   git clone --depth 1 -b v3.2.0 https://github.com/moodle/moodle.git /var/www
fi

chown -R nobody:nogroup /var/moodledata /var/www

