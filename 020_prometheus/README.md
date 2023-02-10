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

After these preparations, we can create the Prometheus instance. In order
to be able to reference the instance later from Grafana (also running
on Kubernetes), a NodePort-Service is created. This adds an entry to the
Kubernetes-DNS and thus makes the instance easily accessible within the
cluster. It is also accessible via `kubectl proxy` using
[http://localhost:8001/api/v1/namespaces/monitoring/services/http:prometheus:web/proxy/](http://localhost:8001/api/v1/namespaces/monitoring/services/http:prometheus:web/proxy/).

Finally, we add scraping the node exporters with a pod monitor and scraping
the rook-ceph-mgr with a service manager.
