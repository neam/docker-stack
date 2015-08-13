## Building images

To build the collections of images for the stacks, you can run `make` as follows

    make schmunk42
    make neam
    
or by specifying the `Makefile` directly   

    make -f Makefile-schmunk42 build

To build all images in all collections, which *may take a while*, run

    make all
    
### Add tokens in CI

For some schmunk42 images, you need to inject GitHub tokens in your CI build script with the following lines:
    
    export GITHUB_TOKEN=<YOUR_TOKEN>
    sed -i  "s|0000000000000000000000000000000000000000|${GITHUB_TOKEN}|" images/php-nginx.yii2.phundament/php-cli-dev/config.json 
    
> Note: If you test this command on OS X (Darwin) you need to use `sed -i .bak <...>`
    
## Release/distribute/push images

To push the collections of images for the stacks, you can run `make` as follows

    make -f Makefile-schmunk42 release-schmunk42
    make -f Makefile-neam release-neam
    
If you do not have write access to these repositories, copy the related build and release make-targets and adapt them to tag the images properly to your registry.
