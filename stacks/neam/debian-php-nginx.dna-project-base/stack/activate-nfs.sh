#!/usr/bin/env bash

# use nfs locally on mac for performance
if [ $(uname -s) = "Darwin" ]; then
    # make sure we use NFS for /Users mount
    echo '/Users:/Users' > stack/d4m-nfs/etc/d4m-nfs-mounts.txt
    # activate nfs
    stack/d4m-nfs/d4m-nfs.sh
else
    echo "Not a mac, not activating NFS"
fi

exit 0