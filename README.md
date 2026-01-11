# Eclipse kubernetes kluster using talos
This is the configuration repository for my six node talos cluster with six nodes. Three acts as control nodes and the other three as worker nodes. All nodes allow deployment.


The cluster has cilium as a CNI and istio as a service mesh running in ambient mode. The cluster also uses the gateway api and cert manager that handles certificates both private and public via letsencrypt. It has three istio gateways one for the acme protocol, one local and one external.

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

### NTP Time servers
The cluster uses the Netnod distributed time servers at Sundsvall, Sweden. I have not tested using the anycast address ntp.se yet.

```
machine:
   time:
      servers:
         - svl1.ntp.se
         - svl2.ntp.se
```

### Support for longhorn
See the ***README.md*** file for longhorn if you plan on installing it to see what to change in the machine configuration. You need, among other things, also add support for ***siderolabs/iscsi-tools*** and ***siderolabs/util-linux-tools***. Make sure they are included in the talos image you generate from the talos image factory.

# Tips and tricks

## Delete all pods in unknown state

```
kubectl get pods --all-namespaces | grep ContainerStatusUnknown | awk '{print "kubectl delete pod "$2" -n "$1}' | sh
```

## Remove everything from a namespace and then delete the namespace

See ***clean_na.sh*** in the ***script*** directory, it originates from the location describe below.

```
Oracle Consulting Netherlands
2024-05-11, M. van den Akker, Initial Creation
https://github.com/makker-nl/Kubernetes/tree/main/scripts
```

## Untaint nodes
If needed, I had to use this when I experimented with cilium during instalaltion and it go into some strange state where some of the nodes got tainted. So it had to be removed.

```
kubectl taint nodes  talos-3p1-gvn node.kubernetes.io/network-unavailable-
```


