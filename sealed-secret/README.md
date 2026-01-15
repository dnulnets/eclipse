# Sealed secrets configuration

This is the configuration and changes needed to run the sealed secrets controller.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the sealed secrets root directory.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration


### Version, namespace and installation parameters
Sets the version and namespace for the sealed secret controller. Helm do not always autodetect the kubernetes version when generating the template, so we need to set it manually. Make sure it is the version used by talos. You can use ***talosctl dashboard -n IP*** command to view the version of the kube-system.

The ***fullNameOverride*** is to make it easier to use the sealed secret cli tool so you do not have to specifiy the name of the controller on the cammnd line. See the sealed secret git hub repository for more information ***https://github.com/bitnami-labs/sealed-secrets***

```
--version 2.18.0 
--kube-version v1.34.1
--set-string fullnameOverride=sealed-secrets-controller
-n kube-system
```
