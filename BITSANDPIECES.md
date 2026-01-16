# Bits and pieces
This just contains some commands that I have a hard time to remember.
## Kubernetes
Commands for handling kubernetes.
### Delete all pods in unknown state

```
kubectl get pods --all-namespaces | grep ContainerStatusUnknown | awk '{print "kubectl delete pod "$2" -n "$1}' | sh
```

### Remove everything from a namespace and then delete the namespace

See ***clean_na.sh*** in the ***script*** directory, it originates from the location describe below.

```
Oracle Consulting Netherlands
2024-05-11, M. van den Akker, Initial Creation
https://github.com/makker-nl/Kubernetes/tree/main/scripts
```

### Untaint nodes
If needed, I had to use this when I experimented with cilium during installation and it go into some strange state where some of the nodes got tainted. So it had to be removed.

```
kubectl taint nodes  talos-3p1-gvn node.kubernetes.io/network-unavailable-
```

## Talos
Commands for handling the talos installation.
### List files
```
talosctl ls -r /usr/local -n 192.168.1.116
```
### Check what extensions are installed
```
talosctl get extensions -n 192.168.1.116
```
### Upgrade
```
talosctl upgrade -n 192.168.1.75 --image factory.talos.dev/metal-installer/613e1592b2da41ae5e265e8789429f223234ab91cb4deb6bc3c0b6262961245:v1.11.5
```

