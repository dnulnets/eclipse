# Eclipse talos cilium configuration

This is the configuration and changes neede to run cilium on a talos kubernetes cluster. It is also configured to run
with L2-Announcement for loadbalancing, together with istio in ambient mode and with no kube-proxy.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the cilium root directory such as the loadbalancer pool and L2 accouncement.


I usually use kubctl apply on yaml files either manually written by myself or generated from helm with template command.

## Configuration
The needed configuration are supplied to helm when generating the templae yaml file. See the install or upgrade scripts in each directory for how it is set up.

The talos controlplane cannot have the kube-proxy and default cni (which is flannel) installed. You have to remove them from the machine configuration of the control planes and clean up the kube-proxy and flannel deployments from the cluster. They are usually installed by default during the startup/instalaltion of the cluster unless you did the modifications beforehand.

Patch the configuration with the following:

```
cluster:
  network:
    cni:
      name: none
  proxy:
    disabled: true
```

You then have to remove the kube-proxy and the flannel cni from the cluster.

```
kubectl delete daemonset -n kube-system kube-flannel
kubectl delete daemonset -n kube-system kube-proxy
kubectl delete cm kube-flannel-cfg -n kube-system
```

### Version, namespaces and installation parameters
Sets the version and namespace for the cilium platform. Somehow helm do not autodetect the kube-version when gerenating the template or use dry-run, so we need to specify it. Make sure it is the version used by talos. You can use the talosctl dashboard command to view the version of the kube-system.

```
--version 1.18.4
--namespace kube-system
--kube-version v1.34.1
--set tls.secretsNamespace.create=false
```

### Configuring for istio
I run cilium with kube-proxy removed so cilium fully replaces it. To make it function with istio the following configurations needs to be done. I have used recommendations from both cilium and istio on the settings. Also if you are using BPF make sure that ***bpf.masquerade=false***. It is the default in cilium.

```
--set kubeProxyReplacement=true
--set socketLB.hostNamespaceOnly=true
--set cni.exclusive=false
```

### IP address management
I have only tested with kubernetes scope.
```
--set ipam.mode=kubernetes
```

### L2 Annoucement
To make use of ciliums load balancer pool we have to enable L2 Announcement and increase the rate limits for qps and bursts,

```
--set l2announcements.enabled=true
--set k8sClientRateLimit.qps=50
--set k8sClientRateLimit.burst=200
```

### No kube proxy
To set up cilium for replacing the kube-proxy you need the following configurations.

```
--set k8sServiceHost=localhost
--set k8sServicePort=7445
--set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}"
--set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}"
--set cgroup.autoMount.enabled=false
--set cgroup.hostRoot=/sys/fs/cgroup
```

### With gateway API
Enable the gateway API.

```
--set gatewayAPI.enabled=true
--set gatewayAPI.enableAlpn=true
--set gatewayAPI.enableAppProtocol=true
```

# L2 Loadbalancer pool
In the cluster we are using the cilium l2 annoucement and pool functionality. It is in beta but works very good. The pool is set up from 192.168.1.16 up to and including 192.168.1.31. Any service that requires an IP from this pool must then set the label ***stenlund.se/pool: stenlund-se-pool***. The ip must then be announced and the policy is set up to annouce both external and loadbalancer IP:s and also requires that the label ***stenlund.se/pool: stenlund-se-pool*** is set.


See ***lb.yaml*** in the root directory of the cilium deployment for more details on how it is setup.
