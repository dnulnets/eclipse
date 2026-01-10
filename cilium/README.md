# Eclipse cilium configuration

This is the configuration and changes needed to run cilium on a talos kubernetes cluster. It is configured to run
with L2-announcement and a loadbalancer ip-pool, together with istio in ambient mode and with no kube-proxy.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the cilium root directory such as the loadbalancer ip-pool and L2-accouncement.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration
The needed configuration are supplied to helm when generating the templae yaml file. See the ***install.sh*** or ***upgrade.sh*** scripts in each install or upgrade directory for how it is set up.

The controlplane must not have the kube-proxy and default cni (which is flannel) installed. They have to be removed from the machine configuration of the control nodes and the kube-proxy and flannel deployments have to be removed from the cluster. They are usually installed by default during the startup/installation of the cluster unless you did the modifications beforehand.

Patch the machine configuration with the following:

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
Sets the version and namespace for the cilium platform. Helm do not autodetect the kubernetes version when generating the template, so we need to set it manually. Make sure it is the version used by talos. You can use ***talosctl dashboard -n IP*** command to view the version of the kube-system.

```
--version 1.18.4
--namespace kube-system
--kube-version v1.34.1
--set tls.secretsNamespace.create=false
```

### Configuring for istio
The cluster runs cilium with kube-proxy removed so cilium will fully replaces it. To make it work with istio the following configurations needs to be done. I have used recommendations from both cilium and istio on the settings. Also if you are using BPF make sure that ***bpf.masquerade=false***. It is the default in cilium.

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
To make use of ciliums loadbalancer ip-pool we have to enable L2-announcement and increase the rate limits for qps and burst,

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

# Loadbalancer IP-pool
In the cluster we are using the cilium L2-annoucement and pool functionality. It is in beta but works very good. The pool is set up from 192.168.1.16 up to and including 192.168.1.31 in the ***lb.yaml*** file. Any service that requires an IP from this pool must set the label ***stenlund.se/pool: stenlund-se-pool***. The L2-announcement uses the same label.
