# k3s Configuration

My k3s runs on a cluster with three nodes that are configured for HA 
rather than high performance. I have some HDDs but only one small SSD 
on each machine and therefore need some tuning with respect to storage 
usage.

## etcd

As you can read everywhere, etcd requires fast storage. So we have
to put it on SSD. Regrettably, there is 
[no simple way](https://github.com/k3s-io/k3s/issues/6992) to configure
the storage directory for the etcd data directory.

The workaround is to create a file system on SSD storage (8 GiB should
be sufficient), stop k3s, move the content of `${data-dir}/server/db`
to the new file system, mount it on `${data-dir}/server/db` (create
an entry in `/etc/fstab` and mount/test with `mount -a`) and start k3s again.

Note that `--cluster-reset` deletes the directory with the mount point 
for the fast (SSD) filesystem mounted on `${data-dir}/server/db`. So take 
care to re-mount before starting k3s again after a cluster reset.

## Local-path storage

As k3s is not the only application running on my servers, they are
"partially pets", not cattle. Therefore two HDDs have been put in a
LVM volume group and the root file system has been created in
a "raid1 + SSD cache" setup. So I don't want k3s' local-path
storage on this filesystem.

Luckily, this can easily be handled with an addition setup parameter:

```
--default-local-storage-path /var/local/k3s/local-path
```

Make sure that the directory exists before starting k3s for the first
time.

## Load balancer

I use MetalLB because k3s' built-in load balancer does not support
virtual IPs. Requires k3s to be installed with `--disable=servicelb`.

## Traefik

It is unnecessarily difficult to configure k3s' built-in Traefik.
So I install it with `--disable=traefik` and add Traefik myself.

```sh
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
kubectl create namespace traefik
helm install -f values.yaml traefik . --namespace=traefik
```

## Volume snapshots

k3s does not support [volume snapshots] out-of-the-box. We have to
[add this feature](snapshots/README.md).
