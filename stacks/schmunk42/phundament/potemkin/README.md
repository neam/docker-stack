> WORK IN PROGRESS

Edit `docker-compose.yml`, "over-mount" your module in vendor.
    
    appcli:
        volumes:
            - ./:vendor/bedezign/yii2-audit

Run

    docker-compose run appcli bash

In the cli-container install your module (that part needs some work, maybe - MAKE A BACKUP OF YOUR DATA BEFOREHAND)

    composer install bedezign/yii2-audit    
    
Then go to vendor/bedezign/yii2-audit

    codecept run


