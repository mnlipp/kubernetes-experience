# Grafana

This is (the admin's) general purpose Grafana. It lives in the
monitoring namespace.

We create

 * a [PVC](10_grafana_pvc.yaml) for storing the dashboards,
 * a `grafana.ini` and
 * a datasource for our prometheus (as a convenience),
 * the Grafana [instance](30_grafana-deployment.yaml) itself,
 * a service and
 * an ingress route.
 
A nice dashboard is "Node Exporter Full" (1860).