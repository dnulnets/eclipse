helm template cilium/cilium --version 1.18.5 \
  --namespace=kube-system \
  --kube-version v1.34.1 \
  --set preflight.enabled=true \
  --set agent=false \
  --set operator.enabled=false \
  --set k8sServiceHost=localhost \
  --set k8sServicePort=7445 \
  > cilium-preflight.yaml
  kubectl create -f cilium-preflight.yaml
