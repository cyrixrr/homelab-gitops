# HomeLab GitOps

This repository contains the GitOps configuration for the home Kubernetes platform.

## Cluster

k3s HA cluster with:
- 3 control-plane/etcd nodes
- 1 worker node
- kube-vip for Kubernetes API HA
- MetalLB for LoadBalancer services
- Traefik for HTTP/HTTPS ingress
- Pi-hole for local DNS

## Main Components

| Component | Purpose |
|---|---|
| kube-vip | Kubernetes API virtual IP |
| MetalLB | LAN LoadBalancer IPs |
| Traefik | HTTP/HTTPS ingress |
| Argo CD | GitOps deployment |
| Helm | Kubernetes package management |
| Pi-hole | Local DNS |
| Proxmox | Supporting DevOps infrastructure |

## Important IPs

| IP | Purpose |
|---:|---|
| 192.168.0.1 | Router |
| 192.168.0.10 | kube-vip Kubernetes API |
| 192.168.0.11 | Proxmox |
| 192.168.0.20 | Traefik LoadBalancer |
| 192.168.0.21+ | MetalLB services |
| 192.168.0.200 | Pi-hole DNS |

## Repository Structure

bootstrap/
  argocd/

clusters/
  home/
    namespaces/
    platform/
    apps/

apps/
  devops-demo-api/

docs/
  network.md

## Bootstrap Order

1. Install or verify k3s cluster.
2. Configure kube-vip.
3. Configure MetalLB.
4. Verify Traefik LoadBalancer IP.
5. Configure Pi-hole local DNS.
6. Install Argo CD with Helm.
7. Create Argo CD root application.
8. Deploy applications through GitOps.
