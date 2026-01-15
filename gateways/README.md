# Gateways in the cluster
This directory contains the three gateways for internal, external and acme routes. It uses the gateway API and the istio gateway class. It has fixed IP taken from the load balancer pool.


My router routes incoming traffic to the acme and external gateways to their IP-addresses based on incoming port numbers.

## Dependencies
The following direct dependencies must have been installed in the cluster, they might have additional dependencies:
* sealed secrets
* cnpg
* gateways
* certs/forgejo-certificates

