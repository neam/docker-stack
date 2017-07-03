CHANGELOG
=========

## Project/Repository

### 0.3.0 (Not yet released)

- Chg: Assumes native docker instead of docker via docker-machine/virtualbox for local dev
- Upg: Including Neam Stacks and supporting images 0.7.0 (see detailed changelog below)
- Enh: Clean-ups and clarifications

### 0.2.0 (Released 2016-06-09)

- Upg: Updated docs to reflect Docker Cloud name change (Previously called Tutum)
- Upg: Including Neam Stacks and supporting images 0.6.2 (see detailed changelog below)
- Upg: Including updated stacks from Herzog Kommunikation - The Application Factory
- Upg: Tested against Docker 1.11.1 and Docker Compose 1.7.1

### 0.1.0 (Released 2016-01-07)

- Init: First official alpha release, as battle-tested in production by Neam Labs in several projects during more than 6 months (motin, schmunk42)
- Init: Decided on a project/repository structure (motin, schmunk42)
- Init: Including Neam Stacks and supporting images 0.6.1 (see detailed changelog below)

## Stacks and supporting images

### 0.7.0 (Not yet released)

- Enh: [Neam Debian PHP/Nginx] Including vhost in nginx logs so that multi-tenant deployment logs are easier to separate
- Enh: [Neam Debian PHP/Nginx] Using Docker compose version 2 format, self-reconfiguring php-scaling locally, clarifications, tweaks
- Enh: [Neam Stacks] Install pipe viewer (pv) to monitor progress of commands that pipes large files
- Enh: [DNA Project Base] Install tmate for on-demand ssh access directly into containers
- Enh: [DNA Project Base] Using PHP 7 by default in production
- Enh: [DNA Project Base] MySQL upgraded from 5.6.27 to 5.7.11
- Chg: [DNA Project Base] Renamed the file for specifying default local cli data profile from ".current-local-cli-data-profile" to ".default-local-cli-data-profile"
- Enh: [DNA Project Base] Improvements and bug fixes

### 0.6.2 (Released 2016-06-07)

- Enh: [Neam Debian PHP/Nginx] PHP-FPM 7.0.7 images built alongside PHP 5.6 images
- Upg: [Neam Debian PHP/Nginx] PHP-FPM 5.6.17 upgraded to 5.6.30
- Upg: [Neam Debian PHP/Nginx] HHVM 3.12.0 upgraded to 3.13.1
- Upg: [Neam Debian PHP/Nginx] Composer updated to latest development version (includes important autoloader performance optimizations for PHP5.6 and 7)
- Upg: [Neam Debian PHP/Nginx] Updated supporting deployment stacks to correspond to latest Docker Cloud best practices
- Min: [Neam Debian PHP/Nginx] Enabling xdebug profiler requires local override in Neam Debian PHP/Nginx stack
- Upg: [Neam Stacks] All debian packages updated as per 2016-06-07 07:33 (UTC)
- Upg: [Neam Stacks] NodeJS upgraded from 0.10 to 4.4
- Chg: [Neam Stacks] Removed php-app-tester, replaced by api-mock utility image
- Chg: [Neam DNA Project Base] Stack tester shell now based on the production image 
- Enh: [Neam DNA Project Base] Tester shells for HHVM, PHP5 and PHP7.0 can be run in parallel
- Enh: [Neam DNA Project Base] Stack commands for restart and recreate
- Enh: [Neam DNA Project Base] Stack start command ensures that the publicly exposed ports are not in use already
- Enh: [Neam DNA Project Base] Stack router stats commands (stack/router-stats.sh and stack/phphaproxy-stats.sh)
- Enh: [Neam DNA Project Base] Clean-ups and smaller tweaks

### 0.6.1 (Released 2016-02-26)

- Upg: [Neam Debian PHP/Nginx] PHP-FPM 5.6.14 upgraded to 5.6.17
- Upg: [Neam Debian PHP/Nginx] HHVM 3.11.0 upgraded to 3.12.0
- Enh: [Neam Debian PHP/Nginx] PHP-FPM uses the native MySQL driver (mysqlnd) by default
- Enh: [Neam Debian PHP/Nginx] PHP-FPM xdebug extension included in image (disabled by default)
- Enh: [Neam Debian PHP/Nginx] Publishing default xdebug ports locally by default
- Upg: [Neam Stacks] All debian packages updated as per 2016-02-26 10:52

### 0.6.0 (Released 2016-01-07)

- Enh: [Neam Debian PHP/Nginx] Made the debian-php-nginx stack include more components out-of-the-box
- Enh: [Neam Debian PHP/Nginx] Added the debian-php-nginx.database stack that showcases how database engines are added to a stack
- Enh: [Neam Debian PHP/Nginx] Retagged base neam docker images to clarify that the php images includes both php fpm and hhvm (together with their respective versions)
- Upg: [Neam Debian PHP/Nginx] PHP-FPM 5.6.13 upgraded to 5.6.14
- Upg: [Neam Debian PHP/Nginx] HHVM 3.9.1 upgraded to 3.11.0 (Includes PHP 7 language support)
- Upg: [Neam Stacks] All debian packages updated as per 2016-02-26 10:52
- Enh: [Neam Stacks] Documentation improvements and clean-up

### 0.5.0 (Released 2015-10-27)

- Enh: [Neam Stacks] Using up-to-date version of haproxy image supporting Blue/Green zero-downtime deployments
- Chg: [Neam Stacks] Orientation towards multi-tenancy deployments, where each tenant has access to their own database
- Enh: [Neam Stacks] Added sample tutum maintenance stack configurations (for newrelic, distributed logging and enabling node ssh access)
- Enh: [Neam Stacks] Performance and stability tweaks

### 0.4.0 (Released 2015-10-06)

- Enh: [Neam Debian PHP/Nginx] Enabled use of HHVM as an alternative to PHP-FPM
- Chg: [Neam Debian PHP/Nginx] Using HHVM instead of PHP-FPM by default (PHP-FPM can still be re-enabled on a per-project bases in case issues with HHVM are encountered)
- Upg: [Neam Debian PHP/Nginx] PHP 5.6.9 upgraded to 5.6.13
- Upg: [Neam Stacks] All debian packages updated as per 2015-10-06 16:16
- Enh: [Neam Stacks] DNA Project Base stack includes a local database container with persistent local data enabled by default
- Enh: [Neam Stacks] Sane default Xdebug configuration provided. Xdebug verified to work with current stack.
- Min: [Neam Stacks] Tweaks to stack documentation

### 0.3.0 (Released 2015-08-13)

- Chg: [Neam Debian PHP/Nginx] A revert to official debian base image (instead of tutum's debian image as in 0.2.0)
- Upg: [Neam Debian PHP/Nginx] PHP 5.6.7 upgraded to 5.6.9
- Enh: [Neam Stacks] Lockdown of haproxy image to a working one (pending refactoring to use the latest upstream master)
- Chg: [Neam Stacks] A reliance on tutum’s docker exec support for shell access instead of using a separate worker container with a ssh service running
- Enh: [Neam DNA Project Base] Added some shorthand-scripts (start, stop, setup, logs, open-browser) to interact with the stack
- Min: [Neam Stacks] Omitting PHP warning about $HTTP_RAW_POST_DATA
- Min: [Neam Stacks] Added Xdebug default enable setting env var to php images
- Upg: [Neam Stacks] All debian packages updated as per 2015-08-13 10:53
- Min: [Neam Stacks] Some tweaks to stack documentation

### 0.2.0 (Released 2015-04-23)

- Chg: [Neam Debian PHP/Nginx] Based on Tutum's jessie image with optional ssh support
- Enh: [Neam DNA Project Base] Tons of performance and reliability tweaks after having battle-tested the stack in production
- Enh: [Neam DNA Project Base] Added php-xsl to dna project base php image

### 0.1.0 (In development between 2015-03-15 and 2015-04-23, never tagged as 0.1.0)

- Init: Initial version
