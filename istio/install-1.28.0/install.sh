istioctl manifest generate --set profile=ambient --set values.pilot.env.PILOT_ENABLE_ALPHA_GATEWAY_API=true > generated-manifest.yaml
kubectl apply -f generated-manifest.yaml
