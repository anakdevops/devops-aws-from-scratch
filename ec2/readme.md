```
copy output disini
ec2_private_ips = [
  "172.31.34.169",
  "172.31.34.156",
]
ec2_public_ips = [
  "47.129.200.40",
  "13.212.137.132",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@47.129.200.40
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.212.137.132
```

```
pastikan ssh ke semua server
sudo su
cat /home/serverdevops/cluster.yml #pastikan file sudah ada
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDU2RiOmJbgs/6FJH5qBEskT7wCc3ry4swbKvnaGsuB3+rhqWsIDpZovA1d+VOz6X+v+U9Qx27l25BJgUXRlONGse7jL79sx2UP8U2ycV950p52ubCKX+tQ+Zk+Z/yjuu+VRtG0ILshcg+78s28c1hynkVri+XIFu36mTOR/Wim+FIttP3FmJyV9QeThsnrOelOHfLHKBSrKJpeBNBWmEHLIylr5X8aGFHlKJxO0MnuRQqK7TmjYY2bOPkCPocukyhkaau3NizdK9k5Sp2rMggTl0ZitMWidcVnaj6W4zOE/pUPVglYyD5RmAa3Wa81Rj4idcBAHJY2WRhI52BeLlMb ansible-generated on ip-172-31-34-169" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKW01xt3eJQWJK+pkIRe9oMxPZYPfoDu3L1ya9ZPULeIvhq5hvdh6ailiXU0tj5dQbfl9apUEG6xRh44+tF0arVLbSDpJGJ+eRPPccjdaoVJoagIjf8pPkLDlyO929K0BF2splDVoMpnlE/CcdjKAKpd1Oo3mCKR0dtH09p7F6dw7ZQExyPZVfrPFlePQHBwE3/7kJiFE/xlkVXqgjkTmnjM6TgfTzLJa4Da+ZpfIImCedZLR/ntic+g7I4sKbo+M1jI1pd3x0AR72I9zveRBBXB4oYuc5YUoG/vv9+VE7V/PanT+x3brzUQrzXUVYeP82zKv9cQtGxI6lsUObE2Qt ansible-generated on ip-172-31-34-156" >> ~/.ssh/authorized_keys #copy ke semua server
ssh serverdevops@172.31.34.169
ssh serverdevops@172.31.34.156
```

```
cd /home/serverdevops/
nano cluster.yml #sesuaikan ip (hanya edit di server 1)
```

```
cek di semua server
docker --version
docker compose version
helm version
```

```
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=clusterkube.anakdevops.online
helm list --namespace cattle-system
kubectl -n cattle-system get deploy rancher
kubectl scale --replicas=1 deployment rancher -n cattle-system #scale down
kubectl -n cattle-system get deploy rancher -w
```


