# Prometheus IPMI Exporter

Currently using 
[this exporter](https://github.com/prometheus-community/ipmi_exporter) 
listed in the community section. Should be replaced because it is
rather a hack to invoke the command line tools instead of using the API.

Make sure to install the freeipmi package. You have to do this manually,
even when using the rpm, as there is no package dependency.

I run this outside kubernetes to avoid difficulties with permissions.
As a result, I have to add a a job to the 
[configuration](../../../020_prometheus/45_additional/prometheus-additional.yaml)
which is passed through to the prometheus instance.

```yaml
- job_name: 'ipmi'
  scrape_interval: 10s
  scrape_timeout: 5s
  relabel_configs:
    - source_labels: [__address__]
      action: replace
      regex: ([^\.:]+).*
      target_label: instance
  static_configs:
    - targets: ["one", "two", "more"]
```
