# Eclipse kubernetes kluster
This is the configuration repository for my six node talos cluster with three control nodes, which also acts as worker nodes, and three dedicated worker nodes.

## Directory structure
The eclipse root configuration directory contains one directory for the talos configuration and the other for all the kubernetes installations that can be added, such as cilium, longhorn, certmanger, dashboard and so on.

## Configuration
The cluster consists of six nodes and three of them runs the control plane and the cluster has a VIP for kubectl to use. Also see the cilium configuration if you decide to use the cilium CNI instead of the default flannel or any other CNI.

### Allow deployment on the control planes
To use the control planes as worker nodes as well add this to the machine configuration for the control nodes.

```
cluster:
   allowSchedulingOnControlPlanes: true
```

### Configure a VIP
To have one IP to all three control nodes talos can announce a VIP. To have this enabled add this to the machine configuration for the control nodes.

```
machine:
   network:
         interfaces:
            - deviceSelector:
               physical: true
               dhcp: true
               vip:
               ip: 192.168.1.8

```
### Support for longhorn
See the readme file for the longhorn installation if you plan on installing longhorn. You need to add support for ***siderolabs/iscsi-tools*** and ***siderolabs/util-linux-tools*** into the image. Make sure they are included in the talos image you generate from the talos image factory.

# Tips and tricks

## Delete all pods in unknown state

```
kubectl get pods --all-namespaces | grep ContainerStatusUnknown | awk '{print "kubectl delete pod "$2" -n "$1}' | sh
```

## Remove everything from a namespace and then delete the namespace

See clean_na.sh

```
Source - https://stackoverflow.com/a
Posted by Arghya Sadhu, modified by community. See post 'Timeline' for change history
Retrieved 2025-11-28, License - CC BY-SA 4.0
```

## Untaint nodes

```
kubectl taint nodes  talos-3p1-gvn node.kubernetes.io/network-unavailable-
```


