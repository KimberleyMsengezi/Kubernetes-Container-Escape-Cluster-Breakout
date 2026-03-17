#!/bin/bash
echo "============================================================="
echo "🚀 Kubernetes Container Escape & Cluster Breakout "
echo "============================================================="
echo ""
echo "Starting Minikube cluster (Kubernetes 1.32)..."
minikube start --kubernetes-version=1.32.0 --driver=docker --memory=4096 --cpus=2

echo ""
echo "Deploying privileged escape pod..."
kubectl apply -f setup/combined-escape-pod.yaml

echo ""
echo "✅ Setup complete!"
echo "Next steps:"
echo "   kubectl get pods"
echo "   kubectl exec -it escape-pod -- bash"
echo "   Then inside the pod run: bash /exploits/escape-demo.sh"
echo "============================================================="
