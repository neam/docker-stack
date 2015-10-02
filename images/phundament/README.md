Docker images for PHP-FPM + nginx for Phundament 4
==================================================

php
---

### fpm-prod

 - installation of PHP-extensions for Phundament 4.0
   - ftp
   - ssl
   - 512M max upload and max post size

### fpm-dev

 - installation of PHP-extensions for development
   - xdebug
   - bcmath
   - soap
 - yui-compressor
 - closure-compiler
  
### cli-prod

 - mysql-client
 - openssh-client
 
### cli-dev

 - installation of PHP-extensions for development
   - bcmath
   - soap
 - yui-compressor
 - closure-compiler
 - linkchecker
 - codeception (composer global)
 - cached Phundament application packages