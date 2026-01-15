# Certificates

This directory contains all of the certificates in the kubernetes cluster. Both private and public certificates.

It uses the cert-manager to create them. They have to be located in the same namespace as the gateways and in this case it is the same namespace as the ***istio-system***.

## Dependencies
The following direct dependencies must have been installed in the cluster, they might have additional dependencies:
* cert-manager