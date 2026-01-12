# Longhorn configuration

This is the configuration and changes needed to run longhorn. Make sure you have ***siderolabs/iscsi-tools*** and ***siderolabs/util-linux-tools*** installed. If not you have to upgrade the nodes with an image that contains those extensions.


Run ***talosctl get extensions*** to see that the extensions are installed.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the longhorn root directory.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration

See ***install.sh*** in the install directory.


### Namespace
The namespace for longhorn, i.e. the ***longhorn-system*** needs to have some labels set up for talos to give it needed privileges.

```
apiVersion: v1
kind: Namespace
metadata:
  name: longhorn-system
  labels:
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/enforce-version: latest
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/audit-version: latest
    pod-security.kubernetes.io/warn: privileged
    pod-security.kubernetes.io/warn-version: latest
```

### Volume mounts
Make sure that the machineconfiguration for all nodes has the following snippet:

```
machine:
   kubelet:
      extraMounts:
         - destination: /var/lib/longhorn
            type: bind
            source: /var/lib/longhorn
            options:
            - bind
            - rshared
            - rw
```

## Routes
The root contains ***routes.yaml*** to add longhorn to the internal url ***longhorn.home***.

## Backup
The root contains ***digitalocean-secret-sealed.yaml*** that adds a secret that can be used by longhorn for the s3s backups.
