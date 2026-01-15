# forgejo configuration

This is the configuration and changes needed to run a software repository based on forgejo (git). It uses a mysql cluster based on cnpg.

Use kubectl apply on the yaml files manually written.

## Dependencies
The following direct dependencies must have been installed in the cluster, they might have additional dependencies:
* sealed secrets
* istio
* certs/forgejo-certificate
* cnpg
