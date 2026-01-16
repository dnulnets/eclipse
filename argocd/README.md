# argocd configuration

This is the configuration and changes needed to run argocd.

Use ***kubectl kustomize*** to generate the install yaml. It contains a patch that allows argocd to run insecure within the cluster.

## Dependencies
The following direct dependencies must have been installed in the cluster, they might have additional dependencies:
* istio
* certs/argocd
* gateways/local-gateway

## Routes
Install the routes in **routes.yaml** to be able to access argocd locally.
