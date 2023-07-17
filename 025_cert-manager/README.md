# Cert-Manager

It turns out that you have to accept too many exceptions with 
self-signed certificates. As my test cluster is not accessible
from the internet, I cannot use letsencrypt to get the real
certificates. Instead I've configure my own CA and installed
the root certificate in the browser (see the 
[OpenSSL documentation](https://www.openssl.org/docs/) and the
[recommended book](https://www.feistyduck.com/books/openssl-cookbook/).

Get yourself a subordinate CA with its certificate any key.

Install 
[with helm](https://artifacthub.io/packages/helm/cert-manager/cert-manager).

Now all you need is to create the CA resource and its secret, using
your subordinate CA's certificate and key.