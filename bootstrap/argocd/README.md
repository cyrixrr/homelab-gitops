# Argo CD Bootstrap

Argo CD is installed with Helm as the initial GitOps bootstrap component.

## Helm Chart

Repository:

https://argoproj.github.io/argo-helm

Chart:

argo/argo-cd

Current installation:
- Namespace: argocd
- Ingress host: argocd.home.arpa
- Ingress controller: Traefik
- Traefik LoadBalancer IP: 192.168.0.20
- Argo CD server service type: ClusterIP

## Install / Upgrade

Run from the repository root:

powershell.exe -ExecutionPolicy Bypass -File .\bootstrap\argocd\install.ps1

The script uses Helm upgrade/install to install or update Argo CD.

## DNS

The local DNS record is managed in Pi-hole:

| Hostname | IP |
|---|---:|
| argocd.home.arpa | 192.168.0.20 |

## Access

URL:

http://argocd.home.arpa

Initial login:
- Username: admin
- Initial password is stored in argocd-initial-admin-secret

After first login:
- Change the admin password.
- Delete the initial secret.

Command:

kubectl -n argocd delete secret argocd-initial-admin-secret

## Architecture

Helm -> Argo CD bootstrap -> GitOps applications -> Kubernetes
