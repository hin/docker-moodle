# Docker container for Moodle

This is everything you need to run Moodle 3.2.0 in one simple container.

It wraps MariaDB, Nginx, PHP5 to make it easy to quickly get started.

## Building the image

To build the image, simply run:
```sh
bash> docker build -t imagename .
```

(You can replace /imagename/ with whatever you want. I use "moodle")

## First install

### Preparing volumes

Three volumes are needed:

* Moodle itself - /var/www/
  ** Since Moodle plugins work by installing them selves into the Moodle
     directory, it must be preserved and writable for Moodle itself.
* Moodle data - /var/moodledata/
  ** This is where uploaded documents etc. are stored
* MariaDB data files - /var/lib/mysql/

For simplicity, these volumes are stored externally to the image itself.

To create the volumes, you need three empty directorys, i.e.:

```sh
bash> mkdir /data/moodle/www
bash> mkdir /data/moodle/moodledata
bash> mkdir /data/moodle/db
```

(You may call these directories whatever you like, and you may put
them wherever you like.)

### Installing database and Moodle distribution

When you first start the container, the MariaDB database and the
Moodle distribution files must be initialized.

To initialize the MariaDB database, run:
```sh
bash> docker run -ti --rm -v /data/moodle/www:/var/www -v /data/moodle/moodledata:/var/moodledata -v /data/moodle/db:/var/lib/mysql moodle install-db
```

To install the Moodle distribution files, run:
```sh
bash> docker run -ti --rm -v /data/moodle/www:/var/www -v /data/moodle/moodledata:/var/moodledata -v /data/moodle/db:/var/lib/mysql moodle install-moodle
```

### Running the service

The container listens to HTTP requests on port 80, and you need to redirect
a port (typically 80).

To actually start the service, run:
```sh
bash> docker run -d -v /data/moodle/www:/var/www -v /data/moodle/moodledata:/var/moodledata -v /data/moodle/db:/var/lib/mysql -p 80:80 moodle run
```

### Configuring Moodle

To start configuring Moodle, enter the URL in your web browser
(i.e. http://localhost:portnumber/).

The Moodle configuration "wizard" will now ask a number of questions
about timezones, etc. When it asks for database information, you need to
select 'mariadb/native', and enter the socket as '/var/lib/mysqld.sock'.

After this, everything should be up and running.

### Backup / restore

To be done
