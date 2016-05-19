CHANGELOG
=========

## Project/Repository

### 0.2.0 (Not yet released)

- Init: Including Neam Stacks and supporting images 0.6.2 (see detailed changelog below)
- Min: Added --rm flag on docker-compose run commands in docs

### 0.1.0 (Released 2016-01-07)

- Init: First official alpha release, as battle-tested in production by the Neam Labs in several projects during more than 6 months (motin, schmunk42)
- Init: Decided on a project/repository structure (motin, schmunk42)
- Init: Including Neam Stacks and supporting images 0.6.1 (see detailed changelog below)

## Neam - Stacks and supporting images

### 0.6.2 (Not yet released)

- Upg: Composer updated to latest development version (includes important autoloader optimizations for PHP5.6 and 7)

### 0.6.1 (Released 2016-02-26)

- Upg: PHP-FPM 5.6.14 upgraded to 5.6.17
- Upg: HHVM 3.11.0 upgraded to 3.12.0
- Upg: All debian packages updated as per 2016-02-26 10:52
- Enh: PHP-FPM uses the native MySQL driver (mysqlnd) by default
- Enh: PHP-FPM xdebug extension included in image (disabled by default)
- Enh: Publishing default xdebug ports locally by default

### 0.6.0 (Released 2016-01-07)

- Enh: Made the debian-php-nginx stack include more components out-of-the-box
- Enh: Added the debian-php-nginx.database stack that showcases how database engines are added to a stack
- Enh: Retagged base neam docker images to clarify that the php images includes both php fpm and hhvm (together with their respective versions)
- Upg: PHP-FPM 5.6.13 upgraded to 5.6.14
- Upg: HHVM 3.9.1 upgraded to 3.11.0 (Includes PHP 7 language support)
- Upg: All debian packages updated as per 2016-02-26 10:52
- Enh: Documentation improvements and clean-up

### 0.5.0 (Released 2015-10-27)

- Enh: Using up-to-date version of haproxy image supporting Blue/Green zero-downtime deployments
- Chg: Orientation towards for multi-tenancy deployments, where each tenant has a separate database connection
- Enh: Added sample tutum maintenance stack configurations (for newrelic, distributed logging and enabling node ssh access)
- Enh: Performance and stability tweaks

### 0.4.0 (Released 2015-10-06)

- Enh: Enabled use of HHVM as an alternative to PHP-FPM
- Chg: Using HHVM instead of PHP-FPM by default (PHP-FPM can still be re-enabled on a per-project bases in case issues with HHVM are encountered)
- Upg: PHP 5.6.9 upgraded to 5.6.13
- Enh: DNA Project Base stack includes a local database container with persistent local data enabled by default
- Enh: Sane default Xdebug configuration provided. Xdebug verified to work with current stack.
- Upg: All debian packages updated as per 2015-10-06 16:16
- Min: Tweaks to stack documentation

### 0.3.0 (Released 2015-08-13)

- Chg: A revert to official debian base image (instead of tutum's debian image as in 0.2.0)
- Upg: PHP 5.6.7 upgraded to 5.6.9
- Enh: Lockdown of haproxy image to a working one (pending refactoring to use the latest upstream master)
- Chg: A reliance on tutum’s docker exec support for shell access instead of using a separate worker container with a ssh service running
- Enh: Added some shorthand-scripts (start, stop, setup, logs, open-browser) to interact with the stack
- Min: Omitting PHP warning about $HTTP_RAW_POST_DATA
- Min: Added Xdebug default enable setting env var to php images
- Upg: All debian packages updated as per 2015-08-13 10:53
- Min: Some tweaks to stack documentation

### 0.2.0 (Released 2015-04-23)

- Enh: Tons of performance and reliability tweaks after having battle-tested the stack in production (motin)
- Chg: Based on Tutum's jessie image with optional ssh support (motin)
- Enh: Added php-xsl to dna project base php image (motin)

### 0.1.0 (In development between 2015-03-15 and 2015-04-23, never tagged as 0.1.0)

- Init: Initial version (motin)

## Schmunk42 - Stacks and supporting images

No changelog entry yet.
