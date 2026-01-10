istioctl install --set profile=ambient --set values.pilot.env.PILOT_ENABLE_ALPHA_GATEWAY_API=true

istioctl manifest generate --set profile=ambient --set values.pilot.env.PILOT_ENABLE_ALPHA_GATEWAY_API=true

apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: istio-system
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/enforce-version: latest
  name: istio-system
