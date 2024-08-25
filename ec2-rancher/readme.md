# Singe Node | RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
copy output disini
ec2_private_ips = [
  "172.31.30.54",
  "172.31.45.70",
]
ec2_public_ips = [
  "13.215.201.93",
  "54.169.212.222",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.215.201.93
```


```
pastikan ssh ke semua server
sudo su
rke config -l
rke -v
rke config --list-version --all
ll /home/serverdevops/cluster.yml #pastikan file sudah ada dan lanjutkan ke perintah berikut
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCep2SOYMefqD3rG3GDXoOVAQEAPjg5Es0r4Zm0huU3LqQBDDZA34Q8jcK5XGlvk5o/8wLUMc9TT+jYqj7hI9S0bZd3xKRFdeTpFPkQTIKzjaZSWaSJxbLTXLcK4efJhGiOHt0N0FWRP/O87NROUweCXGb7MDla9nG16kRctyYHKrvQZUhH2DayJSe+WXx8NBhXWyr1RoDIqhZ1yZlc2x5Yw1vX+WPGnXWJP593JrvyPCfudkEyZPx/JOpU8sEvfVl9GuMqtkW+JSkddfs1Od46jVQWU8SkzUrKBi/j8pHDjzNZZL3kqCzAGJWTOfZf+qUF8njFu1XFypAFMHg1Yq9T ansible-generated on ip-172-31-30-54" >> ~/.ssh/authorized_keys #copy ke semua server


copy output disini
ec2_private_ips = [
  "172.31.30.54",
  "172.31.45.70",
]
ec2_public_ips = [
  "13.215.201.93",
  "54.169.212.222",
]
ssh serverdevops@172.31.39.11
ssh serverdevops@172.31.44.115
```


```
cek di semua server
docker --version
docker compose version
helm version
```

```
cd /home/serverdevops/
nano cluster.yml #sesuaikan ip (hanya edit di server 1)
```


```
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```


```
jalankan di server 1
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rnchr.anakdevops.online
kubectl -n cattle-system get deploy rancher
kubectl -n cattle-system get deploy rancher -w
```

# Add Node | RKE v 1.6.1 | Upgrade Kubernetes v1.27.16 to v1.28.12 (v1.28.12-rancher1-1) | rancher v2.8.5


```
ssh -i security_groups/keypair_anakdevops.pem ubuntu@54.169.212.222
sudo su
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3Uf0MKMuPWsRg2ph5ov0SSh1K4iwypNXjTgmwG9l4t2g6rMMBjzLNZAODsohOZDhw+DiwFnr/gN+DDpS7llilMPMRaJ1u9BjcVjURJuZy9f+cmPqPH3rCRi8cRja58JMJZe8551FPyRTNeOcYpauERhRCmxjM+4X6TLDjC1qdHRGvWcoiD/VY9zILy3p55qShRCH9dDINaCRxrbwB6MgudxsoWCmuTOef65loDoTWWiB+SjLiLadnBwApk10icxz9p/JbCZ5ifFlqZtM20feYcEG6dj4bRaIfsqcYIezcDbbdFJ3JGKCa0k/ji5aROfuX9E+kP0VovJt5s+T4fEJL ansible-generated on ip-172-31-45-70" >> ~/.ssh/authorized_keys #copy ke semua server
ssh serverdevops@172.31.30.54
ssh serverdevops@172.31.45.70
```

```
Node 1
```
cd /home/serverdevops/
nano cluster.yml #tambahkan ip node 2
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```


```
troubleshoot
kubectl scale --replicas=1 deployment rancher -n cattle-system #scale down
kubectl -n cattle-system get deploy rancher -w
sudo echo 1 > /proc/sys/vm/drop_caches
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --set webhook.timeoutSeconds=30
kubectl get pods -n cert-manager
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
kubectl get pods -n kube-system
helm uninstall rancher --namespace cattle-system
helm list --namespace cattle-system
helm list --namespace cert-manager
helm uninstall cert-manager --namespace cert-manager
kubectl get pods -n ingress-nginx
kubectl get pods -n cert-manager
kubectl get svc -n ingress-nginx
kubectl get svc -n cert-manager
```

