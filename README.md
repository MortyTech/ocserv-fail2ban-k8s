# OpenConnect / Fail2Ban on K8S Deployment
**2022 OCT UPDATE**: We dockerized and added Dockerfile to run it anywhere you want on any linux distro easily.

**2026 Mar UPDATE**: I added manage script as configmap in /etc/ocserv for manage user easily

Use Valid real certificate file for smooth connection on client 
dont forget or create certificate :
```bash
kubectl create secret tls ocserv-tls-secret   --cert=fullchain.pem   --key=privkey.pem
```

All Client can use openconnect Package and on Windows Use [OpenconnectGUI](https://gui.openconnect-vpn.net) 

I used NodePort on my K8S cluster to expose ocserv on Internet and Protect it against bruteforce attack by Fail2Ban container by [Crazymax](https://github.com/crazy-max)

I Used a PVC for /etc/ocserv on ocserv container for user and data persistency


Create ocserv-mgmt.sh and ocserv.conf file directly by kubectl create command
```bash
kubectl create configmap ocserv-config   --from-file=ocserv.conf
kubectl create configmap ocserv-mgmt   --from-file=ocserv-mgmt.sh
```
I used _cluster.local_ in **default-domain** into ocserv.config file for access to K8s cluster domain
and set "dns =" to ClusterIP of my Coredns service to fully resolve my Kubernetes cluster internal domain name
and route all 10.0.0.0/8 IP for access all pods and svc in K8s cluster
