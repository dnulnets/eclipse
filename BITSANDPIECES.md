# Bits and pieces

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


