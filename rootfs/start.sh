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
        mysqld --user=root &
        php-fpm
        nginx
        ;;
    *)
        echo "Usage: XXX"
        ;;
esac

