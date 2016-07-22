CHANGELOG
=========

## Project/Repository

### 0.2.0 (Released 2016-06-09)

- Upg: Updated docs to reflect Docker Cloud name change (Previously called Tutum)
- Upg: Including Neam Stacks and supporting images 0.6.2 (see detailed changelog below)
- Upg: Including updated stacks from Herzog Kommunikation - The Application Factory

### 0.1.0 (Released 2016-01-07)

- Init: First official alpha release, as battle-tested in production by the Neam Labs in several projects during more than 6 months (motin, schmunk42)
- Init: Decided on a project/repository structure (motin, schmunk42)
- Init: Including Neam Stacks and supporting images 0.6.1 (see detailed changelog below)

## Neam - Stacks and supporting images

### 0.6.3 (Not yet released)

- Enh: [Debian PHP/Nginx] Including vhost in nginx logs so that multi-tenant deployment logs are easier to separate

### 0.6.2 (Released 2016-06-07)

- Enh: PHP-FPM 7.0.7 images built alongside PHP 5.6 images
- Upg: PHP-FPM 5.6.17 upgraded to 5.6.20
- Upg: HHVM 3.12.0 upgraded to 3.13.1
- Upg: NodeJS upgraded from 0.10 to 4.4
- Upg: Composer updated to latest development version (includes important autoloader performance optimizations for PHP5.6 and 7)
- Upg: All debian packages updated as per 2016-06-07 07:33 (UTC)
- Chg: Removed php-app-tester, replaced by api-mock utility image
- Upg: Tested against Docker 1.11.1 and Docker Compose 1.7.1
- Upg: [Debian PHP/Nginx] Updated supporting deployment stacks to correspond to latest Docker Cloud best practices
- Min: [Debian PHP/Nginx] Enabling xdebug profiler requires local override in Neam Debian PHP/Nginx stack
- Chg: [DNA Project Base] Stack tester shell now based on the production image 
- Enh: [DNA Project Base] Tester shells for HHVM, PHP5 and PHP7.0 can be run in parallel
- Enh: [DNA Project Base] Stack commands for restart and recreate
- Enh: [DNA Project Base] Stack start command ensures that the publicly exposed ports are not in use already
- Enh: [DNA Project Base] Stack router stats commands (stack/router-stats.sh and stack/phphaproxy-stats.sh)
- Enh: [DNA Project Base] Clean-ups and smaller tweaks

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
- Chg: Orientation towards multi-tenancy deployments, where each tenant has access to their own database
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
