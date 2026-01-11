helm template longhorn \
    longhorn/longhorn --namespace longhorn-system --version 1.10.1 > longhorn.yaml
kubectl apply -f longhorn.yaml