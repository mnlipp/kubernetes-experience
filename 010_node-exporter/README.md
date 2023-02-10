# Node Exporter

Node exporters obviously should 
[not be run in containers](https://github.com/prometheus/node_exporter#docker).
But I found several resources explaining how to to this and they all
lacked big caveats. So I gave it a try. The daemon set defined here
combines several inputs and most likely needs to be refined. But it works.