# Istio configuration

This is the configuration and changes needed to run istio in ambient mode on top of cilium in my kubernetes kluster. You also need to install the experimental gateway API CRD:s, they are located in the install directory.

For the istio based gateways see the gateway directory.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the istio root directory.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration
I use the istioctl instead of helm, so make sure you have the correct version of istioctl before generating the manifest.


See ***install.sh*** in the install directory for how to use ***istioctl***.

### Namespace
The namespace for istio, i.e. the ***istio-system*** needs to have some labels set up for talos to give it needed privileges.

```
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: istio-system
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/enforce-version: latest
  name: istio-system
```
The deployment for the namespace is located in the ***ns.yaml*** file in the root directory.

### Ambient mode
The enable ambient mode for the installation you must set the profile to ambient.

```
profile=ambient
```
### Gateway API
To enable the gateway API you have to enable the pilot functionality.

```
values.pilot.env.PILOT_ENABLE_ALPHA_GATEWAY_API=true
```
