helm template \
  cert-manager oci://quay.io/jetstack/charts/cert-manager \
  --version v1.19.2 \
  --namespace cert-manager \
  --create-namespace \
  --kube-version v1.34.1 \
  --set config.enableGatewayAPI=true \
  --set config.apiVersion="controller.config.cert-manager.io/v1alpha1" \
  --set config.kind="ControllerConfiguration" \
  --set crds.enabled=true > cert-manager.yaml
kubectl apply -f cert-manager.yaml
