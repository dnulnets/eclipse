helm template --dry-run=server \
--
helm template \
    cilium \
    cilium/cilium \
    --version 1.18.4 \
    --namespace kube-system \
    --kube-version v1.34.1 \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445 \
    --set socketLB.hostNamespaceOnly=true \
    --set cni.exclusive=false \
    --set l2announcements.enabled=true \
    --set k8sClientRateLimit.qps=50 \
    --set k8sClientRateLimit.burst=200 \
    --set gatewayAPI.enabled=true \
    --set gatewayAPI.enableAlpn=true \
    --set tls.secretsNamespace.create=false \
    --set gatewayAPI.enableAppProtocol=true > cilium-ambient.yaml