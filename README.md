# Kubernetes kluster using talos
This is the configuration repository for my six node talos cluster. Three acts as control nodes and the other three as worker nodes. All nodes allow deployment.


The cluster has cilium as a CNI and istio as a service mesh running in ambient mode. The cluster also uses the gateway api and cert manager to handle both private and public (letsencrypt) certificates. It has three istio gateways one for the acme protocol, one local and one external.


Each directory contains a ***README.md*** for further information on the specific deployment.

## Directory structure
The eclipse root configuration directory contains one directory for the talos configuration and the other for all the kubernetes installations that can be added, such as cilium, longhorn, certmanger, dashboard and so on.

## Configuration
The cluster consists of six nodes and three of them runs the control plane. The cluster has a VIP for kubectl to use to be able to be somewhat robust on node failures. Also see the cilium configuration if you decide to use the cilium CNI instead of the default flannel or any other CNI. Currently I do not use any cilium specific features, but that might change.

### Allow deployment on the control planes
To use the control planes as worker nodes add this to the machine configuration for the control nodes.

```
cluster:
   allowSchedulingOnControlPlanes: true
```

### Configure a VIP
To have one VIP that can reach all three control nodes talos can announce a VIP during startup and failures. To have this enabled add this to the machine configuration for the control nodes. It might need to be changed depending on how your hardware is configured.

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

### Support for longhorn - distributed block storage
See the ***README.md*** file for longhorn if you plan on installing it to see what to change in the machine configuration. You need, among other things, also add support for ***siderolabs/iscsi-tools*** and ***siderolabs/util-linux-tools***. Make sure they are included in the talos image you generate from the talos image factory.
