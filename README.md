# What is WordPress?
WordPress is a free and open source blogging tool and a content management system (CMS) based on PHP and MySQL, which runs on a web hosting service. Features include a plugin architecture and a template system. WordPress is used by more than 22.0% of the top 10 million websites as of August 2013. WordPress is the most popular blogging system in use on the Web, at more than 60 million websites. The most popular languages used are English, Spanish and Bahasa Indonesia.


> [wikipedia.org/wiki/WordPress](https://wikipedia.org/wiki/WordPress)

# How to use this image
$ docker run --name some-wordpress --network some-network -d wordpress
The following environment variables are also honored for configuring your WordPress instance (by a custom wp-config.php implementation⁠):

* `-e WORDPRESS_DB_HOST=...`
* `-e WORDPRESS_DB_USER=...`
* `-e WORDPRESS_DB_PASSWORD=...`
* `-e WORDPRESS_DB_NAME=...`
* `-e WORDPRESS_TABLE_PREFIX=...`
* `-e WORDPRESS_AUTH_KEY=..., -e WORDPRESS_SECURE_AUTH_KEY=..., -e WORDPRESS_LOGGED_IN_KEY=..., -e WORDPRESS_NONCE_KEY=..., -e WORDPRESS_AUTH_SALT=..., -e WORDPRESS_SECURE_AUTH_SALT=..., -e WORDPRESS_LOGGED_IN_SALT=..., -e WORDPRESS_NONCE_SALT=...` (default to unique random SHA1s, but only if other environment variable configuration is provided)
* `-e WORDPRESS_DEBUG=1` (defaults to disabled, non-empty value will enable WP_DEBUG in wp-config.php)
* `-e WORDPRESS_CONFIG_EXTRA=...` (defaults to nothing, the value will be evaluated by the eval() function in wp-config.php. This variable is especially useful for applying extra configuration values this image does not provide by default such as WP_ALLOW_MULTISITE; see docker-library/wordpress#142⁠ for more details)

The `WORDPRESS_DB_NAME` needs to already exist on the given MySQL server; it will not be created by the wordpress container.

If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

```
$ docker run --name some-wordpress -p 8080:80 -d wordpress
```
Then, access it via `http://localhost:8080` or `http://host-ip:8080` in a browser.

Docker Secrets
As an alternative to passing sensitive information via environment variables, `_FILE` may be appended to the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container. In particular, this can be used to load passwords from Docker secrets stored in `/run/secrets/<secret_name>` files. For example:

```
$ docker run --name some-wordpress -e WORDPRESS_DB_PASSWORD_FILE=/run/secrets/mysql-root ... -d wordpress:tag
```

Currently, this is supported for `WORDPRESS_DB_HOST`, `WORDPRESS_DB_USER`, `WORDPRESS_DB_PASSWORD`, `WORDPRESS_DB_NAME`, `WORDPRESS_AUTH_KEY`, `WORDPRESS_SECURE_AUTH_KEY`, `WORDPRESS_LOGGED_IN_KEY`, `WORDPRESS_NONCE_KEY`, `WORDPRESS_AUTH_SALT`, `WORDPRESS_SECURE_AUTH_SALT`, `WORDPRESS_LOGGED_IN_SALT`, `WORDPRESS_NONCE_SALT`, `WORDPRESS_TABLE_PREFIX`, and `WORDPRESS_DEBUG`.

... via `docker-compose` or `docker stack deploy`
Example `docker-compose.yml` for wordpress:
```
version: '3.1'

services:

wordpress:
image: wordpress
restart: always
ports:
- 8080:80
environment:
WORDPRESS_DB_HOST: db
WORDPRESS_DB_USER: exampleuser
WORDPRESS_DB_PASSWORD: examplepass
WORDPRESS_DB_NAME: exampledb
volumes:
- wordpress:/var/www/html

db:
image: mysql:8.0
restart: always
environment:
MYSQL_DATABASE: exampledb
MYSQL_USER: exampleuser
MYSQL_PASSWORD: examplepass
MYSQL_RANDOM_ROOT_PASSWORD: '1'
volumes:
- db:/var/lib/mysql

volumes:
wordpress:
db:
```

Run `docker stack deploy -c stack.yml wordpress` (or `docker-compose -f stack.yml up`), wait for it to initialize completely, and visit `http://swarm-ip:8080`, `http://localhost:8080`, or `http://host-ip:8080` (as appropriate).

# License
View [license information](https://wordpress.org/about/license/) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in the repo-info repository's wordpress/ directory.

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.