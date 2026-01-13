helm template sealed-secrets --version 2.18.0 -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets > sealed-secrets.yaml
kubectl apply -f sealed-secrets.yaml
