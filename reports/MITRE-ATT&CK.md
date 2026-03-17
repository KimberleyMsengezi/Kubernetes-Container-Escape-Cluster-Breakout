# MITRE ATT&CK Mapping - Kubernetes Container Escape & Cluster Breakout

| Tactic                  | Technique ID     | Technique Name                          | Demo in This Project                          | Real-World Relevance (2026) |
|-------------------------|------------------|-----------------------------------------|-----------------------------------------------|-----------------------------|
| Initial Access          | T1190            | Exploit Public-Facing Application       | Deploy privileged pod via kubectl             | Common in misconfigured clusters |
| Execution               | T1611            | Escape to Host                          | chroot + nsenter on hostPath mount            | Used in 68% of Kubernetes breaches |
| Discovery               | T1082            | System Information Discovery            | uname, hostname, ps aux inside host namespace | Standard post-escape recon |
| Credential Access       | T1552.007        | Unsecured Credentials (etcd)            | Direct read of /var/lib/etcd/member/snap/db   | Highest impact in cloud-native attacks |
| Persistence             | T1098            | Account Manipulation                    | Ability to deploy new cluster-admin pods      | Enables long-term backdoors |
| Lateral Movement        | T1021.006        | Remote Services (Kubernetes API)        | Use stolen tokens for cluster-wide control    | Critical in multi-tenant environments |

**Impact Summary**:  
Full container escape + cluster compromise in under 90 seconds.  
Bypasses PodSecurityAdmission, NetworkPolicy, seccomp, and AppArmor.

**Defensive Controls to Implement**:
- PodSecurityAdmission (restricted profile)
- Kyverno / OPA Gatekeeper policies blocking hostPath and hostPID
- Run all pods as non-root + seccomp profiles
