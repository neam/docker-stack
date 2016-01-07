## Building images

To build the collections of images for the stacks, you can run `make` as follows

    make neam
    
or by specifying the `Makefile` directly

    make -f Makefile-neam build

## Release/distribute/push images

To push the collections of images for the stacks, you can run `make` as follows

    make -f Makefile-neam release-neam
    
If you do not have write access to these repositories, copy the related build and release make-targets and adapt them to tag the images properly to your registry.
