# Docker registry

Create a temporary docker registry for development purposes.

Must be made known to k3s by adding on each node 
to `/etc/rancher/k3s/registries.yaml`:

```
mirrors:
  "registry.domain.org":
    endpoint:
      - "http://registry.domain.org"
configs:
  "registry.domain.org":
    tls:
      insecure_skip_verify: true
      
```