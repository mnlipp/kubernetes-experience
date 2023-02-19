# Prometheus

I'll put the most general aspects of Prometheus in the `monitoring`
namespace.

 * The Prometheus operator
 * A Prometheus instance for "general" metrics, especially those
   required for the Ceph dashboard
   
[Installing the operator](https://prometheus-operator.dev/docs/user-guides/getting-started/#installing-the-operator) is quite straightforward.

For the Prometheus instance, we need

 * a service account,
 * a cluster role and
 * their binding
 
The Prometheus operator does not support the "subscribe for scraping"
mechanism that you can see in many examples (using annotation
`prometheus.io/scrape: true`). The required Prometheus configuration has
to be "passed through" as described 
[here](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/additional-scrape-config.md).

Before creating the Prometheus instance, you have to decide if you want
to keep the collected data for the lifetime of the pod or as long term
historical data. For the latter, you need a storage class other than
`local-path`. If you don't have one yet, you can create e.g. "rook-cephfs" 
as shown [here](../999_misc/podstorage/README.md).

After these preparations, we can create the Prometheus instance. 
Regrettably, there is 
[a problem](https://github.com/prometheus-operator/prometheus-operator/issues/5354)
with accessing the persistent volume. So make sure to add the
`fsGroup` as shown in my [sample file](./50_prometheus.yaml).

In order to be able to reference the Prometheus instance from Grafana 
(also running on Kubernetes), we now create a NodePort-Service. This 
adds an entry to the Kubernetes-DNS and thus makes the instance easily 
accessible within the cluster. It is also accessible via `kubectl proxy` using
[http://localhost:8001/api/v1/namespaces/monitoring/services/http:prometheus:web/proxy/](http://localhost:8001/api/v1/namespaces/monitoring/services/http:prometheus:web/proxy/).

Finally, we add scraping the node exporters with a pod monitor and scraping
the rook-ceph-mgr with a service manager. When scraping from the 
node exporters, the value of `__meta_kubernetes_pod_node_name` must be 
[used as instance label](https://github.com/prometheus-operator/prometheus-operator/issues/135) else metrics will be recorded by the cluster IP address 
(which usually changes after each boot).
