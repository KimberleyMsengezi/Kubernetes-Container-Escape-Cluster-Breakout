# Kubernetes Container Escape & Cluster Breakout

![Kubernetes](https://img.shields.io/badge/Kubernetes-1.32-blue) 
![Red Team](https://img.shields.io/badge/Red_Team-2026-red) 
![MITRE ATT&CK](https://img.shields.io/badge/MITRE_ATT%26CK-Mapped-green)

Edge-cutting offensive security project demonstrating the exact kill-chain used by advanced threat actors against cloud-native Kubernetes environments in the UAE and global financial sectors.

### Executive Summary
Complete real-world attack chain:  
**Privileged pod → host filesystem escape → kernel namespace breakout → etcd secret theft → full cluster-wide compromise**  
All techniques executed in an isolated Minikube environment and fully reproducible.

### Technical Deep Dive (Attack Techniques)

1. **Privileged + hostPath + hostPID Pod**  
   Container runtime isolation is completely bypassed by combining `privileged: true`, `hostPath: /` and `hostPID: true`. This gives immediate root access to the underlying node.

2. **chroot Escape via Mounted Host Filesystem**  
   `chroot /host` instantly pivots the entire root filesystem to the real node, defeating all container boundaries.

3. **nsenter Namespace Breakout **  
   `nsenter --target 1 --mount --uts --ipc --net --pid` enters the host’s PID 1 namespace, escaping cgroups, network policies, SELinux/AppArmor and runtime security controls — technique featured at Black Hat 2025 and DEF CON Cloud Village 2026.

4. **etcd Secret Exfiltration & Cluster Takeover**  
   Direct read access to `/var/lib/etcd/member/snap/db` extracts all service-account tokens, kubeconfigs and TLS certificates, allowing deployment of new cluster-admin pods from anywhere.

5. **Simulated runC Symlink Manipulation**  
   Safe demonstration of CVE-2025-31133 style arbitrary host file writes.

### Attack Chain Visualization

```mermaid
graph TD
    A[Deploy Privileged Pod] --> B[hostPath Mount]
    B --> C[chroot /host]
    C --> D[nsenter Host Namespace]
    D --> E[etcd Secret Theft]
    E --> F[Extract Tokens]
    F --> G[Deploy Rogue Cluster-Admin Pod]
    G --> H[Full Cluster Compromise]
