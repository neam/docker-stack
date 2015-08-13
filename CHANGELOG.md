CHANGELOG
=========


# Neam stacks and supporting images

## 0.3.0 (Released 2015-08-13)

- Chg: A revert to official debian base image (instead of tutum's debian image as in 0.2.0)
- Upg: PHP 5.6.7 upgraded to 5.6.9
- Enh: Lockdown of haproxy image to a working one (pending refactoring to use the latest upstream master)
- Chg: A reliance on tutum’s docker exec support for shell access instead of using a separate worker container with a ssh service running
- Enh: Added some shorthand-scripts (start, stop, setup, logs, open-browser) to interact with the stack
- Min: Omitting PHP warning about $HTTP_RAW_POST_DATA
- Min: Added Xdebug default enable setting env var to php images
- Upg: All debian packages updated as per 2015-08-13 10:53
- Min: Some tweaks to stack documentation

## 0.2.0 (Released 2015-04-23)

- Enh: Tons of performance and reliability tweaks after having battle-tested the stack in production (motin)
- Chg: Based on Tutum's jessie image with optional ssh support (motin)
- Enh: Added php-xsl to dna project base php image (motin)

## 0.1.0 (In development between 2015-03-15 and 2015-04-23, never tagged as 0.1.0)

- Init: Initial version (motin)
