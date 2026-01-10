
kubectl create ns longhorn-system
kubectl label ns longhorn-system pod-security.kubernetes.io/enforce=privileged

helm template --dry-run=server \
    longhorn \
    longhorn/longhorn --namespace longhorn-system --version 1.10.1
    
    
