# Rook

## Base Setup

This uses Kustomization to effectively do what is described in the
[instructions](https://rook.io/docs/rook/latest-release/Getting-Started/quickstart/#tldr).

## Tuning

As OSDs are started and managed by rook, 
[ceph (auto) tuning](https://docs.ceph.com/en/latest/cephadm/install/#enabling-osd-memory-autotuning) does not work. Rather requests are set in `kustomization.yaml`
using kubernetes mechanisms.

## File Systems

Nothing fancy here, just a general file system for use by clients 
and some file system storage for pods.

If you need access to the file system (example is for podstorage):

 * Get secret: `kubectl -n rook-ceph get secret rook-ceph-client-podstorage -o jsonpath="{.data.userKey}" | base64 -d`
 
 * Mount: `mount -t ceph podstorage@<cluster-id>.podstorage=/ /mnt/test -o mon_addr=192.168.179.21,secret=<secret>`
