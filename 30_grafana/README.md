# Grafana

The Ceph 
[dashboard definitions](https://github.com/ceph/ceph/tree/v17.2.5/monitoring/ceph-mixin/dashboards_out)
are provided in a directory using a config map. This is the easiest way 
but pushes the mechanism to its limits. The config map can be created 
and replaced, but 
[not applied](https://github.com/argoproj/argo-cd/issues/820).
(This could be replaced by e.g. an init container.)

Additional config maps provide more configuration information
(`grafana.ini`, `provisioning/datasources/prometheus.yaml` and
`provisioning/dashboards/dashboards.yaml`).

With this in place, we can 
[deploy Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/#deploy-grafana-oss-on-kubernetes). As all configuration 
information is provided as described above and the grafana instance is 
specific for Ceph, no persistant volume is provided.
Note that deployment takes some time because grafana has only limited
resources available (dimensioned for usage, not for initialization).

Access to the Grafana instance is made available with ingress because
the Grafana dashboards are embedded in the Ceph dashboard with iframes
and must therefore be accessible from outside the cluster.
