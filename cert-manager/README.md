# Cert manager

This is the certificate manager used when creating both private and public certificates using the gateway API and letsencrypt.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the cert-manager root directory such as the issuers.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration
Cert manager must use the gateway API becasue istio uses it and there is already a default ACME gateway created that cert-manager can use. So the following settings must be made when generating the deployment. 

```
config.enableGatewayAPI=true
config.apiVersion="controller.config.cert-manager.io/v1alpha1"
config.kind="ControllerConfiguration"
crds.enabled=true
```

Look into the upgrade directories to see how they are applied in the helm command.

# Issuers
The root directory contains a set of standard issuers that the cluster is using, it is one private issuer used for all local certificates and two lets encrypt for public certificates. One is for the staging environment and the other is for production.


The certificates in the **cert** directory uses the local private issuer or the production version of lets encrypt.
