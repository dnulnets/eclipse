helm template kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --kube-version v1.34.1 --version 7.14.0 --create-namespace --namespace kubernetes-dashboard > dashboard.yaml
