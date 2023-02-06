# Ceph, Kubernetes etc.

Ceph installation went smoothly using 
[cephadm](https://docs.ceph.com/en/quincy/cephadm/install/#cephadm-deploying-new-cluster).
Then I understood that hidden within there is an orchestrator and I thought,
why have more than one orchestrator. So let's install Ceph on Kubernetes
([k3s](https://k3s.io/), to be precise) I wanted to learn about Kubernetes 
anyway.

Maybe, just maybe, installing Ceph on Kubernetes isn't what you should
start with when getting acquainted with Kubernetes, but what could go wrong?
I used three VMs configured with Ansible, so it's easy to start from scratch
again. Actually, following the 
[instructions](https://rook.io/docs/rook/v1.10/Getting-Started/quickstart/#tldr)
things went rather smoothly. At least until I added the 
[Ceph dashboard](https://rook.io/docs/rook/v1.10/Storage-Configuration/Monitoring/ceph-dashboard/)
and thought: hey, where are all those nice Grafana dashboards?

There are instructions for adding 
[prometheus](https://rook.io/docs/rook/v1.10/Storage-Configuration/Monitoring/ceph-monitoring/),
but they focus on monitoring Rook (and thus Ceph), while the Grafana dashboards
which are embedded in the Ceph console use additional information from 
[node exporter](https://github.com/prometheus/node_exporter). So, this is
where the fun started...

 * [Node exporter](10_node-exporter/)
 * [Prometheus](20_prometheus/)
 