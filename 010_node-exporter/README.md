# Node Exporter

It took me some time to understand what node exporter is and does. 
It was one of the services shown in the console when I installed
Ceph with cephmgr. So I assumed it to be part of Ceph. But it has 
nothing to do with Ceph. It is part of
Prometheus and provides a node's metrics to Prometheus. Cephmgr
only starts it when it does orchestration. Well, this is what
we want Kubernetes to do now.

According to the Prometheus documentation, node exporters should 
[not be run in containers](https://github.com/prometheus/node_exporter#docker).
But I found several resources explaining how to to this and they all
lacked big caveats. So I gave it a try. The daemon set defined here
combines several inputs and most likely needs to be refined. But it works.
