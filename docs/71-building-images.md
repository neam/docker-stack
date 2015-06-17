## Building images

To build the collections of images for the stacks, you can run `make` as follows

    make neam
    
or by specifying the `Makefile` directly   

    make -f Makefile-schmunk42 build

To build all images in all collections, which *may take a while*, run

    make all
    
    
### Add tokens in CI

You can inject GitHub tokens in your CI build script with the following lines
    
    export GITHUB_TOKEN=<YOUR_TOKEN>
    sed -i  "s|0000000000000000000000000000000000000000|${GITHUB_TOKEN}|" images/php-nginx.yii2.phundament/php-cli-dev/config.json 
    
> Note: If you test this command on OS X (Darwin) you need to use `sed -i .bak <...>`    