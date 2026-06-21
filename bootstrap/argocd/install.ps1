helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install argocd argo/argo-cd `
  --namespace argocd `
  --values .\bootstrap\argocd\values.yaml `
  --wait `
  --timeout 10m

kubectl -n argocd get pods
kubectl -n argocd get svc
kubectl -n argocd get ingress