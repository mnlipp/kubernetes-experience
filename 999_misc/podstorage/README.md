# Storage class

Nothing fancy here, just some file system storage for pods.

If you need access to the file system:

 * Get secret: `kubectl -n rook-ceph get secret rook-ceph-client-podstorage -o jsonpath="{.data.userKey}" | base64 -d`
 
 * Mount: `mount -t ceph podstorage@<cluster-id>.podstorage=/ /mnt/test -o mon_addr=192.168.179.21,secret=<secret>`
