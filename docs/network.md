# HomeLab Network

## LAN

Network: `192.168.0.0/24`

Main router:
- IP: `192.168.0.1`
- DNS configured to use Pi-hole: `192.168.0.200`

## Proxmox

Proxmox UI:
- `https://192.168.0.11:8006`

Role:
- Virtualization host
- Runs supporting homelab services
- Current service: Pi-hole
- Future DevOps services: GitHub Actions runners, registry, backup, logging, Vault, test VMs

## DNS

Pi-hole:
- IP: `192.168.0.200`
- Used as LAN DNS resolver through the router configuration

Local DNS records:

| Hostname | IP | Purpose |
|---|---:|---|
| `argocd.home.arpa` | `192.168.0.20` | Argo CD via Traefik |
| `grafana.home.arpa` | `192.168.0.20` | Grafana via Traefik |
| `prometheus.home.arpa` | `192.168.0.20` | Prometheus via Traefik |
| `alertmanager.home.arpa` | `192.168.0.20` | Alertmanager via Traefik |
| `demo.home.arpa` | `192.168.0.20` | Demo app via Traefik |

## Kubernetes Nodes

| Node | IP | Role |
|---|---:|---|
| `minisforum` | `192.168.0.100` | control-plane, etcd |
| `hp-prodesk-1` | `192.168.0.101` | control-plane, etcd |
| `hp-prodesk-2` | `192.168.0.102` | control-plane, etcd |
| `dell-optiplex-1` | `192.168.0.103` | worker |

## Kubernetes Virtual IPs

| IP | Component | Purpose |
|---:|---|---|
| `192.168.0.10` | kube-vip | Kubernetes API HA endpoint |
| `192.168.0.20` | Traefik | HTTP/HTTPS ingress |
| `192.168.0.21+` | MetalLB | LoadBalancer services |

## Kubernetes Internal Networks

| Network | Purpose |
|---|---|
| `10.42.0.0/16` | Pod network |
| `10.43.0.0/16` | Service network |

## Traffic Flow

### Kubernetes API

`kubectl -> 192.168.0.10:6443 -> kube-vip -> active control-plane node -> Kubernetes API`

### Web Apps through Traefik

`Browser -> Pi-hole DNS -> argocd.home.arpa -> 192.168.0.20 -> Traefik -> Kubernetes Service -> Pod`

### LoadBalancer Service through MetalLB

`Client -> 192.168.0.21+ -> MetalLB -> Kubernetes Service -> Pod`

## Important Notes

- `192.168.0.20` is the shared HTTP/HTTPS entry point for Traefik.
- Most web applications should use DNS records pointing to `192.168.0.20`.
- MetalLB IPs should not overlap with the DHCP pool.
- Pi-hole should be the central place for local DNS records.
