# Rook

## Base Setup

This uses Kustomization to effectively do what is described in the
[instructions](https://rook.io/docs/rook/v1.10/Getting-Started/quickstart/#tldr).

k3s lacks the local storage class which caused problems, therefore it's
introduced here.

## File Systems

Nothing fancy here, just a general file system for use by clients 
and some file system storage for pods.

If you need access to the file system (example is for podstorage):

 * Get secret: `kubectl -n rook-ceph get secret rook-ceph-client-podstorage -o jsonpath="{.data.userKey}" | base64 -d`
 
 * Mount: `mount -t ceph podstorage@<cluster-id>.podstorage=/ /mnt/test -o mon_addr=192.168.179.21,secret=<secret>`