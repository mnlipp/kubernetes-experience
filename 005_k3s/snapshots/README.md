## Snapshots

k3s does 
[not support](https://github.com/k3s-io/k3s/pull/6459#issuecomment-1334178033)
PV snapshots out-of-the-box. The feature can, however, easily be added using 
[this project](https://github.com/piraeusdatastore/helm-charts/tree/main/charts/snapshot-controller).

`helm install -n kube-system snapshot-controller piraeus-charts/snapshot-controller`
